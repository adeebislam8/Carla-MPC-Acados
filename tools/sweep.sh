#!/usr/bin/env bash
# Parameter sweep for the nominal MPCC.
#
# Edit the CONFIGS block below, run, and it benchmarks every configuration in
# turn and prints one comparison table at the end.  Each config is a label
# followed by whatever flags benchmark_mpcc.py accepts, so anything exposed
# there can be swept without touching Python.
#
#   ./tools/sweep.sh                 # run the sweep
#   ./tools/sweep.sh --dry-run       # print what it would do, run nothing
#   ./tools/sweep.sh --compare-only  # re-print the table from existing results
#
# Requires a CARLA server already running.  Roughly 13 min per config at the
# default 3 seeds x 20 episodes, so a 4-config sweep is about an hour.

set -euo pipefail
cd "$(dirname "$0")/.."

# ---------------------------------------------------------------- CONFIGS ---
# "label|extra flags"   -- the label names results/<label>.{json,txt}
# Keep a no-flag baseline first so every sweep has its own reference point
# measured in the same session, rather than compared against an older run.
CONFIGS=(
  "b0_Town01|--town Town01"
  "b0_Town02|--town Town02"
  "b0_Town03|--town Town03"
)

# Cross-town NOMINAL MPCC only (no --model, so the action is always [0,0]).
#
# This is the experiment that decides whether the residual study is worth
# running.  The paper's claim is that MPCC degrades under distribution shift and
# the residual recovers it -- so what matters is the GAP between the training
# town and the others, not the in-distribution number.
#
# At route-max 150 the Town01 baseline is ~18% collisions, which leaves little
# headroom: at 150 episodes the residual would have to remove half of what
# remains (18% -> 10%) before the difference is detectable.  If Town02/03
# degrade sharply there is plenty of room and the experiment has signal.  If
# they do not, the route bound has made the task too easy to show anything, and
# a controlled shift axis (the r3 / C_m1 / friction / delay perturbations in
# spec sections 16.2-16.5) is the better experiment -- those give a CONTINUOUS
# severity knob rather than three towns differing by an unknown amount.

COMMON="--seeds 1 2 3 4 5 --episodes 30 --route-max 150 --qc 0.5 --gate-depth 0.98"

# Set to 1 to keep each config's solver diagnostics in diagnostics_<label>/
KEEP_DIAGNOSTICS=1
# -----------------------------------------------------------------------------

DRY=0; COMPARE_ONLY=0
for a in "$@"; do
  case "$a" in
    --dry-run) DRY=1 ;;
    --compare-only) COMPARE_ONLY=1 ;;
    *) echo "unknown option: $a"; exit 1 ;;
  esac
done

LABELS=()
FAILED=()
IDX=0
for cfg in "${CONFIGS[@]}"; do LABELS+=("${cfg%%|*}"); done

if [ "$COMPARE_ONLY" -eq 0 ]; then
  echo "=================================================================="
  echo "SWEEP: ${#CONFIGS[@]} configs x ${COMMON}"
  echo "=================================================================="
  START=$(date +%s)

  for cfg in "${CONFIGS[@]}"; do
    label="${cfg%%|*}"
    flags="${cfg#*|}"

    IDX=$((IDX + 1))
    NOW=$(date +%s); ELAPSED=$((NOW - START))
    if [ "$IDX" -gt 1 ]; then
      PER=$((ELAPSED / (IDX - 1)))
      ETA=$(( PER * (${#CONFIGS[@]} - IDX + 1) ))
      ETA_TXT=$(printf "%dm" $((ETA / 60)))
    else
      ETA_TXT="?"
    fi
    echo
    echo "=================================================================="
    echo ">>> [${IDX}/${#CONFIGS[@]}] ${label}   ${flags:-(defaults)}"
    echo "    elapsed $((ELAPSED / 60))m   remaining ~${ETA_TXT}"
    echo "=================================================================="
    [ "$DRY" -eq 1 ] && { echo "    (dry run)"; continue; }

    # Fresh diagnostics dir per config so runs are not mixed together.
    rm -rf diagnostics
    # Do not let one bad config abort the sweep.  Without this, `set -e` kills
    # the run and the remaining configs plus the final comparison are lost --
    # potentially hours of driving.  Failures are reported and skipped instead.
    # shellcheck disable=SC2086
    if python tools/benchmark_mpcc.py --label "$label" $COMMON $flags \
         2>&1 | tee "results/${label}.log"; then
      :
    else
      echo "!!! ${label} FAILED (see results/${label}.log) -- continuing"
      FAILED+=("$label")
    fi

    if [ "$KEEP_DIAGNOSTICS" -eq 1 ] && [ -d diagnostics ]; then
      rm -rf "diagnostics_${label}"
      mv diagnostics "diagnostics_${label}"
      echo
      echo "--- solver diagnostics: ${label} ---"
      python tools/analyze_solver_failures.py "diagnostics_${label}/" --top 0 \
        2>&1 | sed -n '/FRENET CONVERTER/,/^$/p;/^FAILURES/p' || true
    fi
  done

  if [ "$DRY" -eq 0 ]; then
    echo
    echo "sweep finished in $((($(date +%s)-START)/60)) min"
    [ "${#FAILED[@]}" -gt 0 ] && echo "FAILED configs: ${FAILED[*]}"
  fi
fi

[ "$DRY" -eq 1 ] && exit 0

# ------------------------------------------------------------- COMPARISON ---
JSONS=()
for l in "${LABELS[@]}"; do
  [ -f "results/${l}.json" ] && JSONS+=("results/${l}.json")
done

if [ "${#JSONS[@]}" -lt 2 ]; then
  echo "need at least 2 completed configs to compare (found ${#JSONS[@]})"
  exit 0
fi

echo
python tools/benchmark_mpcc.py --compare "${JSONS[@]}"
echo "per-config reports: results/<label>.txt   logs: results/<label>.log"

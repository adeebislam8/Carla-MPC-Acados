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
  "len_unbounded|"
  "len_150|--route-max 150"
  "len_100|--route-max 100"
  "len_075|--route-max 75"
)

# Route length is difficulty.  An episode is pass/fail over the WHOLE route, and
# only a 50 m MINIMUM was enforced -- no maximum -- so routes ran from 50 m to
# the map diagonal.  At roughly 12% failure per junction, one junction gives 88%
# episode success and eight gives 36%, purely from length.
#
# That variance has been swamping every measurement: in the last sweep the
# seed-to-seed spread on one config was 23 points, larger than any difference
# BETWEEN configs.  Shorter, bounded routes should raise the success rate and --
# more importantly for the paper -- shrink the variance enough that a 10-point
# difference becomes detectable at all.
#
# Watch the "route length" line in each report to confirm the cap is binding,
# and the per-seed table to see whether the spread actually narrows.

# Applied to every config.  Same seeds and town for all of them, or the
# comparison is meaningless.
# Controller config held fixed at `hold` from the 2026-09-15 sweep.
#
#   hold  30.67% success / 64.67% collisions / 0.92 overtakes per episode
#   both  33.33% success / 62.67% collisions / 0.76 overtakes
#
# `both` was nominally better on success and collisions, but by 2.7 and 2.0
# points with nothing separating statistically (p = 0.18 vs base for `both`,
# 0.32 for `hold`), while `hold` overtakes 21% more often.  Overtaking is the
# behaviour the paper needs to demonstrate -- the CBF-derived residual authority
# has nothing to show if the barrier is never near-active -- so the overtake
# rate is worth more than an unresolvable 2-point success difference.
#
# The difference between them is the `slow` half (--lookahead 20 --r3-cap 0.06),
# which slows the virtual reference in bends and costs passes.  Add those two
# flags back to return to `both`.
COMMON="--seeds 1 2 3 --episodes 20 --qc 0.5 --gate-depth 0.98"

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

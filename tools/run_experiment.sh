#!/usr/bin/env bash
# Train the residual policy, then evaluate the full ablation across towns.
#
# Designed to run unattended overnight: one config failing does not abort the
# rest, everything is logged to results/, and the comparison tables are written
# to disk as well as printed.
#
#   ./tools/run_experiment.sh                  # train + evaluate
#   ./tools/run_experiment.sh --eval-only      # skip training, use existing models
#   ./tools/run_experiment.sh --dry-run        # print the plan, run nothing
#
# Requires a CARLA server already running.  Rough cost at the defaults:
# 2 algos x 300k steps is the bulk (several hours), evaluation adds
# ~12 min per (arm x town).

set -uo pipefail            # NOT -e: a failed arm must not kill the night
cd "$(dirname "$0")/.."

# ------------------------------------------------------------------ CONFIG ---
# Algorithms to train.  TD3 first: no entropy bonus pushing the residual away
# from zero, which is the right bias for a correction that should be small
# unless it helps.  SAC second with a small fixed ent-coef for comparison.
ALGOS=("td3" "sac")
TIMESTEPS=300000

# Nominal controller.  MUST match between training and evaluation -- a residual
# learns "given THIS nominal behaviour, what correction helps", so training it
# against a different MPCC config makes it invalid.
CONTROLLER="--qc 0.5 --gate-depth 0.98"

TRAIN_TOWN="Town01"                 # train on ONE town; cross-town IS the shift
EVAL_TOWNS=("Town01" "Town02" "Town03")
# 5 seeds x 30 episodes = 150 per arm per town.  60 episodes could not resolve
# anything in the MPCC sweeps -- four configs landed between 61.7% and 70.7%
# with p = 0.32..0.85, and the seed-to-seed spread on a single config was 23
# points.  The ablation has to resolve B0 vs B5, so the sample size has to be
# able to see an effect of that size.
EVAL="--seeds 1 2 3 4 5 --episodes 30"

# Ablation arms per town:  label | extra flags
#   b0  nominal MPCC, no residual          (the baseline everything is measured against)
#   b2  fixed residual scale               (the previous architecture)
#   b5  CBF-derived adaptive authority     (Contribution 1)
ARMS=(
  "b0|"
  "b2|--residual-mode fixed"
  "b5|--residual-mode adaptive"
)
# ------------------------------------------------------------------------------

DRY=0; EVAL_ONLY=0
for a in "$@"; do
  case "$a" in
    --dry-run)   DRY=1 ;;
    --eval-only) EVAL_ONLY=1 ;;
    *) echo "unknown option: $a"; exit 1 ;;
  esac
done

mkdir -p results models
START=$(date +%s)
FAILED=()
run() {  # run <description> <command...>
  echo; echo "=================================================================="
  echo ">>> $1"
  echo "    elapsed $((($(date +%s)-START)/60))m"
  echo "=================================================================="
  shift
  if [ "$DRY" -eq 1 ]; then echo "    (dry run) $*"; return 0; fi
  if "$@"; then return 0; else
    echo "!!! FAILED: $* -- continuing"; FAILED+=("$*"); return 1
  fi
}

# ---------------------------------------------------------------- TRAINING ---
if [ "$EVAL_ONLY" -eq 0 ]; then
  for algo in "${ALGOS[@]}"; do
    # shellcheck disable=SC2086
    run "TRAIN ${algo} (${TIMESTEPS} steps, ${TRAIN_TOWN})" \
      python tools/train_residual.py --label "${algo}_v1" --algo "$algo" \
        --timesteps "$TIMESTEPS" --town "$TRAIN_TOWN" $CONTROLLER \
        2>&1 | tee "results/train_${algo}_v1.log"
  done
fi

# -------------------------------------------------------------- EVALUATION ---
for algo in "${ALGOS[@]}"; do
  MODEL="models/${algo}_v1/final.zip"
  if [ "$DRY" -eq 0 ] && [ ! -f "$MODEL" ]; then
    echo "!!! no model at ${MODEL} -- skipping ${algo} evaluation"
    FAILED+=("eval ${algo}: model missing"); continue
  fi

  for town in "${EVAL_TOWNS[@]}"; do
    JSONS=()
    for arm in "${ARMS[@]}"; do
      name="${arm%%|*}"; flags="${arm#*|}"
      label="${algo}_${name}_${town}"

      # b0 is the nominal controller: no --model, action is always [0,0].
      # It is identical for every algo, so compute it once and reuse.
      if [ "$name" = "b0" ]; then
        label="b0_${town}"
        [ -f "results/${label}.json" ] && { JSONS+=("results/${label}.json"); continue; }
        MODEL_FLAGS=""
      else
        MODEL_FLAGS="--model ${MODEL} --algo ${algo}"
      fi

      # shellcheck disable=SC2086
      run "EVAL ${label}" \
        python tools/benchmark_mpcc.py --label "$label" --town "$town" \
          $EVAL $CONTROLLER $MODEL_FLAGS $flags \
          2>&1 | tee "results/${label}.log"
      [ -f "results/${label}.json" ] && JSONS+=("results/${label}.json")
    done

    if [ "$DRY" -eq 0 ] && [ "${#JSONS[@]}" -ge 2 ]; then
      echo; echo "--- ABLATION: ${algo} on ${town} ---"
      python tools/benchmark_mpcc.py --compare "${JSONS[@]}" \
        | tee "results/ablation_${algo}_${town}.txt"
    fi
  done
done

echo
echo "=================================================================="
echo "finished in $((($(date +%s)-START)/60)) min"
[ "${#FAILED[@]}" -gt 0 ] && { echo "FAILED steps:"; printf '   %s\n' "${FAILED[@]}"; }
echo
echo "per-town ablations : results/ablation_<algo>_<town>.txt"
echo "per-run reports    : results/<label>.txt"
echo "models             : models/<algo>_v1/final.zip"
echo "=================================================================="

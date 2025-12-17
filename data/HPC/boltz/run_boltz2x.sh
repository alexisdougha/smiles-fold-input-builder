#!/bin/bash

#SBATCH -p cmpli

#SBATCH --mem=64GB
#SBATCH --gres=gpu:a100_7g.80gb:1

#SBATCH --output=boltz2x.out
#SBATCH --error=boltz2x.err
#SBATCH --job-name=Boltz2x

module load boltz/2.1.1-rpbs

boltz predict /shared/projects/antioxydant/pep_edit/structure_prediction/boltz/inputs \
      --cache /shared/projects/antioxydant/test_af/fold_with_boltz/cache \
      --out_dir /shared/projects/antioxydant/pep_edit/structure_prediction/boltz/out \
      --model boltz2 \
      --diffusion_samples 25 \
      --use_potentials

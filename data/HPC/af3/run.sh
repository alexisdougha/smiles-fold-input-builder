#!/bin/bash

#SBATCH -A deorphaning
#SBATCH -p ipop-up 
#SBATCH -o AF3_fold.out
#SBATCH -e AF3_fold.err
#SBATCH --job-name=AF3

#SBATCH --mem=64GB
#SBATCH --gres=gpu:a100_7g.80gb:1

module load alphafold/3.0.1

export AF3_RESOURCES_DIR=/shared/projects/antioxydant/test_af/fold_with_af3

export AF3_IMAGE=/shared/software/singularity/images/alphafold-3.0.1.sif
export AF3_CODE_DIR=${AF3_RESOURCES_DIR}/code
export AF3_INPUT_DIR=/shared/projects/antioxydant/pep_edit/structure_prediction/af3/inputs
export AF3_OUTPUT_DIR=/shared/projects/antioxydant/pep_edit/structure_prediction/af3/out

export AF3_MODEL_PARAMETERS_DIR=${AF3_RESOURCES_DIR}/weights
export AF3_DATABASES_DIR=/shared/banks/alphafold3

singularity exec \
     --nv \
     --bind $AF3_INPUT_DIR:/root/af_input \
     --bind $AF3_OUTPUT_DIR:/root/af_output \
     --bind $AF3_MODEL_PARAMETERS_DIR:/root/models \
     --bind $AF3_DATABASES_DIR:/root/public_databases \
     $AF3_IMAGE \
     python ${AF3_CODE_DIR}/alphafold3/run_alphafold.py \
     --input_dir=/root/af_input \
     --model_dir=/root/models \
     --db_dir=/root/public_databases \
     --output_dir=/root/af_output \


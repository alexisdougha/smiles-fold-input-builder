#!/bin/bash

#SBATCH -p ipop-up

#SBATCH --mem=64GB
#SBATCH --gres=gpu:a100_7g.80gb:1

#SBATCH --output=chai.out
#SBATCH --error=chai.err
#SBATCH --job-name=chai

module load chai/0.6.1-rpbs

INPUT_DIR="/shared/projects/antioxydant/pep_edit/structure_prediction/chai/inputs"
MAIN_OUT_DIR="/shared/projects/antioxydant/pep_edit/structure_prediction/chai/out"

for fasta_file in "$INPUT_DIR"/*.fasta; do
    base_name=$(basename "$fasta_file" .fasta)

    output_dir="${MAIN_OUT_DIR}/${base_name}"

    mkdir -p "$output_dir"

    chai-lab fold "$fasta_file" "$output_dir" --use-esm-embeddings --no-use-msa-server --num-trunk-samples 5 --num-diffn-samples 5
done


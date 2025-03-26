#!/bin/bash

#SBATCH --job-name=mattergen              # Job name
#SBATCH --partition=gpu_a100                 # Queue name 
#SBATCH --nodes=1                            # Run all processes on a single node
#SBATCH --ntasks=1                           # Run two task
#SBATCH --cpus-per-task=1                    # Number of CPU cores per task
#SBATCH --mem=50gb                           # Job memory request in Megabytes
#SBATCH --gpus=1                             # Number of GPUs
#SBATCH --time=24:00:00                      # Time limit hrs:min:sec or dd-hrs:min:sec



#COMMAND PART
export TORCH_USE_CUDA_DSA=1
export CUDA_LAUNCH_BLOCKING=1
export HYDRA_FULL_ERROR=1

export PROPERTY=hea
export MODEL_PATH=/trinity/home/michel.lukanov/work/cond-mattergen/checkpoints/mattergen_base

mattergen-finetune adapter.model_path=$MODEL_PATH data_module=mp_20 +lightning_module/diffusion_module/model/property_embeddings@adapter.adapter.property_embeddings_adapt.$PROPERTY=$PROPERTY ~trainer.logger data_module.properties=["$PROPERTY"]

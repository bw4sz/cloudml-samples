#!/bin/bash 

#Startup script
git clone https://github.com/bw4sz/cloudml-samples.git
cd cloudml-samples
cd flowers

#create training and testing documents
python3 CreateDocs.py --positives gs://api-project-773889352370-ml/Hummingbirds/Positives/ --negatives gs://api-project-773889352370-ml/Hummingbirds/Negatives/ --training

declare -r USER="Ben"
declare -r PROJECT=$(gcloud config list project --format "value(core.project)")
declare -r JOB_ID="flowers_${USER}_$(date +%Y%m%d_%H%M%S)"
declare -r BUCKET="gs://${PROJECT}-ml"
declare -r GCS_PATH="${BUCKET}/${USER}/${JOB_ID}"
declare -r MODEL_NAME=flowers
declare -r VERSION_NAME=v1

#from scratch
python pipeline.py \
    --project ${PROJECT} \
    --cloud \
    --train_input_path gs://api-project-773889352370-ml/Hummingbirds/trainingdata.csv \
    --eval_input_path gs://api-project-773889352370-ml/Hummingbirds/testingdata.csv \
    --input_dict gs://api-project-773889352370-ml/Hummingbirds/dict.txt \
    --deploy_model_name "DeepMeerkat" \
    --gcs_bucket ${BUCKET} \
    --output_dir "${GCS_PATH}/training" \
    --sample_image_uri  gs://api-project-773889352370-ml/Hummingbirds/Positives/10000.jpg  

exit


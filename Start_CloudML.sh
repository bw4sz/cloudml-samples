#!/bin/bash 

#Create docker container with local credentials if needed
docker run -t -i -v C:/Users/Ben/Dropbox/Google/MeerkatReader-9fbf10d1e30c.json:/tmp/MeerkatReader-9fbf10d1e30c.json --name gcloud-config google/cloud-sdk gcloud auth activate-service-account 773889352370-compute@developer.gserviceaccount.com --key-file /tmp/MeerkatReader-9fbf10d1e30c.json --project api-project-773889352370

##Create a cloudml a Google Compute Engine Environment
gcloud alpha compute instances create-from-container cloudml 
    --docker-image=gcr.io/api-project-773889352370/cloudmlengine 
    --port-mappings=80:80:TCP
    

 ##Wait for job to finish
gcloud compute instances describe cloudml

#need to start google docker shell.
docker run -it -p "127.0.0.1:8080:8080" --entrypoint=/bin/bash  gcr.io/cloud-datalab/datalab:local
  
git clone https://github.com/bw4sz/cloudml-samples.git

cd cloudml-samples

cd flowers

#run test env
./pipeline.sh
    
#kill instance when you are done.
gcloud compute instances delete gci

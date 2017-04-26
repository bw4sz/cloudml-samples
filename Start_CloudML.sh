#! /bin/bash 

#local
#Create docker container with local credentials if needed
#docker run -t -i -v C:/Users/Ben/Dropbox/Google/MeerkatReader-9fbf10d1e30c.json:/tmp/MeerkatReader-9fbf10d1e30c.json --name gcloud-config google/cloud-sdk gcloud auth activate-service-account 773889352370-compute@developer.gserviceaccount.com --key-file /tmp/MeerkatReader-9fbf10d1e30c.json --project api-project-773889352370
#docker run --rm -it --volumes-from gcloud-config gcr.io/api-project-773889352370/cloudmlengine

# #Create a cloudml a Google Compute Engine Environment
# gcloud alpha compute instances create-from-container cloudml 
    # --docker-image=gcr.io/api-project-773889352370/cloudmlengine 
    # --run-as-privileged
    # --service-account 773889352370-compute@developer.gserviceaccount.com
    # --metadata-from-file startup-script=StartDocker.sh
    # --boot-disk-size "50"

#get startup script info
#gcloud compute instances get-serial-port-output cloudml

#I'm finding that pretty buggy, just go direct   
gcloud compute instances create cloudml 
    --image-family gci-stable 
    --image-project google-containers 
    --boot-disk-size "40"

#for the moment, ssh instance
gcloud compute ssh cloudml
      
#run pipeline
./StartDocker.sh
#kill instance when you are done.
gcloud compute instances delete cloudml

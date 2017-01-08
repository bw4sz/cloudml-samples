#need to start google docker shell.
docker run -it -p "127.0.0.1:8080:8080" --entrypoint=/bin/bash  gcr.io/cloud-datalab/datalab:local
  
git clone https://github.com/bw4sz/cloudml-samples.git

cd cloudml-samples

cd flowers

#run test env

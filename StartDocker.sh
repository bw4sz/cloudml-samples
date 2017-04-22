#!/bin/bash 

#Startup script
git clone https://github.com/bw4sz/cloudml-samples.git
cd cloudml-samples
cd flowers

#run test env
python pipeline.py

exit


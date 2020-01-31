#!/bin/sh

#gcloud compute images list | grep infra-265717 | cut -c 1-22 | xargs gcloud compute images delete --quiet

cd ..
packer build -var-file=variables.json app.json
packer build -var-file=variables.json db.json

#!/bin/bash
#Add this shell script as an "Execute Shell" build step in Jenkins

#Adjust path:
export PATH=/usr/local/bin:$PATH

#Setup Azure service credentials.
#Alternatively source these from a File or "Use secret text(s) or file(s)" from Jenkins Build Environment
export ARM_SUBSCRIPTION_ID=<service_account_subscription_id>
export ARM_CLIENT_ID=<service_account_client_id>
export ARM_CLIENT_SECRET=<service_account_client_secret>
export ARM_TENANT_ID=<service_account_tenant_id>

#Setup Terraform variables:
export location="EAST US"

#Setup tags for Packer image:
export environment="dev"
export app="vmss-packer"
export owner="demo-at-hashicorp"
export ttl="24h"

#Trigger Packer:
cd packer
packer build -force ubuntu.json

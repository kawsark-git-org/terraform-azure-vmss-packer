#Setup Azure service credentials:
export ARM_SUBSCRIPTION_ID=<service_account_subscription_id>
export ARM_CLIENT_ID=<service_account_client_id>
export ARM_CLIENT_SECRET=<service_account_client_secret>
export ARM_TENANT_ID=<service_account_tenant_id>

#Setup Terraform variables:
export TF_VAR_id_rsa_pub="contents-of-id_rsa.pub"
export TF_VAR_location="EAST US"
export TF_VAR_core_resource_group_name="azure-vmss-core"

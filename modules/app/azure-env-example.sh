#Setup Azure service credentials:
export ARM_SUBSCRIPTION_ID=<service_account_subscription_id>
export ARM_CLIENT_ID=<service_account_client_id>
export ARM_CLIENT_SECRET=<service_account_client_secret>
export ARM_TENANT_ID=<service_account_tenant_id>

#Link to Core workspace:
export TF_VAR_core_tfe_organization="TFE-organization"
export TF_VAR_core_infrastructure_workspace="terraform-vmss-core"

#Setup Terraform and Packer variables:
export TF_VAR_id_rsa_pub="contents-of-id_rsa.pub"
export TF_VAR_location="EAST US"
export TF_VAR_app_resource_group_name="azure-vmss-app"
export TF_VAR_packer_resource_group_name="azure-vmss-packer"
export TF_VAR_image_name="vmss-packer-ubuntu1604-lts"
export TF_VAR_vmss_capacity=2

export environment="dev"
export app="vmss-packer"
export owner="kawsar-at-hashicorp"
export ttl="24h"
export TF_VAR_tags='{environment="'${environment}'", app="'${app}'", owner="'${owner}'", ttl="'${ttl}'"}'

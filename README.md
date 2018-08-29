# terraform-azure-vmss-packer
Azure virtual machine scale set from a Packer custom image

### Local build steps:
1. Build packer image:
- Modify `azure-env.sh` with appropriate environment variables.
- Source it and execute packer:
```
source azure-env.sh
cd packer/
packer build ubuntu.json

```

2. Provision Core module:
```
cd modules/core/examples/simple/
terraform init
terraform get -update=true
terraform plan
terraform apply
```

3. Provision App module:
To provision this Module, #2 must be run in Terraform Enterprise. #3 has references to `terraform_remote_state` Data source where it reads the application subnet where the application will be deployed to.

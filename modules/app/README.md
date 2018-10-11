## terraform-azure-vmss-module-app
Terraform App module for use with a Terraform Enterprise Private Module Repository. This module deploys an Azure VM Scale Set, Load Balancer, Azure Redis Cache instance and the [Python Redis Client application](https://github.com/kawsark/redis-client-service/tree/password).
- Dependencies:
  - [Packer image](../../packer)
  - [Core module](../core)
- Example: see example instantiation in [examples/simple/main.tf](examples/simple/main.tf)

### Jenkins build steps:
Please see [Jenkins README](../../jenkins/README.md).

### TFE-CLI local build steps:
- Ensure [TFE CLI](https://github.com/hashicorp/tfe-cli/projects) is installed:
  - You may use the example commands below to setup tfe in INSTALL_DIR:
```
export TFE_INSTALL_DIR=/tmp
cd ${TFE_INSTALL_DIR}
git clone git@github.com:hashicorp/tfe-cli.git
cd tfe-cli/bin
ln -s $PWD/tfe /usr/local/bin/tfe
```
- Edit [app-example.sh](app-example.sh) with the correct values for these variables: `TFE_ORG, ID_RSA_PUB_PATH, ARM_SUBSCRIPTION_ID, ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID`
- Invoke the script:
```
chmod +x app-example.sh
./app-example.sh
```

### App Module diagram:
![App](Azure-App-module-1.2.png "Private Module Repository - App")

### Terraform Azure VMSS architecture diagram:
![VMSS](../../Azure-VMSS-architecture-1.2.png "VMSS")

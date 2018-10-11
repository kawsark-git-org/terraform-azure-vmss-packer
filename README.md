## Azure VM Scale Set and Redis cache deployment

This project provisions an application on Azure that interfaces with an Azure Redis Cache instance. It requires using Terraform Enterprise (TFE) as a `terraform_remote_state` Data Source is used.

Optionally, this deployment can be automated using Jenkins or another CI system using the [TFE CLI](https://github.com/hashicorp/tfe-cli) to interact with a TFE. Steps for deploying using Jenkins are provided in the [jenkins](jenkins/) directory.

**Time required: ~ 45 minutes**

**Architecture diagram**
![VMSS](Azure-VMSS-architecture-1.2.png "VMSS")

### Deployment overview:
There are 3 main components to this deployment:
- [Packer](packer): Builds a packer Azure managed Disk image that is used by the Application.
- [Core module](modules/core): This module provisions an Azure VNET, Subnet and Bastion Host.
- [App module](modules/app): This module deploys an Azure VM Scale Set, Load Balancer, Azure Redis Cache instance and the [Python Redis Client application](https://github.com/kawsark/redis-client-service/tree/password).

### Build steps:

Please choose either one of the following build steps:
1. Local builds using packer and TFE-CLI
   - [Packer local build](packer/README.md)
   - [Core module local build](modules/core/README.md)
   - [App module local build](modules/app/README.md)

2. [Jenkins build](jenkins/readme.md)

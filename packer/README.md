# packer-build
This configuration will build a Ubuntu OS image in Azure with the [python-redis-client](https://github.com/kawsark/redis-client-service) application.

### Jenkins build steps:
Please see [Jenkins README](../jenkins/README.md).

### Packer local build steps:
- Download packer binary and ensure it is available in your path:
  - [Download page](https://www.packer.io/downloads.html)
  - [Install the binary](https://www.packer.io/intro/getting-started/install.html#precompiled-binaries)

- Modify [azure-env-example.sh](azure-env-example.sh) with appropriate environment variables.
- Source it and execute packer:
```
source azure-env-example.sh
packer build ubuntu.json
```

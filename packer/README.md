# packer-build
This configuration will build a Ubuntu OS image in Azure with the [python-redis-client](https://github.com/kawsark/redis-client-service) application.

### Packer local build steps:
- Modify `azure-env-example.sh` with appropriate environment variables.
- Source it and execute packer:
```
source azure-env-example.sh
packer build ubuntu.json
```

#!/bin/bash
touch /tmp/redis-start-script-$(whoami)
usermod -aG docker azureuser
sudo docker run --name clientms -d -e REDIS_HOST="${redis_host}" -e REDIS_PORT="${redis_port}" -e REDIS_PASSWORD="${redis_password}" -p 5000:5000 --restart unless-stopped python-clientms 
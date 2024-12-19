#!/bin/bash
curl -fsSL https://get.docker.com -o /tmp/install-docker.sh
sh /tmp/install-docker.sh
usermod -aG docker ubuntu
#!/usr/bin/sudo bash
echo $'{\n    "experimental": true\n}' | sudo tee /etc/docker/daemon.json; sudo service docker restart

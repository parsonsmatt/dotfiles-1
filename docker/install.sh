#!/bin/bash

wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker matt

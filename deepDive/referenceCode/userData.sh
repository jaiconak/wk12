#!/bin/bash

sudo yum install httpd -y
sudo systemctl start httpd 
sudo groupadd devOps
sudo useradd jaico -g devOps
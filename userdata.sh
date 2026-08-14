#!/bin/bash
yum update -y
yum install docker -y
yum install git -y
yum install nginx -y
systemctl start nginx
systemctl enable nginx
systemctl start docker
systemctl enable docker
# DevOps Assignment: Dockerize and Deploy a Web App on AWS EC2

This project documents the complete process of Dockerizing a web application and deploying it on an AWS EC2 instance. It includes all core tasks and bonus implementations like automation and IAM integration.

https://docs.google.com/document/d/1q0NIpiSnygB-86rM0JxCsOOXD3BAqa_LNf_kwptFcHI/edit?usp=share_link
---

## 📚 Table of Contents

- [Project Overview](#project-overview)
- [Prerequisites](#prerequisites)
- [Steps & Commands](#steps--commands)
  - [1. Setup and GitHub Repo](#1-setup-and-github-repo)
  - [2. Dockerize the Application](#2-dockerize-the-application)
  - [3. Push Docker Image to Docker Hub](#3-push-docker-image-to-docker-hub)
  - [4. Launch and Configure AWS EC2](#4-launch-and-configure-aws-ec2)
  - [5. Bonus Tasks](#5-bonus-tasks)
- [📸 Screenshots](#-screenshots)
- [📌 Additional Notes](#-additional-notes)

---

## Project Overview

The objective is to:

- Containerize a web app using Docker.
- Push the Docker image to Docker Hub.
- Deploy the app on an AWS EC2 instance.
- Bonus: Automate the process using `cloud-init` and add IAM + S3 integration.

---

## Prerequisites

- AWS account (free-tier eligible)
- GitHub account
- Docker installed locally
- Basic knowledge of Linux and shell

---

## Steps & Commands

### 1. Setup and GitHub Repo

- Created a new GitHub repo and added:
  - Source code
  - Dockerfile
  - Documentation

**GitHub Repo:** [https://github.com/Harshthakur-568/AWS_EC2](https://github.com/Harshthakur-568/AWS_EC2)

---

### 2. Dockerize the Application

**Dockerfile written for the web app.**

Build the Docker image:

```
docker build -t candy-store .
Run it locally:

docker run -p 3000:3000 candy-store
Check at: http://localhost:3000
```
3. Push Docker Image to Docker Hub
Login to Docker:
```
docker login
Tag and push the image:
```
```
docker tag candy-store harshthakur05/candy-store:01
docker push harshthakur05/candy-store:01
```
4. Launch and Configure AWS EC2
Launched an EC2 instance (Amazon Linux 2, t2.micro)
Opened port 80 in Security Group
SSH into instance:
```
ssh -i key.pem ec2-user@<public-ip>

```
Installed Docker:
```
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
```

Pulled and ran the image:
```
docker pull harshthakur05/candy-store:01
docker run -d -p 80:3000 harshthakur05/candy-store:01
Access: http://34.227.15.61 (replace with your EC2 public IP)
```

5. Bonus Tasks
a. IAM Roles for S3 Access

Created IAM role with S3 read/write permissions
Attached role to EC2 instance
Verified via CLI:
```
aws s3 ls s3://<your-bucket-name>
```

b. Cloud-init Script for Automation

Sample user-data for EC2:
```
#cloud-config
packages:
  - docker
runcmd:
  - systemctl start docker
  - docker run -d -p 80:3000 harshthakur05/candy-store:01
```
c. Shell Script: deploy.sh
```
#!/bin/bash

# Update and install Docker
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user

# Pull and run the Docker container
docker pull harshthakur05/candy-store:01
docker run -d -p 80:3000 harshthakur05/candy-store:01
```

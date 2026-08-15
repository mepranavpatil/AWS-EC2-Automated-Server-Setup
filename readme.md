# AWS EC2 Automated Server Provisioning with Terraform & Bash

## Overview

This project demonstrates Infrastructure as Code (IaC) using Terraform to provision AWS infrastructure and Bash automation to configure a Linux server automatically during launch.

The infrastructure includes a custom VPC, public subnet, Internet Gateway, route table, security group, and an EC2 instance. During instance initialization, a user-data script installs and configures Docker and Nginx automatically.

This project was built to gain hands-on experience with:

* AWS Networking
* EC2 Provisioning
* Terraform
* Bash Scripting
* Infrastructure Automation
* User Data Bootstrapping
* Remote Terraform State Management

---

## Architecture

```text
                           Internet
                               │
                               ▼
                     Internet Gateway
                               │
                               ▼
                        Route Table
                               │
                               ▼
                     Public Subnet
                     10.0.1.0/24
                               │
                               ▼
                      Security Group
                     ┌───────────────┐
                     │ TCP 22 (SSH)  │
                     │ TCP 80 (HTTP) │
                     └───────────────┘
                               │
                               ▼
                         EC2 Instance
                               │
                               ▼
                         User Data Script
                               │
                ┌──────────────┴──────────────┐
                ▼                             ▼
          Install Docker                Install Nginx
                ▼                             ▼
          Start Service                Start Service
```

---

## Project Objectives

The primary objectives of this project are:

* Create AWS infrastructure using Terraform
* Understand VPC networking fundamentals
* Launch and configure an EC2 instance automatically
* Learn Infrastructure as Code principles
* Automate server provisioning using Bash
* Store Terraform state remotely in Amazon S3
* Build a reusable and scalable Terraform project structure

---

## Technologies Used

| Technology | Purpose                     |
| ---------- | --------------------------- |
| AWS EC2    | Virtual Server              |
| AWS VPC    | Networking                  |
| AWS S3     | Terraform Backend           |
| Terraform  | Infrastructure Provisioning |
| Bash       | Server Automation           |
| Linux      | Operating System            |
| Git        | Version Control             |
| GitHub     | Repository Hosting          |

---

## AWS Resources Created

### Networking

* Custom VPC
* Public Subnet
* Internet Gateway
* Route Table
* Route Table Association
* Security Group

### Compute

* Amazon Linux EC2 Instance

### State Management

* S3 Bucket for Terraform Remote State

---

## Project Structure

```text
AWS-EC2-Automated-Server-Setup/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
├── backend.tf
├── terraform.tfvars
├── userdata.sh
├── .gitignore
└── README.md
```

---

## Infrastructure Components

### VPC

A custom Virtual Private Cloud is created to provide an isolated networking environment.

```text
CIDR: 10.0.0.0/16
```

Purpose:

* Network isolation
* Resource organization
* Security boundaries

---

### Public Subnet

The EC2 instance is deployed inside a public subnet.

```text
CIDR: 10.0.1.0/24
```

Purpose:

* Internet connectivity
* Public-facing workloads

---

### Internet Gateway

Allows communication between the VPC and the public internet.

Purpose:

* Outbound internet access
* Inbound HTTP and SSH traffic

---

### Route Table

Routes internet-bound traffic through the Internet Gateway.

```text
0.0.0.0/0 → Internet Gateway
```

Purpose:

* Internet connectivity

---

### Security Group

Acts as a virtual firewall.

Allowed Ports:

| Port | Protocol | Purpose |
| ---- | -------- | ------- |
| 22   | TCP      | SSH     |
| 80   | TCP      | HTTP    |

Purpose:

* Secure server access
* Web traffic access

---

### EC2 Instance

Amazon Linux EC2 instance provisioned using Terraform.

Purpose:

* Host Docker
* Host Nginx
* Demonstrate server automation

---

## User Data Automation

When the EC2 instance launches, a Bash script executes automatically.

Tasks performed:

### System Update

```bash
yum update -y
```

### Docker Installation

```bash
yum install docker -y
```

### Docker Service

```bash
systemctl start docker
systemctl enable docker
```

### Nginx Installation

```bash
yum install nginx -y
```

### Nginx Service

```bash
systemctl start nginx
systemctl enable nginx
```

Benefits:

* Fully automated server setup
* Consistent deployments
* Reduced manual configuration

---

## Terraform Remote State

Terraform state is stored remotely in Amazon S3.

Benefits:

* Centralized state management
* Collaboration support
* State durability
* Disaster recovery

Architecture:

```text
Terraform
     │
     ▼
  S3 Bucket
     │
     ▼
terraform.tfstate
```

---

## Prerequisites

Before running this project, ensure the following are installed:

### AWS CLI

Verify:

```bash
aws --version
```

### Terraform

Verify:

```bash
terraform --version
```

### Git

Verify:

```bash
git --version
```

### AWS Credentials Configured

Verify:

```bash
aws sts get-caller-identity
```

---

## Deployment Steps

### Clone Repository

```bash
git clone https://github.com/mepranavpatil/AWS-EC2-Automated-Server-Setup.git

cd AWS-EC2-Automated-Server-Setup
```

---

### Initialize Terraform

```bash
terraform init
```

Expected Result:

```text
Terraform has been successfully initialized
```

---

### Validate Configuration

```bash
terraform validate
```

Expected Result:

```text
Success! The configuration is valid.
```

---

### Review Execution Plan

```bash
terraform plan
```

Review all resources before deployment.

---

### Deploy Infrastructure

```bash
terraform apply
```

Type:

```text
yes
```

Terraform will create:

* VPC
* Subnet
* Internet Gateway
* Route Table
* Security Group
* EC2 Instance

---

## Verification

### Verify EC2 Creation

```bash
aws ec2 describe-instances
```

---

### Verify SSH Access

```bash
ssh -i <your-key>.pem ec2-user@<public-ip>
```

---

### Verify Docker

```bash
docker --version
```

Expected:

```text
Docker version xx.xx.xx
```

---

### Verify Nginx

```bash
nginx -v
```

Expected:

```text
nginx version: nginx/x.x.x
```

---

### Verify Services

```bash
systemctl status docker

systemctl status nginx
```

Expected:

```text
active (running)
```

---

### Verify Website

Open:

```text
http://<EC2-PUBLIC-IP>
```

You should see the Nginx default page.

---

## Terraform Outputs

Example outputs:

```text
public_ip  = xx.xx.xx.xx
public_dns = ec2-xx-xx-xx-xx.compute.amazonaws.com
```

These outputs help quickly access the provisioned server.

---

## Troubleshooting

### Terraform Initialization Issues

```bash
terraform init
```

Check:

* AWS credentials
* Internet connectivity
* S3 backend configuration

---

### SSH Connection Timeout

Verify:

* Security Group allows TCP 22
* Correct key pair is used
* Public IP exists

---

### Website Not Accessible

Verify:

* Port 80 is open
* Nginx is running
* Route Table configured correctly

---

### Docker Not Installed

Check user-data logs:

```bash
sudo cat /var/log/cloud-init-output.log
```

---

## Security Considerations

This project is designed for learning purposes.

Current configuration:

```text
SSH: 0.0.0.0/0
HTTP: 0.0.0.0/0
```

Recommended improvements:

* Restrict SSH to your public IP
* Use IAM Roles instead of static credentials
* Enable VPC Flow Logs
* Use HTTPS with SSL certificates
* Enable CloudWatch monitoring

---

## Cost Considerations

Estimated resources:

* t2.micro / t3.micro EC2
* VPC
* Subnet
* Internet Gateway
* Security Group

Potential charges may apply if Free Tier limits are exceeded.

Always destroy resources when finished.

---

## Cleanup

To avoid unnecessary AWS charges:

```bash
terraform destroy
```

Type:

```text
yes
```

Terraform will remove all resources created by this project.

---

## Skills Demonstrated

* AWS VPC Networking
* EC2 Provisioning
* Terraform Fundamentals
* Infrastructure as Code
* Linux Administration
* Bash Scripting
* User Data Automation
* Security Groups
* Route Tables
* Internet Gateways
* Remote State Management
* Git & GitHub

---

## Future Improvements

Planned enhancements:

* Elastic IP
* Custom Nginx Landing Page
* CloudWatch Monitoring
* Terraform Modules
* Multi-AZ Deployment
* Load Balancer
* Auto Scaling Group
* CI/CD with GitHub Actions
* Dockerized Application Deployment

---

## Learning Outcomes

By completing this project, I gained practical experience in:

* Designing AWS network infrastructure
* Automating infrastructure deployment with Terraform
* Configuring Linux servers using Bash
* Understanding AWS networking concepts
* Managing Terraform state remotely
* Building repeatable cloud infrastructure

This project serves as a foundational Cloud Engineering and DevOps project and forms the basis for more advanced infrastructure automation projects.


This project demonstrates a complete DevOps pipeline including infrastructure provisioning, application deployment, CI/CD automation, monitoring readiness, and best practices.

The solution uses Infrastructure as Code (IaC) with Terraform and implements a CI/CD pipeline using GitHub Actions.



 Architecture

Internet → ALB → Target Group → EC2 (Docker App) → VPC
                          ↓
                      Security Groups

Components:

* VPC with public & private subnets across multiple AZs
* EC2 instance hosting a containerized application
* Application Load Balancer for traffic routing
* Security groups for controlled access
* Remote state management using S3 + DynamoDB

 Infrastructure Setup

Prerequisites

* AWS CLI configured
* Terraform installed
* Git installed

 Steps

bash
terraform init
terraform plan
terraform apply
```

Backend Configuration

* S3 bucket for Terraform state
* DynamoDB for state locking



 Application Deployment

Application is containerized using Docker and deployed via CI/CD pipeline.


 CI/CD Pipeline

Implemented using GitHub Actions:

### Features:

* Runs unit and integration tests on Pull Requests
* Builds Docker image on merge to main
* Pushes image to AWS ECR
* Deploys automatically to staging environment
* Manual approval required for production deployment
* Performs vulnerability scanning
* Sends notifications on failure

---

 Security Considerations

* Security Groups restrict access:

  * ALB: open to internet (HTTP)
  * EC2: only accessible from ALB and SSH from specific IP
* Secrets stored securely using GitHub Secrets
* No credentials hardcoded in code
* IAM roles used with least privilege principle
* Docker image scanning performed using Trivy

---

 Cost Optimization

* Used `t2.micro` instances (free tier eligible)
* Minimal resources provisioned
* Auto-stop unused resources (manual recommendation)
* Avoided over-provisioning (single EC2 for demo)

---

 Monitoring & Logging (Design)

* CloudWatch metrics for EC2 and ALB
* Application logs can be centralized using CloudWatch Logs
* Health checks configured in ALB

Secret Management

Secrets are managed using:

* GitHub Secrets for CI/CD credentials
* AWS IAM roles instead of hardcoding keys


Backup Strategy

* Terraform state stored in S3 (durable storage)
* Versioning enabled on S3 bucket
* RDS (if used) supports automated backups


 Deliverables

* GitHub repository with full code
* Terraform modules for reusable infrastructure
* CI/CD pipeline configuration
* Documentation (this README)


 Approach

1. Designed modular Terraform structure
2. Built networking layer (VPC, subnets, routing)
3. Configured security groups
4. Deployed EC2 and ALB
5. Containerized application using Docker
6. Implemented CI/CD pipeline
7. Added security scanning and approval gates



 ⚠️ Challenges & Resolutions

 1. ALB not getting created

* Cause: Subnets were in same Availability Zone
* Fix: Created subnets in different AZs

 2. Target group unhealthy

* Cause: No application running on port 80
* Fix: Installed and started web server / Docker app

 3. Terraform state issues

* Cause: Backend not initialized properly
* Fix: Reconfigured backend using `terraform init -reconfigure`

4. Security group misconfiguration

* Cause: Incorrect ingress rules
* Fix: Allowed traffic only from required sources (ALB → EC2)

5. CI/CD deployment failures

* Cause: Missing Docker setup on EC2
* Fix: Installed and configured Docker properly

---


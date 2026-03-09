# ECS Log Analyzer – DevOps Build Lab

This project demonstrates a fully automated AWS deployment pipeline using:

- Terraform (Infrastructure as Code)
- Docker (Application packaging)
- GitHub Actions (CI/CD)
- Amazon ECR (Container registry)
- ECS Fargate (Container runtime)
- Application Load Balancer (Traffic routing)
- CloudWatch (Logging)

The sample application is a Log Analyzer API developed in Python to process log files and identify error patterns, warnings, and service hotspots.

## Architecture

Terraform provisions:

- VPC
- Subnets
- Application Load Balancer
- ECS Cluster
- ECS Service
- IAM Roles
- CloudWatch Log Groups

CI/CD Pipeline:

GitHub Actions builds the container image and pushes it to ECR automatically on every commit.
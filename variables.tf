variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name, used as a prefix for resource naming"
  type        = string
  default     = "threetier-app"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# ---------- Networking ----------
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of Availability Zones to spread subnets across (HA)"
  type        = number
  default     = 2
}

variable "single_nat_gateway" {
  description = "If true, use one NAT Gateway for all AZs (cheaper, less HA). If false, one NAT per AZ (recommended for prod)."
  type        = bool
  default     = false
}

# ---------- Compute / ASG ----------
variable "instance_type" {
  description = "EC2 instance type for the application tier"
  type        = string
  default     = "t3.micro"
}

variable "asg_min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
  default     = 6
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in the ASG"
  type        = number
  default     = 2
}

variable "cpu_target_value" {
  description = "Target average CPU utilization (%) for ASG target tracking scaling"
  type        = number
  default     = 60
}

# ---------- Database ----------
variable "db_engine" {
  description = "RDS database engine"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "RDS engine version"
  type        = string
  default     = "16.3"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage for RDS (GB)"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Master username for RDS (password is auto-generated + stored in Secrets Manager)"
  type        = string
  default     = "app_admin"
}

variable "db_multi_az" {
  description = "Enable Multi-AZ deployment for RDS (HA)"
  type        = bool
  default     = true
}

# ---------- Access ----------
variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to reach instances via SSH through the bastion/SSM (restrict this!)"
  type        = string
  default     = "0.0.0.0/0" # override in terraform.tfvars with your IP/32
}

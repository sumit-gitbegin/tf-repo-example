variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "app_port" {
  type    = number
  default = 8080
}

variable "db_port" {
  type    = number
  default = 5432
}

variable "allowed_ssh_cidr" {
  type = string
}

variable "db_secret_arn" {
  description = "ARN of the Secrets Manager secret holding DB credentials (created at root level to avoid circular deps)"
  type        = string
}

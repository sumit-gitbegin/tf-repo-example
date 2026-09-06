variable "project_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "app_port" {
  type    = number
  default = 8080
}

variable "app_sg_id" {
  type = string
}

variable "ec2_instance_profile_name" {
  type = string
}

variable "private_app_subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}

variable "db_secret_arn" {
  type = string
}

variable "asg_min_size" {
  type = number
}

variable "asg_max_size" {
  type = number
}

variable "asg_desired_capacity" {
  type = number
}

variable "cpu_target_value" {
  type = number
}

output "alb_dns_name" {
  description = "Public DNS name of the load balancer - use this to access the app"
  value       = module.alb.alb_dns_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "db_endpoint" {
  description = "RDS endpoint (only reachable from within the VPC)"
  value       = module.rds.db_endpoint
}

output "db_secret_arn" {
  description = "Secrets Manager ARN holding DB credentials"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "asg_name" {
  value = module.compute.asg_name
}

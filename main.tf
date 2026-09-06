# =====================================================================
# Root module: wires together vpc -> security -> alb -> compute -> rds
# =====================================================================

module "vpc" {
  source = "./modules/vpc"

  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  az_count           = var.az_count
  single_nat_gateway = var.single_nat_gateway
}

module "security" {
  source = "./modules/security"

  project_name     = var.project_name
  vpc_id           = module.vpc.vpc_id
  allowed_ssh_cidr = var.allowed_ssh_cidr
  db_secret_arn    = aws_secretsmanager_secret.db_credentials.arn
}

module "alb" {
  source = "./modules/alb"

  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security.alb_sg_id
}

module "compute" {
  source = "./modules/compute"

  project_name              = var.project_name
  aws_region                = var.aws_region
  instance_type             = var.instance_type
  app_sg_id                 = module.security.app_sg_id
  ec2_instance_profile_name = module.security.ec2_instance_profile_name
  private_app_subnet_ids    = module.vpc.private_app_subnet_ids
  target_group_arn          = module.alb.target_group_arn
  db_secret_arn             = aws_secretsmanager_secret.db_credentials.arn

  asg_min_size         = var.asg_min_size
  asg_max_size         = var.asg_max_size
  asg_desired_capacity = var.asg_desired_capacity
  cpu_target_value     = var.cpu_target_value
}

module "rds" {
  source = "./modules/rds"

  project_name          = var.project_name
  private_db_subnet_ids = module.vpc.private_db_subnet_ids
  db_sg_id              = module.security.db_sg_id

  db_engine         = var.db_engine
  db_engine_version = var.db_engine_version
  db_instance_class = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = random_password.db_password.result
  db_multi_az       = var.db_multi_az

  deletion_protection = var.environment == "prod" ? true : false
  skip_final_snapshot = var.environment == "prod" ? false : true
}

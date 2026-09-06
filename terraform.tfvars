# Copy this file to terraform.tfvars and adjust values for your environment.
# terraform.tfvars is typically gitignored since it may contain env-specific settings.

aws_region   = "us-east-1"
project_name = "threetier-app"
environment  = "dev"

vpc_cidr           = "10.0.0.0/16"
az_count           = 2
single_nat_gateway = true # set to false in prod for full HA (one NAT per AZ)

instance_type        = "t3.micro"
asg_min_size          = 2
asg_max_size          = 6
asg_desired_capacity  = 2
cpu_target_value      = 60

db_engine            = "postgres"
db_engine_version    = "16.3"
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20
db_name              = "appdb"
db_username          = "app_admin"
db_multi_az          = true

# IMPORTANT: restrict this to your IP (e.g. "203.0.113.10/32") before applying
allowed_ssh_cidr = "0.0.0.0/0"

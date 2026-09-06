Project Structure
terraform-aws-3tier/
├── providers.tf              # Terraform + AWS provider, backend config
├── variables.tf              
├── main.tf                  
├── secrets.tf                
├── outputs.tf              
├── terraform.tfvars.example  
└── modules/
    ├── vpc/                  
    ├── security/             
    ├── alb/                   
    ├── compute/                 # Launch template + Auto Scaling Group + scaling policy
    └── rds/                    

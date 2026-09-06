# Auto-generate a strong DB password and store it in Secrets Manager.
# This is created at the root level (not inside a module) so that both the
# security module (IAM read policy) and the rds module (actual password)
# can reference it without a circular dependency between those two modules.

resource "random_password" "db_password" {
  length  = 20
  special = false # avoids characters RDS engines sometimes reject
}

resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "${var.project_name}-db-credentials"
  description = "Master credentials for ${var.project_name} RDS instance"
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
    dbname   = var.db_name
    engine   = var.db_engine
  })
}

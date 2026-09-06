#!/bin/bash
set -euxo pipefail

# Basic bootstrap: install a web server, fetch DB creds from Secrets Manager,
# and expose a /health endpoint for the ALB health check.

dnf update -y
dnf install -y nginx jq aws-cli

# Fetch DB credentials securely from Secrets Manager at boot (never hardcode secrets)
DB_SECRET_JSON=$(aws secretsmanager get-secret-value \
  --region ${aws_region} \
  --secret-id ${db_secret_arn} \
  --query SecretString --output text)

echo "$DB_SECRET_JSON" > /etc/app-db-secret.json
chmod 600 /etc/app-db-secret.json

# Minimal health check + placeholder app page
mkdir -p /usr/share/nginx/html
cat <<'EOF' > /usr/share/nginx/html/health
OK
EOF

cat <<'EOF' > /usr/share/nginx/html/index.html
<html><body><h1>3-Tier App - Instance is healthy</h1></body></html>
EOF

# nginx listens on the app_port used by the ALB target group
sed -i "s/listen\s*80;/listen ${app_port};/" /etc/nginx/nginx.conf || true

systemctl enable nginx
systemctl restart nginx

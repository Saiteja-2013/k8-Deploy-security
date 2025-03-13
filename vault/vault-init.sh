#!/bin/bash

# Set Vault address
export VAULT_ADDR="https://vault.example.com"
export VAULT_NAMESPACE="your-namespace"

# Authenticate to Vault (Modify accordingly)
export VAULT_TOKEN=$(vault login -method=aws role=codebuild-role -format=json | jq -r '.auth.client_token')

# Fetch secrets from Vault
DB_USERNAME=$(vault kv get -field=username secret/data/database)
DB_PASSWORD=$(vault kv get -field=password secret/data/database)

# Save secrets for Kubernetes usage
cat <<EOF > k8s/secrets.yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
data:
  DB_USERNAME: $(echo -n "$DB_USERNAME" | base64)
  DB_PASSWORD: $(echo -n "$DB_PASSWORD" | base64)
EOF

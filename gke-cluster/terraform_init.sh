#!/bin/bash
env=$1
tfvars_file="${env}.tfvars"

# Reading variables from the *.tfvars files
# Getting variable values
bucket=$(grep '^bucket' $tfvars_file | cut -d'=' -f2 | tr -d ' ' | tr -d '"' | tr -d '\r\n')
organization=$(grep '^organization' $tfvars_file | cut -d'=' -f2 | tr -d ' ' | tr -d '"' | tr -d '\r\n')
team_name=$(grep '^team_name' $tfvars_file | cut -d'=' -f2 | tr -d ' ' | tr -d '"' | tr -d '\r\n')
project_name=$(grep '^project_name' $tfvars_file | cut -d'=' -f2 | tr -d ' ' | tr -d '"' | tr -d '\r\n')
app_tag=$(grep '^app_tag' $tfvars_file | cut -d'=' -f2 | tr -d ' ' | tr -d '"' | tr -d '\r\n')
credentials=$(grep '^credentials' $tfvars_file | cut -d'=' -f2 | tr -d ' ' | tr -d '"' | tr -d '\r\n')

# Creation of the backend.tf file
cat << EOF > backend.tf
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.4.0"
    }
    helm = {
        source  = "hashicorp/helm"
        version = "2.11.0"
    }
    kubernetes = {
        source  = "hashicorp/kubernetes"
        version = "2.23.0"
    }    
  }
  backend "gcs" {
    bucket      = "$bucket"
    prefix      = "$organization/$team_name/$project_name/$app_tag.tfstate"
    credentials = "$credentials"
  }
}
EOF

# Inicializing Terraform
terraform init

# Validating if the worksapce exist
workspace_exists=$(terraform workspace list | grep -w "$env" || true)
if [ -z "$workspace_exists" ]; then
  echo "Workspace $env does not exist, creating it."
  terraform workspace new $env
else
  echo "Workspace $env exists, selecting it."
  terraform workspace select $env
fi
plan-dev:
	terraform -chdir=gke-cluster/ init
	terraform -chdir=gke-cluster/ workspace select gcp-dev
	terraform -chdir=gke-cluster/ validate
	terraform -chdir=gke-cluster/ fmt
	terraform -chdir=gke-cluster/ plan -var-file dev.tfvars

apply-dev:
	terraform -chdir=gke-cluster/ init
	terraform -chdir=gke-cluster/ workspace select gcp-dev
	terraform -chdir=gke-cluster/ validate
	terraform -chdir=gke-cluster/ fmt
	terraform -chdir=gke-cluster/ apply -var-file dev.tfvars --auto-approve

destroy-dev:
	terraform -chdir=gke-cluster/ init
	terraform -chdir=gke-cluster/ workspace select gcp-dev
	terraform -chdir=gke-cluster/ validate
	terraform -chdir=gke-cluster/ fmt
	terraform -chdir=gke-cluster/ destroy -var-file dev.tfvars --auto-approve

# --------------------------------------------------------------------------------

plan-stg:
	terraform -chdir=gke-cluster/ init
	terraform -chdir=gke-cluster/ workspace select gcp-stg
	terraform -chdir=gke-cluster/ validate
	terraform -chdir=gke-cluster/ fmt
	terraform -chdir=gke-cluster/ plan -var-file stg.tfvars

apply-stg:
	terraform -chdir=gke-cluster/ init
	terraform -chdir=gke-cluster/ workspace select gcp-stg
	terraform -chdir=gke-cluster/ validate
	terraform -chdir=gke-cluster/ fmt
	terraform -chdir=gke-cluster/ apply -var-file stg.tfvars --auto-approve

destroy-stg:
	terraform -chdir=gke-cluster/ init
	terraform -chdir=gke-cluster/ workspace select gcp-stg
	terraform -chdir=gke-cluster/ validate
	terraform -chdir=gke-cluster/ fmt
	terraform -chdir=gke-cluster/ destroy -var-file stg.tfvars --auto-approve
plan-dev:
	terraform -chdir=gke-cluster/ init
	terraform -chdir=gke-cluster/ workspace select gcp-dev
	terraform -chdir=gke-cluster/ validate
	terraform -chdir=gke-cluster/ plan -var-file dev.tfvars

apply-dev:
	terraform -chdir=gke-cluster/ init
	terraform -chdir=gke-cluster/ workspace select gcp-dev
	terraform -chdir=gke-cluster/ validate
	terraform -chdir=gke-cluster/ apply -var-file dev.tfvars --auto-approve

destroy-dev:
	terraform -chdir=gke-cluster/ init
	terraform -chdir=gke-cluster/ workspace select gcp-dev
	terraform -chdir=gke-cluster/ validate
	terraform -chdir=gke-cluster/ apply -var-file dev.tfvars --auto-approve
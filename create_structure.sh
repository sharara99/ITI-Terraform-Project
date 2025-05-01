#!/bin/bash

# Define the root directory
ROOT_DIR="terraform-project"

# Define the directory structure
declare -a DIRS=(
    "$ROOT_DIR"
    "$ROOT_DIR/modules/vpc"
    "$ROOT_DIR/modules/nat_gateway"
    "$ROOT_DIR/modules/route_table"
    "$ROOT_DIR/modules/security_groups"
    "$ROOT_DIR/modules/load_balancer"
    "$ROOT_DIR/modules/autoscaling"
    "$ROOT_DIR/modules/rds"
    "$ROOT_DIR/modules/ssh_key"
    "$ROOT_DIR/modules/s3_backend"
    "$ROOT_DIR/ansible"
)

# Define the files to be created
declare -a FILES=(
    "$ROOT_DIR/main.tf"
    "$ROOT_DIR/providers.tf"
    "$ROOT_DIR/variables.tf"
    "$ROOT_DIR/terraform.tfvars"
    "$ROOT_DIR/backend.tf"
    "$ROOT_DIR/outputs.tf"
    "$ROOT_DIR/modules/vpc/main.tf"
    "$ROOT_DIR/modules/vpc/variables.tf"
    "$ROOT_DIR/modules/vpc/outputs.tf"
    "$ROOT_DIR/modules/nat_gateway/main.tf"
    "$ROOT_DIR/modules/nat_gateway/variables.tf"
    "$ROOT_DIR/modules/route_table/main.tf"
    "$ROOT_DIR/modules/route_table/variables.tf"
    "$ROOT_DIR/modules/security_groups/main.tf"
    "$ROOT_DIR/modules/security_groups/variables.tf"
    "$ROOT_DIR/modules/load_balancer/main.tf"
    "$ROOT_DIR/modules/load_balancer/variables.tf"
    "$ROOT_DIR/modules/load_balancer/outputs.tf"
    "$ROOT_DIR/modules/autoscaling/main.tf"
    "$ROOT_DIR/modules/autoscaling/variables.tf"
    "$ROOT_DIR/modules/autoscaling/outputs.tf"
    "$ROOT_DIR/modules/rds/main.tf"
    "$ROOT_DIR/modules/rds/variables.tf"
    "$ROOT_DIR/modules/ssh_key/main.tf"
    "$ROOT_DIR/modules/ssh_key/variables.tf"
    "$ROOT_DIR/modules/s3_backend/main.tf"
    "$ROOT_DIR/modules/s3_backend/variables.tf"
    "$ROOT_DIR/ansible/playbook.yml"
    "$ROOT_DIR/ansible/index.php.j2"
)

# Create directories
echo "Creating directories..."
for dir in "${DIRS[@]}"; do
    mkdir -p "$dir"
    echo "Created directory: $dir"
done

# Create files
echo "Creating files..."
for file in "${FILES[@]}"; do
    touch "$file"
    echo "Created file: $file"
done

echo "Project structure created successfully."

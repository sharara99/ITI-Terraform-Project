module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = var.vpc_cidr
  environment = var.Environment
  owner       = var.Owner
}


module "nat_gateway" {
  source           = "./modules/nat_gateway"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_1_id
}

module "route_table" {
  source          = "./modules/route_table"
  vpc_id          = module.vpc.vpc_id
  igw_id          = module.nat_gateway.igw_id
  nat_gateway_id  = module.nat_gateway.nat_gw_id
  public_subnets  = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  private_subnets = [module.vpc.private_subnet_1_id, module.vpc.private_subnet_2_id]
}

module "security_groups" {
  source   = "./modules/security_groups"
  vpc_id   = module.vpc.vpc_id
  vpc_cidr = var.vpc_cidr
}

module "ssh_key" {
  source = "./modules/ssh_key"
}

module "load_balancer" {
  source            = "./modules/load_balancer"
  public_subnets    = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  security_group_id = module.security_groups.public_sg
  vpc_id            = module.vpc.vpc_id
}

module "autoscaling" {
  source            = "./modules/autoscaling"
  subnets           = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  security_group_id = module.security_groups.public_sg
  key_name          = module.ssh_key.key_name
  target_group_arn  = module.load_balancer.target_group_arn
  ami               = var.ami
  instance_type     = var.instance_type
}

module "rds" {
  source            = "./modules/rds"
  private_subnets   = [module.vpc.private_subnet_1_id, module.vpc.private_subnet_2_id]
  security_group_id = module.security_groups.rds_sg
  username          = var.db_username
  password          = var.db_password
}

module "s3_backend" {
  source      = "./modules/s3_backend"
  bucket_name = "terraform-project-sharara"
}
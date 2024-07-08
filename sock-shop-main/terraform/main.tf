# Appel du module VPC
module "network" {
    source = "./modules/network"
    name = "sock-shop_vpc"
    cidr = "10.0.0.0/16"
    public_subnets = ["10.0.128.0/20", "10.0.144.0/20"]
    private_subnets = ["10.0.0.0/19", "10.0.32.0/19"]
}

# Appel du module Bastion
module "bastion" {
    source = "./modules/bastion"
    allowed_cidr_blocks = ["0.0.0.0/0"]
    private_subnets = module.network.private_subnets
    public_subnets = module.network.public_subnets
    vpc_cidr_block = module.network.vpc_cidr_block
    vpc_id = module.network.vpc_id
    instance_type = "t2.medium"
    ami = "ami-00ac45f3035ff009e"
    cluster_security_group_id = module.kubernetes.eks_cluster_security_group_id
    depends_on = [
        module.network,
        module.kubernetes
        ]
    cluster_name = module.kubernetes.cluster_name
}

# Appel du module EKS
module "kubernetes" {
    source = "./modules/kubernetes"
    vpc_id = module.network.vpc_id
    private_subnets = module.network.private_subnets
    public_subnets = module.network.public_subnets
    lb_name = ""
    lb_tg_name = "ci-sockshop-k8s-tg"
    node_group_1_name = "node-group-1"
    node_group_2_name = "node-group-2"
    node_max_capacity = 3
    node_min_capacity = 1
    key_name = "your-key-name"
    aws_amis = ""
    private_key_path = ""
    node_instance_type = ["t3.medium"]
    node_desired_capacity = 2
}

# Appel du module RDS
module "database" {
    source = "./modules/rds"
    vpc_id = module.network.vpc_id
    vpc_cidr_block = module.network.vpc_cidr_block
    private_subnets = module.network.private_subnets
    public_subnets = module.network.public_subnets
    sg_tag_name = "sg-db"
    tag_subnet_group = "subnet-group-1"
    subnet_group_name = "my-subnet-group"
    instance_class = "db.t3.micro"
    db_name = "firt"
    db_instance_username = "admin"
    db_instance_allocated_storage = "5"
    publicly_accessible = "true"
    parameter_group_name = "default.mysql5.7"
    db_port = "3306"
    eks_cluster_security_group_id = [module.kubernetes.eks_node_security_group_id]
    engine = "mysql"
    engine_version = "5.7"
        depends_on = [
        module.network,
        module.bastion,
        module.kubernetes
        ]
}

# Appel du module de déploiement des applications
module "app" {
  source = "./modules/app"
  cluster_name = module.kubernetes.cluster_name
  cluster_endpoint = module.kubernetes.eks_cluster_endpoint
  cluster_ca_certificate = module.kubernetes.eks_cluster_ca_certificate
  cluster_token = module.kubernetes.eks_cluster_token
}

module "prometheus" {
  source = "./modules/prometheus"
  cluster_name = module.kubernetes.cluster_name
  cluster_endpoint = module.kubernetes.eks_cluster_endpoint
  cluster_ca_certificate = module.kubernetes.eks_cluster_ca_certificate
  cluster_token = module.kubernetes.eks_cluster_token
}
module "vpc" {
    source = "./modules/vpc"
    cidr_block = var.cidr_block
    project_name = var.project_name

}
module "security_groups" {
    source = "./modules/security_groups"
    vpc_id = module.vpc.vpc_id
    ec2_ip = var.ec2_ip

}

module "ec2" {
    source = "./modules/ec2"
    subnet_id = module.vpc.public_subnet_1
    sg_id = module.security_groups.ec2_sg_id
    key_name = "linux-key"
    ami = "ami-0c02fb55956c7d316"

}

module "alb" {
  source ="./modules/alb"
  vpc_id = module.vpc.vpc_id
  subnet_ids = [module.vpc.public_subnet_1,module.vpc.public_subnet_2]
  alb_sg = module.security_groups.alb_sg_id
  target_instance_id = module.ec2.instance_id
}


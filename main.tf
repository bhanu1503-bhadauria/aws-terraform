provider "aws" {
    region = var.region
}

module "VPC" {
  source = "./modules/VPC/"

  vpc_cidr = "10.0.0.0/16"
  
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]

}


module "SG" {
  source = "./modules/SG/"

  vpc-id = module.VPC.VPC_id
}

module "ALB" {
  source = "./modules/ALB/"

  security_group_id = module.SG.sg_id
  aws_subnet_public = module.VPC.public_subnet_ids
  vpc-id = module.VPC.VPC_id
  
}

module "ASG" {
  source = "./modules/ASG/"

  aws_subnet_public = module.VPC.public_subnet_ids
  tg_arn            = module.ALB.tg_arn
  security_group_id = module.SG.sg_id
  ecs-instance-profile-name = module.ECS.ecs-instance-profile-name

}

module "ECS" {
  source = "./modules/ECS/"
  
  ecs-target-group-arn = module.ALB.tg_arn
  ecs-lb-arn           = module.ALB.lb-arn
}


#remember to open all the tcp ports when using sg in ecs
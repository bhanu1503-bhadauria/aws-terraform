resource "aws_vpc" "bhanu-vpc" {
    cidr_block           = var.vpc_cidr
    enable_dns_hostnames = true
    tags = {
        Name = "bhanu-vpc"
    }
}

module "subnets" {
    source = "./modules/subnets/"
    
    vpc-id          = aws_vpc.bhanu-vpc.id
    azs             = var.azs
    public_subnets  = var.public_subnets
    private_subnets = var.private_subnets

}






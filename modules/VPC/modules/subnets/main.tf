resource "aws_subnet" "public-subnet" {
    count             = length(var.public_subnets)
    cidr_block        = element(var.public_subnets,count.index)
    vpc_id            = var.vpc-id
    availability_zone = element(var.azs,count.index)
    map_public_ip_on_launch = true
    tags = {
        Name = "bhanuPB"
    }
}

resource "aws_subnet" "private-subnet" {
    count             = length(var.private_subnets)
    cidr_block        = element(var.private_subnets,count.index)
    vpc_id            = var.vpc-id
    availability_zone = element(var.azs,count.index)
    tags = {
        Name = "bhanuPR"
    }
}

module "routeTables" {
    source = "./modules/routeTables/"
    
    vpc-id            = var.vpc-id
    public_subnet_id  = aws_subnet.public-subnet.*.id
    private_subnet_id = aws_subnet.private-subnet.*.id
    nat_subnet_id     = aws_subnet.public-subnet[0].id

}



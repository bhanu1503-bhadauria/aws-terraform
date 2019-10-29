resource "aws_route_table" "public-route-table" {
    vpc_id = var.vpc-id
    tags = {
        Name = "bhanuPBRT"
    }
}                                                                                                                          

resource "aws_route_table" "private-route-table" {
    vpc_id = var.vpc-id
    tags = {
        Name = "bhanuPRRT"
    }
}

resource "aws_route_table_association" "public-route-1-association" {
    count          = length(var.public_subnet_id)
    route_table_id = aws_route_table.public-route-table.id
    subnet_id      = element(var.public_subnet_id, count.index)
}

resource "aws_route_table_association" "private-route-1-association" {
    count          = length(var.private_subnet_id)
    route_table_id = aws_route_table.private-route-table.id
    subnet_id      = element(var.private_subnet_id, count.index)
}

resource "aws_eip" "elastic-ip-for-nat-gw" {
    vpc = true
    tags = {
        Name = "bhanuEIP"
    }
}

resource "aws_nat_gateway" "nat-gw" {
    allocation_id = aws_eip.elastic-ip-for-nat-gw.id
    subnet_id     = var.nat_subnet_id
    tags = {
        Name = "bhanu-NAT-GW"
    }
    depends_on = ["aws_eip.elastic-ip-for-nat-gw"]
}

resource "aws_route" "nat-gw-route" {
    route_table_id         = aws_route_table.private-route-table.id
    nat_gateway_id         = aws_nat_gateway.nat-gw.id
    destination_cidr_block = "0.0.0.0/0"
}

resource "aws_internet_gateway" "bhanu-igw" {
    vpc_id = var.vpc-id
    tags = {
        Name = "bhanu-IGW"
    }
}

resource "aws_route" "public-internet-igw-route" {
    route_table_id         = aws_route_table.public-route-table.id
    gateway_id             = aws_internet_gateway.bhanu-igw.id
    destination_cidr_block = "0.0.0.0/0"
}
output "VPC_id" {
  value = aws_vpc.bhanu-vpc.id
}

output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}
variable "vpc-id" {
    type    = string
    default = ""
}

variable "public_subnet_id" {
    type    = list
    default = []
}

variable "private_subnet_id" {
    type    = list
    default = []
}

variable "nat_subnet_id" {
    type    = string
}

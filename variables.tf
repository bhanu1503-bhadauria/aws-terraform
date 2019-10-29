variable "region" {
    default = "us-east-1"
}

variable "vpc_cidr" {
    type    =  string
    default = "10.0.0.0/24"
}

variable "azs" {
    type    = list(string)
    default = []
}

variable "private_subnets" {
    type    = list(string)
    default = []
}

variable "public_subnets" {
    type    = list(string)
    default = []
}



variable "vpc-id" {
    type = string
    default = ""
}

variable "security_group_id" {
    type = string
    default = ""
}

variable "aws_subnet_public" {
    type = list(string)
    default = []
}


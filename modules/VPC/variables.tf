variable "vpc_cidr" {
        description = "CIDR Block for VPC"
        type        = string
}

variable "public_subnets" {
        description = "CIDR Block for Public Subnet 1"
        type        = list(string)
        default     = []
}

variable "private_subnets" {
        description = "CIDR Block for Private Subnet 1"
        type        = list(string)
        default     = []
}

variable "azs" {
        description = "Availabilty Zones"
        type        = list(string)
        default     = []
}

variable "vpc-id" {
        type        = string
        default     = ""
}

variable "VPC_id" {
        type        = string
        default     = ""
}

variable "public_subnet_ids" {
        type        = list(string)
        default     = []
}





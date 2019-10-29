variable "vpc-id" {
        description = "vpc id"
        type        = string
}

variable "public_subnets" {
        description = "CIDR Block for Public Subnet 1"
        type        = list
        default     = []
}

variable "private_subnets" {
        description = "CIDR Block for Private Subnet 1"
        type        = list
        default     = []
}

variable "azs" {
        description = "Availabilty Zones"
        type        = list
        default     = []
}

variable "public_subnet_ids" {
        type        = list
        default     = []
}


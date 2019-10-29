variable "aws_subnet_public" {
    description = "public subnet ids"
    type        = list(string)
    default     = []
}

variable "tg_arn" {
    description = "Target group arn"
    type        = string
    default     = ""
}

variable "security_group_id" {
    type        = string
    default     = ""
}

variable "ecs-instance-profile-name" {
    type        = string
    default     = ""
}


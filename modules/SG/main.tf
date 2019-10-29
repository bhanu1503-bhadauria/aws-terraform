resource "aws_security_group" "bhanuSG" {
    vpc_id = var.vpc-id
    
    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
    }

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
    }    

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
    }

    egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name = "bhanuSG"
    }
}
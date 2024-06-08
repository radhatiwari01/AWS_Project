variable "ami_east01" {
    description = "value for the ami"
    default = "ami-00beae93a2d981137"
}

variable "instance_type" {
    description = "value for instance_type"
    default = "t2.small"
}

variable "instance_key" {
    description = "value for instance key pair"
    default = "ec2_virginia"
}

resource "aws_vpc" "ohio_vpc" {
  cidr_block = "10.0.1.0/24"
 }

resource "aws_subnet" "ohio_sbnet" {
  vpc_id     = aws_vpc.ohio_vpc.id
  cidr_block = "10.0.1.0/28"
}

resource "aws_internet_gateway" "ohio_igw" {
  vpc_id = aws_vpc.ohio_vpc.id
}

resource "aws_route_table" "rt_ohio" {
  vpc_id = aws_vpc.ohio_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ohio_igw.id
  }
}

resource "aws_route_table_association" "ohio_rt_association" {
  subnet_id      = aws_subnet.ohio_sbnet.id
  route_table_id = aws_route_table.rt_ohio.id
}

resource "aws_security_group" "ohio_secgrp" {
  name        = "ohio_secgrp"
  vpc_id      = aws_vpc.ohio_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.ohio_secgrp.id
  cidr_ipv4         = aws_vpc.ohio_vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.ohio_secgrp.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.ohio_secgrp.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# EC2 Instance in Ohio Region : us-east-2
resource "aws_instance" "ec2_ohio" {
  ami           = var.ami_east02
  instance_type = var.instance_type
  key_name = var.instance_key
  subnet_id     = aws_subnet.ohio_sbnet.id
  vpc_security_group_ids = [aws_security_group.ohio_secgrp.id]
}
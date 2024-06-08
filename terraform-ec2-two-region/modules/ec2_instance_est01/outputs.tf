output "public-ip-address" {
  value = aws_instance.ec2_virginia.public_ip
}
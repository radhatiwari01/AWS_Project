
output "public-ip-address" {
  value = aws_instance.ec2_ohio.public_ip
}
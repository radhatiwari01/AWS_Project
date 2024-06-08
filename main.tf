
# Calling the modules to create EC2 instances
module "ec2_instance_est01" {
  source   = "./modules/ec2_instance_est01"
}

module "ec2_instance_est02" {
  source  = "./modules/ec2_instance_est02"
}
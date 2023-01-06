################################
######     Variables      ######
################################

# Resource Name
variable "resource_name" {
  type    = string
  default = "simple-taiko-node-lightsail"
}

# Keypair name
variable "keypair_name" {
  type    = string
  default = "simple-taiko-node-keypair"
}

# Region 
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

# Availability Zone
variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

# OS Blueprint ID
variable "blueprint_id" {
  type    = string
  default = "ubuntu_20_04"
}

# Instance Bundle ID
variable "bundle_id" {
  type    = string
  default = "small_2_0"
}
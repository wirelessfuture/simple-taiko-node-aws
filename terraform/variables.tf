################################
######     Variables      ######
################################

variable "resource_name" {
  type        = string
  description = "The name of the instance resource in AWS"
  default     = "simple-taiko-node-lightsail"
}

variable "keypair_name" {
  type        = string
  description = "The name of the keypair for the instance"
  default     = "simple-taiko-node-keypair"
}

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy the instance to"
  default     = "us-east-1"
}

variable "availability_zone" {
  type        = string
  description = "The AWS availability zone to deploy the instance to"
  default     = "us-east-1a"
}

variable "blueprint_id" {
  type        = string
  description = "The OS blueprint ID for the instance"
  default     = "ubuntu_20_04"
}

variable "bundle_id" {
  type        = string
  description = "The bundle ID for the instance type"
  default     = "medium_2_0"
}

variable "grafana_port_allowed_ip" {
  type        = list(string)
  description = "The allowed IP address for port 3000 (grafana dashboard) on your taiko instance"
  default     = ["0.0.0.0/32"]
}
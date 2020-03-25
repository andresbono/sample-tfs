locals {
  # Bootstrap script to be executed at init time
  bootstrap_file = "userdata/bootstrap.sh"

  # cloud-init configuration file
  cloud_init_config_file = "userdata/init.cfg"
}

variable "bundle_tgz_uri" {
  description = "Link to the provisioner bundle."
}
variable "custom_userdata" {
  description = "Custom user-data to pass to the bootstrap script."
}

variable "nodes_count" {
  description = "Number of nodes to deploy."
  default     = "1"
}

variable "deployment_short_name" {
  description = "Name of the deployment, short way."
}

variable "zone" {
  description = "Zone name."
}

variable "vpc_id" {
  description = "ID of the vpc where the instance will be attached to."
}

variable "subnet_id" {
  description = "ID of the subnet where the instance will be attached to."
}

variable "instance_profile" {
  description = "Size of each instance."
}

variable "ssh_key" {
  description = "Name of the existing IBM VPC SSH key to be used on the instance."
}

variable "volume_profile" {
  description = "IOPS tier of the data volumes."
}

variable "volume_size" {
  description = "Size of the data volume in GBs."
}

variable "tier" {
  description = "Name of the tier of the node."
}

variable "app_password" {
  description = "Application password."
}

variable "peer_password" {
  description = "Application password."
}

variable "peer_address" {
  description = "Peer address."
  default = "localhost"
}

variable "set_public_ips" {
  description = "True/false flag to assign public IPs to the instances."
  default     = false
}

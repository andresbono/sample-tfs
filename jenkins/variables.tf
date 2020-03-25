locals {
  application = "jenkins"
  version     = "2.204.1-1"
  # Link to the provisioner bundle
  bundle_tgz_uri = "${var.bundle_tgz_uri == "" ? "https://downloads.bitnami.com/files/nami/provisioner-bundles/provisioner-${local.application}-${local.version}-bundle-ibmvpc.tar.gz" : var.bundle_tgz_uri}"
}

variable "deployment_short_name" {
  description = "Name of the deployment, short way. (e.g. mydeployment)."
  default     = "mydeployment"
}

# Location
variable "region" {
  description = "Region name, (e.g. us-south)."
  default     = "us-south"
}

variable "zone" {
  description = "Zone name, (e.g. us-south-1)."
  default     = "us-south-1"
}

# Compute
variable "nodes_count" {
  description = "Number of instances to deploy. (Minimum recommended: 3)."
  default     = "3"
}

variable "instance_profile" {
  description = "Size of each instance. (Minimum recommended: bx2-2x8)."
  default     = "bx2-2x8"
}

variable "volume_size" {
  description = "Size of the data volume in GBs. (Minimum recommended: 50)."
  default     = "50"
}

variable "volume_profile" {
  description = "IOPS tier of the data volumes."
  default     = "10iops-tier"
}

variable "app_password" {
  description = "Application password for Jenkins, username is 'user'. (Auto-generated if not provided)"
  default     = ""
}

variable "bundle_tgz_uri" {
  description = "Link to the provisioner bundle."
  default     = ""
}

variable "custom_userdata" {
  description = "Custom user-data to pass to the bootstrap script."
  default     = ""
}

variable "ssh_key" {
  description = "Name of the existing IBM VPC SSH key to be used on the instances."
}

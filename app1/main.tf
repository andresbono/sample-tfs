# variable "ibmcloud_api_key" {
#   description = "Enter your IBM Cloud API Key, you can get your IBM Cloud API key using: https://cloud.ibm.com/iam#/apikeys."
# }

variable "generation" {
  description = "Target the generation of compute resources. Default is '2'. You must set the value to '1' to access generation 1 resources."
  default     = 2
}

variable "region" {
  description = "The region to create your VPC in, such as `us-south`. To get a list of all regions, run `ibmcloud is regions` for target generation."
  default     = "us-south"
}

provider "ibm" {
  # ibmcloud_api_key = "${var.ibmcloud_api_key}"
  generation = "${var.generation}"
  region     = "${var.region}"
}

module "vpc" {
  source = "modules/dummy"
}

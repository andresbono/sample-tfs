provider "ibm" {
  region = "${var.region}"
}

module network {
  source                = "./modules/network"
  deployment_short_name = "${var.deployment_short_name}"
  zone                  = "${var.zone}"
}

module master {
  source = "./modules/node"

  deployment_short_name = "${var.deployment_short_name}"
  zone                  = "${var.zone}"
  vpc_id                = "${module.network.vpc_id}"
  subnet_id             = "${module.network.subnet_id}"
  instance_profile      = "${var.instance_profile}"
  ssh_key               = "${var.ssh_key}"

  volume_profile = "${var.volume_profile}"
  volume_size    = "${var.volume_size}"

  tier            = "master"
  bundle_tgz_uri  = "${local.bundle_tgz_uri}"
  custom_userdata = "${var.custom_userdata}"
  app_password    = "${local.app_password}"
  peer_password   = "${random_string.peer_password.result}"
  set_public_ips  = true
}

module slave {
  source = "./modules/node"

  nodes_count           = "${var.nodes_count - 1}"
  deployment_short_name = "${var.deployment_short_name}"
  zone                  = "${var.zone}"
  vpc_id                = "${module.network.vpc_id}"
  subnet_id             = "${module.network.subnet_id}"
  instance_profile      = "${var.instance_profile}"
  ssh_key               = "${var.ssh_key}"

  volume_profile = "${var.volume_profile}"
  volume_size    = "${var.volume_size}"

  tier            = "slave"
  bundle_tgz_uri  = "${local.bundle_tgz_uri}"
  custom_userdata = "${var.custom_userdata}"
  app_password    = "${local.app_password}"
  peer_password   = "${random_string.peer_password.result}"
  peer_address    = "${length(module.master.ips) > 0 ? module.master.ips[0] : ""}"
}

# Password generation
resource "random_string" "peer_password" {
  length  = 16
  special = false
}

resource "random_string" "app_password" {
  length  = 12
  special = false
}

locals {
  app_password = "${var.app_password == "" ? random_string.app_password.result : var.app_password}"
}

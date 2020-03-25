data ibm_is_image "base_image" {
  name = "ibm-centos-7-6-minimal-amd64-1"
}

data "ibm_is_ssh_key" "ssh_key" {
  name = "${var.ssh_key}"
}

resource "ibm_is_instance" "instance" {
  count = "${var.nodes_count}"

  name    = "${var.deployment_short_name}-instance-${var.tier}${count.index}"
  image   = "${data.ibm_is_image.base_image.id}"
  profile = "${var.instance_profile}"

  primary_network_interface {
    subnet = "${var.subnet_id}"
  }

  vpc  = "${var.vpc_id}"
  zone = "${var.zone}"
  keys = ["${data.ibm_is_ssh_key.ssh_key.id}"]

  volumes = ["${ibm_is_volume.volume[count.index].id}"]

  user_data = "${data.template_cloudinit_config.userdata_instance[count.index].rendered}"
}

resource "ibm_is_volume" "volume" {
  count = "${var.nodes_count}"

  name     = "${var.deployment_short_name}-volume-${var.tier}${count.index}"
  profile  = "${var.volume_profile}"
  zone     = "${var.zone}"
  capacity = "${var.volume_size}"
}

data "template_cloudinit_config" "userdata_instance" {
  count = "${var.nodes_count}"

  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = "${file(local.cloud_init_config_file)}"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.userdata_script_instance[count.index].rendered}"
  }
}

data "template_file" "userdata_script_instance" {
  count = "${var.nodes_count}"

  template = "${file(local.bootstrap_file)}"

  vars = {
    bundle_tgz_uri = "${var.bundle_tgz_uri}"

    custom_userdata = "${var.custom_userdata}"

    provisioner_shared_unique_id_input = "${var.subnet_id}${var.deployment_short_name}"
    provisioner_tier                   = "${var.tier}"
    provisioner_app_password           = "${var.app_password}"
    provisioner_peer_password          = "${var.peer_password}"
    provisioner_peer_address           = "${var.peer_address}"
  }
}

resource "ibm_is_floating_ip" "public_ip" {
  count = "${var.set_public_ips ? var.nodes_count : 0}"
  name   = "${var.deployment_short_name}-public-ip-${var.tier}${count.index}"
  target = "${ibm_is_instance.instance[count.index].primary_network_interface.0.id}"
}

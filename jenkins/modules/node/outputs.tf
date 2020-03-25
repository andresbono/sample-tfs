output "ips" {
  value = "${ibm_is_instance.instance.*.primary_network_interface.0.primary_ipv4_address}"
}

output "names" {
  value = "${ibm_is_instance.instance.*.name}"
}

output "public_ips" {
  value = "${ibm_is_floating_ip.public_ip.*.address}"
}

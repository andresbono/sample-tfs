output "ApplicationUser" {
  value = "user"
}

output "ApplicationPassword" {
  value     = "${var.app_password == "" ? local.app_password : "Password provided as input"}"
  sensitive = true
}

output "PrivateIps" {
  value = "${flatten([module.master.*.ips, module.slave.*.ips])}"
}

output "InstanceNames" {
  value = "${flatten([module.master.*.names, module.slave.*.names])}"
}

output "PublicIps" {
  value = "${flatten([module.master.*.public_ips, module.slave.*.public_ips])}"
}

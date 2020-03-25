output "ApplicationUser" {
  value = "user"
}

output "ApplicationPassword" {
  value     = "${var.app_password == "" ? local.app_password : "Password provided as input"}"
  sensitive = true
}

output "PrivateIps" {
  value = "${flatten(list(module.master.ips, module.slave.ips))}"
}

output "InstanceNames" {
  value = "${flatten(list(module.master.names, module.slave.names))}"
}

output "PublicIps" {
  value = "${flatten(list(module.master.public_ips, module.slave.public_ips))}"
}

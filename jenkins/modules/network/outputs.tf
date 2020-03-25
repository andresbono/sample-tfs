output "subnet_id" {
  value = "${ibm_is_subnet.subnet.id}"
}

output "vpc_id" {
  value = "${ibm_is_vpc.vpc.id}"
}

resource "ibm_is_vpc" "vpc" {
  name = "${var.deployment_short_name}-vpc"
}

resource "ibm_is_subnet" "subnet" {
  name                     = "${var.deployment_short_name}-subnet"
  vpc                      = "${ibm_is_vpc.vpc.id}"
  zone                     = "${var.zone}"
  total_ipv4_address_count = "32"
  public_gateway           = "${ibm_is_public_gateway.public_gateway.id}"
}

resource "ibm_is_security_group_rule" "sg_rule_22" {
  group     = "${ibm_is_vpc.vpc.default_security_group}"
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "sg_rule_80" {
  group     = "${ibm_is_vpc.vpc.default_security_group}"
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 80
    port_max = 80
  }
}

resource "ibm_is_security_group_rule" "sg_rule_443" {
  group     = "${ibm_is_vpc.vpc.default_security_group}"
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 443
    port_max = 443
  }
}

resource "ibm_is_public_gateway" "public_gateway" {
  name = "${var.deployment_short_name}-public-gateway"
  vpc  = "${ibm_is_vpc.vpc.id}"
  zone = "${var.zone}"
}

variable "do_token" {}

module "master" {

  source    = "./master"

  do_token  = "${var.do_token}"
}

module "worker" {

  source    = "./worker"

  do_token  = "${var.do_token}"

  droplet_number = 2
}

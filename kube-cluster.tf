variable "do_token" {}

module "master" {

  source    = "./master"

  do_token  = "${var.do_token}"
}

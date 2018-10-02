variable "do_token" {}

variable "droplet_number" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "kube-worker" {
  name      = "worker-${count.index}"
  size      = "4gb"
  image     = "ubuntu-16-04-x64"
  region    = "sgp1"
  ssh_keys  = ["22720452"]
  monitoring= true
  user_data = "${file("${path.module}/worker-user-data.sh")}"

  count     = "${var.droplet_number}"
}

resource "digitalocean_firewall" "kube-worker" {
  name = "worker"

  droplet_ids = ["${digitalocean_droplet.kube-worker.*.id}"]

  inbound_rule = [
    {
      protocol           = "tcp"
      port_range         = "22"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol           = "tcp"
      port_range         = "10250"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol           = "tcp"
      port_range         = "30000-32767"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    }
  ]

  outbound_rule = [
    {
      protocol                = "tcp"
      port_range              = "1-65535"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol                = "udp"
      port_range              = "1-65535"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol                = "icmp"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    }
  ]
}

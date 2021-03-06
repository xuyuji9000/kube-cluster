variable "do_token" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

# resource "digitalocean_ssh_key" "default" {
#   name       = "Terraform Example"
#   public_key = "${file("/Users/yogiman/.ssh/id_rsa.pub")}"
# }

resource "digitalocean_droplet" "kube-master" {
  name      = "master-1"
  size      = "4gb"
  image     = "38963259"
  region    = "sgp1"
  ssh_keys  = ["22720452"]
  monitoring= true
  # user_data = "${file("${path.module}/user-data.sh")}"

  provisioner "file" {
    connection {
      type     = "ssh"
      user     = "root"
      private_key = "${file("/Users/yogiman/.ssh/id_rsa")}"
    }

    source      = "${path.module}/user-data.sh"
    destination = "/tmp/user-data.sh"
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "root"
      private_key = "${file("/Users/yogiman/.ssh/id_rsa")}"
    }

    inline = [
      "chmod +x /tmp/user-data.sh",
      "/tmp/user-data.sh",
    ]
  }
}

resource "digitalocean_firewall" "kube-master" {
  name = "master"

  droplet_ids = ["${digitalocean_droplet.kube-master.id}"]

  inbound_rule = [
    {
      protocol           = "tcp"
      port_range         = "22"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol           = "tcp"
      port_range         = "6443"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol           = "tcp"
      port_range         = "2379-2380"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol           = "tcp"
      port_range         = "10250"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol           = "tcp"
      port_range         = "10251"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol           = "tcp"
      port_range         = "10252"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol                = "icmp"
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

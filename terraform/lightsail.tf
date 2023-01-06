################################
######     Lightsail      ######
################################

resource "aws_lightsail_instance" "simple_taiko_node_lightsail" {
  name              = var.resource_name
  availability_zone = var.availability_zone
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  key_pair_name     = aws_lightsail_key_pair.simple_taiko_node_keypair.name

  provisioner "file" {
    source      = "../init.sh"
    destination = "/home/ubuntu/init.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/init.sh",
      "sudo /home/ubuntu/init.sh",
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = aws_lightsail_key_pair.simple_taiko_node_keypair.private_key
    host        = self.ipv6_addresses[0]
  }

  depends_on = [
    aws_lightsail_key_pair.simple_taiko_node_keypair
  ]
}

resource "aws_lightsail_key_pair" "simple_taiko_node_keypair" {
  name = var.keypair_name
}
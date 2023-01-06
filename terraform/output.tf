##############################
######     Outputs      ######
##############################

output "keypair_private_key" {
  value     = aws_lightsail_key_pair.simple_taiko_node_keypair.private_key
  sensitive = true
}

output "keypair_public_key" {
  value = aws_lightsail_key_pair.simple_taiko_node_keypair.public_key
}
output "ec2_public_ip"{
  value = module.myapp-server.instance_public_ip
}
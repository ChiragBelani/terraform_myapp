output "instance_public_ip" {
    value = aws_instance.myapp-server.public_ip
}
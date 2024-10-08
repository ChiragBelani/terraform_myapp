resource "aws_security_group" "myapp-sg" {
  name   = "myapp-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip,"0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_prefix}-sg"
  }
}



data "aws_ami" "latest-amazon-linux-images"{
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = [var.image_name]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

# resource "aws_key_pair" "ssh-key"{
#   key_name = "server-key"
#   public_key = file(var.public_key_location)
# }

resource "aws_instance" "myapp-server" {
  ami                    = data.aws_ami.latest-amazon-linux-images.id
  instance_type          = "t2.micro"

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.myapp-sg.id]
  availability_zone      = var.avail_zone

  associate_public_ip_address = true
  key_name                    = "server-key"

  user_data = <<-EOF
              #!/bin/bash
              mkdir chirag
              sudo yum update -y
              sudo yum install -y docker
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ec2-user
              sudo docker run -d -p 8080:80 nginx
            EOF


  tags = {
    Name = "${var.env_prefix}-server"
  }
}

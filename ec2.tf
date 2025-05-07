resource "aws_instance" "web_server" {
  count             = (local.env == "test" || local.env == "qa") ? 2 : 3
  ami               = lookup(var.ami, var.region)
  instance_type     = var.instance_type
  subnet_id         = element(aws_subnet.public-subnets[*].id, count.index)
  vpc_security_group_ids = [aws_security_group.allow-all-sg.id]
  key_name          = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${local.vpc_name}-web-server-${count.index + 1}"
    Env  = var.env
    Owner = "Terraform"
    Project = "WebServer"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo dnf update -y
              yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo "<h1>${local.vpc_name}-Web-Server-${count.index + 1}</h1>" > /usr/share/nginx/html/index.html
            EOF
    lifecycle {
      create_before_destroy = true
    }    
}
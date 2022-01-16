provider "aws" {
  region = var.region
}

resource "aws_instance" "jenkins_srv" {
  ami = var.os_image
  instance_type = var.instance_type
  key_name = "aws_key"
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  tags = merge(var.common_tags, {Name = "Ubuntu with Jenkins"})
}

resource "aws_instance" "docker_srv" {
  ami = var.os_image
  instance_type = var.instance_type
  key_name = "aws_key"
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  tags = merge(var.common_tags, {Name = "Ubuntu with Docker"})
}

resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins_srv.id
}

resource "aws_eip" "docker_eip" {
  instance = aws_instance.docker_srv.id
}

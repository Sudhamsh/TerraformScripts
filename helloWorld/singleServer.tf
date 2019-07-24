#Cloud provider
provider "aws" {
  profile    = "default"
  region     = "us-west-2"
}

#create security group
resource "aws_security_group" "instance"{
 name="terraform-helloworld-instance"
 
 ingress{
  from_port=8080
  to_port=8080
  protocol="tcp"
  cidr_blocks=["0.0.0.0/0"]
 }
}

#What resource actions we want this script to perform
resource "aws_instance" "web" {
  ami           = "ami-06ec2d70c47a72616"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  #Take some actions on locally on the server
  user_data = <<-EOF
  			  #!/bin/bash
  			  echo "Hello World. Terraform Rocks IaC" > index.html
  			  nohup busybox httpd -f -p 8080 &
  			  EOF
  			  
  #Take some actions on locally on the server
  provisioner "local-exec" {
    command = "echo ${aws_instance.web.public_ip} > ip_address.txt"
  }
}

provider "aws" {
  profile    = "default"
  region     = "us-west-2"
}

resource "aws_instance" "web" {
  ami           = "ami-07669fc90e6e6cc47"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.web.public_ip} > ip_address.txt"
  }
  
}

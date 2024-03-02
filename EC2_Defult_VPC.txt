provider "aws" {
  region = "us-east-1" # Set your desired AWS region
}

resource "aws_instance" "example" {
  count         = 4  # Set the desired number of instances
  ami           = "ami-0cd59ecaf368e5ccf" # Replace with your desired AMI ID
  instance_type = "t2.micro"              # Replace with your desired instance type
  key_name      = "virginia"             # Replace with your key pair name
  associate_public_ip_address = true      # Add this line to associate a public IP

  tags = {
    Name = "MY-Instance-${count.index + 1}"  # Set a name for your instances
  }
}

resource "aws_instance" "example_1" {
  count         = 1  # Set the desired number of instances
  ami           = "ami-0cd59ecaf368e5ccf" # Ubuntu 20.04 AMI ID
  instance_type = "t2.medium"              # t2 medium instance type
  key_name      = "virginia" 
  associate_public_ip_address = true       # Add this line to associate a public IP

  tags = {
    Name = "K8S-Master"             # Set a name for your instance
  }
}

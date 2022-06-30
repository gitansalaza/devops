# Create a Security Group
resource "aws_security_group" "tf_sg" {
  name = "tf_sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Key Pair
resource "aws_key_pair" "tf_kp" {
  key_name   = "tf_kp"
  public_key = tls_private_key.rsa.public_key_openssh
}

# Choose RSA algorithm for the private key 
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits = 4096
}

# Create private key
resource "local_file" "tf_pk_pem" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tf_kp.pem"
}

provider random {}

resource "random_pet" "name" {}

# Create a new Linux Ubuntu EC2 Instance
resource "aws_instance" "ubuntu_00" {
  ami = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.tf_sg.name]
  key_name = "tf_kp"

  tags = {
    Name = random_pet.name.id
  }
}


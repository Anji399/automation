# If you have your default VPC available then 

packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "mpr-aws-ubuntu"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami = "ami-007855ac798b5175e"
  ssh_username = "ubuntu"
}

build {
  name = "mpr-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
}

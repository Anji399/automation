data "aws_ami" "ami" {
  most_recent = true
  name_regex       = "^mpr_*"
  owners = ["378032438507"] 

   filter {
    name   = "virtualization-type"
    values = ["hvm"]  
}

}


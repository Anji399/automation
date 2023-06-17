resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_policy"
  role = aws_iam_role.ec2_role.id

 
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_role.name
}
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role       = aws_iam_role.ec2_role.name
}
resource "aws_instance" "ec2" {
  ami           = data.aws_ami.ami.id
  instance_type = "${var.ec2_class}"
  key_name  = "${var.key_pair}"
  subnet_id = "${var.subnet_1a}"
  vpc_security_group_ids = ["${aws_security_group.ec2-sg.id}"]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "${var.product}.${var.environment}-ec2"
  }
}

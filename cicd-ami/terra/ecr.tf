
resource "aws_ecr_repository" "demo-repository" {
       name = "canara"
       image_tag_mutability = "MUTABLE"

       image_scanning_configuration {
         scan_on_push = true
       }
}


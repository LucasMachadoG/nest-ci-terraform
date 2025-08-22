resource "aws_ecr_repository" "nest-ci-terraform-api" {
  name = "nest-ci"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    IAC = true
  }
}
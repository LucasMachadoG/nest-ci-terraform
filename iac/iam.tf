resource "aws_iam_openid_connect_provider" "opc-git" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = []

  tags = {
    IAC = "true"
  }
}

resource "aws_iam_role" "ecr-role" {
  name = "ecr-role"

  assume_role_policy = jsonencode({
    Version: "2012-10-17",
    Statement: [
      {
        Effect: "Allow",
        Action: "sts:AssumeRoleWithWebIdentity",
        Principal: {
          Federated: "arn:aws:iam::292659699009:oidc-provider/token.actions.githubusercontent.com",
        },
        Condition: {
          StringEquals: {
            "token.actions.githubusercontent.com:aud": ["sts.amazonaws.com"],
          },
          StringLike: {
            "token.actions.githubusercontent.com:sub": [
              "repo:LucasMachadoG/nest-ci-terraform:ref:refs/heads/master",
            ],
          },
        },
      },
    ],
  })

  tags = {
    IAC = true
  }
}

resource "aws_iam_role_policy" "ecr_app_permissions" {
  name = "ecr-app-permissions"
  role = aws_iam_role.ecr-role.name

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Sid      = "Statement1"
        Effect   = "Allow"
        Action   = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:GetAuthorizationToken",
        ]
        Resource = "*"
      }
    ]
  })
}
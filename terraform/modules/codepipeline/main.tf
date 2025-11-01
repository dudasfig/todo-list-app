# bucket de artifacts do pipeline
resource "aws_s3_bucket" "artifacts" {
  bucket        = var.artifacts_bucket_name
  force_destroy = true
}

# role do pipeline
resource "aws_iam_role" "pipeline" {
  name               = "${var.project_name}-pipeline-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "codepipeline.amazonaws.com" },
      Action   = "sts:AssumeRole"
    }]
  })
}

# policy da role do pipeline (S3, CodeBuild e CodeStar)
resource "aws_iam_role_policy" "pipeline" {
  name = "${var.project_name}-pipeline-policy"
  role = aws_iam_role.pipeline.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [

      # S3 bucket access for pipeline and CodeBuild
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.artifacts.arn,
          "${aws_s3_bucket.artifacts.arn}/*"
        ]
      },

      # Allow CodePipeline to start CodeBuild jobs
      {
        Effect = "Allow"
        Action = [
          "codebuild:StartBuild",
          "codebuild:BatchGetBuilds"
        ]
        Resource = [
          var.build_project_arn,
          var.deploy_project_arn
        ]
      },

      # Allow CodePipeline to use GitHub connection
      {
        Effect = "Allow"
        Action = [
          "codestar-connections:UseConnection"
        ]
        Resource = var.codestar_connection_arn
      },

      # Allow CodePipeline to pass the LAB CodeBuild role
      {
        Effect = "Allow"
        Action = [
          "iam:PassRole"
        ]
        Resource = var.codebuild_service_role_arn
      }
    ]
  })
}

resource "aws_codepipeline" "pipeline" {
  name     = "${var.project_name}-pipeline"
  role_arn = aws_iam_role.pipeline.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.artifacts.bucket
  }

  ## SOURCE STAGE
  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["src"]

      configuration = {
        ConnectionArn    = var.codestar_connection_arn
        FullRepositoryId = var.github_full_repo_id
        BranchName       = var.github_branch
      }
    }
  }

  ## BUILD STAGE
  stage {
    name = "Build"

    action {
      name              = "Build"
      category          = "Build"
      owner             = "AWS"
      provider          = "CodeBuild"
      version           = "1"
      input_artifacts   = ["src"]
      output_artifacts  = ["buildOutput"]

      configuration = {
        ProjectName  = var.build_project_name
        PrimarySource = "src"          # <- importante
      }
    }
  }

  ## DEPLOY STAGE
  stage {
    name = "Deploy"

    action {
      name             = "Deploy"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["buildOutput"]

      configuration = {
        ProjectName = var.deploy_project_name
      }
    }
  }
}

output "pipeline_name" {
  value = aws_codepipeline.pipeline.name
}


# sua conexão CodeStar (Frankfurt)
codestar_connection_arn = "arn:aws:codeconnections:eu-central-1:325583868777:connection/ffc2d66f-be70-428b-8e37-d341b4ace88b"
github_full_repo_id = "dudasfig/todo-list-app"
github_branch       = "main"

# role do laboratório (NÃO troque)
codebuild_service_role_arn = "arn:aws:iam::325583868777:role/service-role/codebuild-asn-demo-lab-service-role"

# use o ECR existente que você mostrou no print:
ecr_repo_url = "325583868777.dkr.ecr.eu-central-1.amazonaws.com/esf-vppm/todo-list"

eks_cluster_name    = "eksDeepDiveFrankfurt"
k8s_namespace       = "default"
k8s_deployment_name = "todo-list"
ecs_cluster_name  = "ECS-esf-vppm"  # exemplo
ecs_service_name  = "ECS-esf-vppm-service" # nome do seu serviço no ECS
k8s_container_name  = "todo-list"



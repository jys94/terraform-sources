data "aws_caller_identity" "current" { }
module "my-ecs" {
  source         = "github.com/jys94/modules_dev//modules/ecs-cluster"
  VPC_ID         = module.vpc.vpc_id
  CLUSTER_NAME   = "my-ecs"
  INSTANCE_TYPE  = "t2.small"
  SSH_KEY_NAME   = var.KEY_PAIR_NAME
  VPC_SUBNETS    = join(",", module.vpc.public_subnets)
  ENABLE_SSH     = true
  SSH_SG         = aws_security_group.allow-ssh.id
  LOG_GROUP      = "my-log-group"
  AWS_ACCOUNT_ID = data.aws_caller_identity.current.account_id
  AWS_REGION     = var.AWS_REGION
}
module "my-service" {
  source              = "github.com/jys94/modules_dev//modules/ecs-service"
  VPC_ID              = module.vpc.vpc_id
  APPLICATION_NAME    = "my-service"
  APPLICATION_PORT    = "80"
  APPLICATION_VERSION = "latest"
  CLUSTER_ARN         = module.my-ecs.cluster_arn
  SERVICE_ROLE_ARN    = module.my-ecs.service_role_arn
  AWS_REGION          = var.AWS_REGION
  HEALTHCHECK_MATCHER = "200"
  LOG_GROUP           = "my-log-group"
  DESIRED_COUNT       = 2
  ALB_ARN             = module.my-alb.alb_arn
}
module "my-alb" {
  source             = "github.com/jys94/modules_dev//modules/alb"
  VPC_ID             = module.vpc.vpc_id
  ALB_NAME           = "my-alb"
  VPC_SUBNETS        = module.vpc.public_subnets
  DEFAULT_TARGET_ARN = module.my-service.target_group_arn
  DOMAIN             = "*.eksinfra.com"
  INTERNAL           = false
  ECS_SG             = module.my-ecs.cluster_sg
}
module "my-alb-rule" {
  source           = "github.com/jys94/modules_dev//modules/alb-rule"
  LISTENER_ARN     = module.my-alb.http_listener_arn
  PRIORITY         = 100
  TARGET_GROUP_ARN = module.my-service.target_group_arn
  CONDITION_FIELD  = "host-header"
  CONDITION_VALUES = ["subdomain.eksinfra.com"]
}
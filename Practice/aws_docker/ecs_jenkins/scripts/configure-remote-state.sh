#!/bin/bash

AWS_REGION="ap-northeast-2"
S3_BUCKET=`aws s3 ls --region $AWS_REGION |grep terraform-state |tail -n1 |cut -d ' ' -f3`
sed -i 's/terraform-state-xx70dpnh/'${S3_BUCKET}'/' backend.tf
sed -i 's/#//g' backend.tf
terraform init
terraform apply -target aws_ecs_service.myapp-service -var MYAPP_SERVICE_ENABLE="1" -var MYAPP_VERSION=${MYAPP_VERSION} -auto-approve
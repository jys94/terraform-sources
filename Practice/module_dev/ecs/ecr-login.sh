#!/bin/bash

REGION="ap-northeast-2"

aws ecr get-login-password --region ap-northeast-2 | \
docker login \
--username AWS \
--password-stdin 675936114596.dkr.ecr.ap-northeast-2.amazonaws.com
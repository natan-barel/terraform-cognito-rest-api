#!/bin/bash

user_pool_id=$(terraform output -raw user_pool_id)
#api_gateway_arn=$(terraform output -raw  api_gateway_arn | cut -d ":" -f 6)
client_id=$(terraform output -raw client_id)

#echo "api_gateway_arn: $api_gateway_arn"
echo "User pool id: $user_pool_id"
echo "Client id of the cognito user pool client: $client_id"

aws cognito-idp sign-up \
    --client-id "$client_id" \
    --username natan.barel@outlook.co.il \
    --password Pass@1234 \
    --user-attributes Name="email",Value="natan.barel@outlook.co.il" Name="name",Value="natan barel" \
    --region us-west-1 \
    --profile default

aws cognito-idp admin-confirm-sign-up \
    --user-pool-id "$user_pool_id" \
    --username natan.barel@outlook.co.il \
    --region us-west-1 \
    --profile default

aws cognito-idp admin-update-user-attributes \
    --user-pool-id "$user_pool_id" \
    --username natan.barel@outlook.co.il \
    --user-attributes Name=email_verified,Value=true \
    --region us-west-1 \
    --profile default

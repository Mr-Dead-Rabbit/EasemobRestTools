#!/bin/bash
sorce config/config.sh

read -p "请输入要查询的用户名： (and press enter): " username 

user_response=`curl -X GET -s \
-H "Accept:application/json" \
-H "Authorization: Bearer $access_token" \
"http://$HOST/$org_name/$app_name/users/$username"`

echo $user_response




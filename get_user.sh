#!/bin/bash

APPKEY="用户自己的appkey"
client_id="用户自己的client_id" 
client_secret="用户自己的client_secret" 

HOST="a1.easemob.com"
org_name=`echo ${APPKEY%#*}`
app_name=`echo ${APPKEY#*#}`

response=`curl -X POST -s \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-d "{ 
   \"grant_type\": \"client_credentials\",  
   \"client_id\": \"$client_id\", 
   \"client_secret\": \"$client_secret\"  
 }" "http://$HOST/$org_name/$app_name/token"`
access_token=`echo $response | sed -n 's/.*access_token\":\"\([^"]*\)\".*/\1/p'`
echo $access_token

read -p "请输入要查询的用户名： (and press enter): " username 

user_response=`curl -X GET -s \
-H "Accept:application/json" \
-H "Authorization: Bearer $access_token" \
"http://$HOST/$org_name/$app_name/users/$username"`

echo $user_response




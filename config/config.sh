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

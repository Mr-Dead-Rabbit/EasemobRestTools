#!/bin/bash

APPKEY=""
client_id="" 
client_secret="" 

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

cursor=ture
until [ -z "$cursor" ]; do
user_response=`curl -X GET -s \
-H "Accept:application/json" \
-H "Authorization: Bearer $access_token" \
"http://$HOST/$org_name/$app_name/users?limit=1&cursor=$cursor"`
cursor=`echo $user_response | sed -n 's/.*cursor\":\"\([^"]*\)\".*/\1/p'`
echo $cursor
entites=`echo $user_response | sed -n 's/.*entities\":\[\([^]]*\)\].*/\1/p' | sed -e 's/\},/\}\n/g'`
echo $entites >> users_output.txt
done

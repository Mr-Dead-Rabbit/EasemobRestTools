#!/bin/bash

if [[ -z $APPKEY ]]  
then 
read -p "请输入APPKEY,(如：easemob-demo#easeim, and press ENTER): " APPKEY
fi

org_name=`echo ${APPKEY%#*}`
app_name=`echo ${APPKEY#*#}`

read -p "请输入域名(如：a1.easemob.com , and press ENTER): " HOST 

if [[ -z $HOST ]]; then
HOST=a1.easemob.com
fi

read -p "请输入client_id： (and press enter): " client_id 
read -p "请输入client_secret： (and press enter): " client_secret 

curl -X POST -s \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-d "{ 
   \"grant_type\": \"client_credentials\",  
   \"client_id\": \"$client_id\", 
   \"client_secret\": \"$client_secret\"  
 }" "http://$HOST/$org_name/$app_name/token"

    
echo $response




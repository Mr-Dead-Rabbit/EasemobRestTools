#!/bin/bash
source config/config.sh

echo $access_token

cursor=ture
until [ -z "$cursor" ]; do
user_response=`curl -X GET -s \
-H "Accept:application/json" \
-H "Authorization: Bearer $access_token" \
"http://$HOST/$org_name/$app_name/users?limit=1&cursor=$cursor"`
cursor=`echo $user_response | sed -n 's/.*cursor\":\"\([^"]*\)\".*/\1/p'`
echo $cursor
entites=`echo $user_response | sed -n 's/.*entities\":\[\([^]]*\)\].*/\1/p' | sed -e 's/\},/\}\n/g'`
echo $entites >> tmp/users_output.txt
done

#!/bin/bash

docker stop dspace
docker rm dspace
docker run -it \
-e HOSTNAME="172.17.0.1" \
-e PORT="80" \
-e SITENAME="<name>" \
-e DBHOST="172.17.0.1" \
-e DBNAME="dspace" \
-e DBUSER="dspace" \
-e DBPASS="<password>" \
-v /dspace_data/assetstore:/opt/dspace/assetstore \
-p 80:8080 \
--name=dspace \
exception/dspace $1


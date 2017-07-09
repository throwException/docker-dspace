#!/bin/bash

/template.sh /opt/dspace/dspace/config/local.cfg

chown -R dspace:dspace /opt/dspace

su -c '/mvn.sh' dspace

su -c '/ant.sh' dspace

cp -r /opt/dspace/webapps/* /opt/tomcat/webapps/
chown -R tomcat:dspace /opt/dspace/upload
chown -R tomcat:dspace /opt/dspace/assetstore

/opt/tomcat/bin/startup.sh

/opt/dspace/bin/dspace index-discovery

cron

tail -F /var/log/syslog.log


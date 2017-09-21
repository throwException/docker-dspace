FROM ubuntu:16.04
MAINTAINER Stefan Thoeni <stefan@savvy.ch>

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y default-jdk curl wget less cron git

RUN groupadd tomcat
RUN useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
RUN cd /tmp && curl -O http://www.pirbot.com/mirrors/apache/tomcat/tomcat-8/v8.5.20/bin/apache-tomcat-8.5.20.tar.gz
RUN mkdir /opt/tomcat && tar xzvf /tmp/apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
RUN cd /opt/tomcat && chgrp -R tomcat /opt/tomcat && chmod -R g+r conf && chmod g+x conf && chown -R tomcat webapps/ work/ temp/ logs/

RUN cd /tmp && wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
RUN mkdir /opt/maven && tar -xvzf /tmp/apache-maven-3.*-bin.tar.gz -C /opt/maven --strip-components=1

RUN cd /tmp && wget http://mirror.switch.ch/mirror/apache/dist//ant/binaries/apache-ant-1.9.9-bin.tar.gz
RUN mkdir /opt/ant && tar -xvzf /tmp/apache-ant-1.9.*-bin.tar.gz -C /opt/ant --strip-components=1

RUN useradd -m dspace
RUN cd /tmp && wget https://github.com/DSpace/DSpace/releases/download/dspace-6.0/dspace-6.0-release.tar.gz
RUN mkdir /opt/dspace && tar -xvzf /tmp/dspace-6.0-release.tar.gz -C /opt/dspace --strip-components=1
COPY Mirage2.tar.gz /opt/dspace/dspace/modules/xmlui-mirage2/src/main/webapp/themes
RUN cd /opt/dspace/dspace/modules/xmlui-mirage2/src/main/webapp/themes && tar -xf Mirage2.tar.gz
RUN cd /opt/dspace && chown -R dspace:dspace . && mkdir /opt/dspace/assetstore

RUN cd /root && mkdir .cache .config .local .npm
RUN chown -R dspace:dspace /root

COPY crontab /etc/cron.d/dspace-cron
RUN chmod 0644 /etc/cron.d/dspace-cron
COPY local.cfg /opt/dspace/dspace/config/local.cfg
COPY xmlui.xconf /opt/dspace/dspace/config/xmlui.xconf
COPY news-xmlui.xml /opt/dspace/dspace/config/news-xmlui.xml
COPY item-submission.xml /opt/dspace/dspace/config/item-submission.xml
COPY input-forms.xml /opt/dspace/dspace/config/input-forms.xml
COPY template.sh /template.sh
COPY mvn.sh /mvn.sh
RUN chmod a+x /mvn.sh
COPY ant.sh /ant.sh
RUN chmod a+x /ant.sh
COPY entrypoint.sh /entrypoint.sh

EXPOSE 8080
CMD ["/entrypoint.sh"]


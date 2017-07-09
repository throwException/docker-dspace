#!/bin/bash

export M2_HOME=/opt/maven
export PATH=${M2_HOME}/bin:${PATH}

cd /opt/dspace

mvn package -Dmirage2.on=true


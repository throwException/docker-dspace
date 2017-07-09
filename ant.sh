#!/bin/bash

export ANT_HOME=/opt/ant
export PATH=${ANT_HOME}/bin:${PATH}

cd /opt/dspace/dspace/target/dspace-installer

ant fresh_install


#!/bin/bash

su -c 'createuser --username=postgres --no-superuser --pwprompt dspace' postgres
su -c 'createdb --username=postgres --owner=dspace --encoding=UNICODE dspace' postgres
su -c 'psql --username=postgres dspace -c "CREATE EXTENSION pgcrypto;"' postgres

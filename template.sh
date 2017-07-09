#!/bin/bash

while IFS='=' read -r key val; do
  if grep -q "%%%${key}%%%" $1; then
    sed -i "s#%%%${key}%%%#${val}#g" $1
  fi
done < <(env)

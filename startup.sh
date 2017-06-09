#!/bin/bash

# Install app dependencies
npm install

# wait for database container to startup
while ! nc -w 1 -z db 2424; do echo "waiting for port"; sleep 1; done

npm start
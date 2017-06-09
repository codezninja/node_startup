node_startup
============================
[![CircleCI](https://circleci.com/gh/bondezbond/node_startup.svg?style=svg)](https://circleci.com/gh/bondezbond/node_startup)

Simple containerzed Node container with netcat installed. Used on Node apps that need to wait for something to come up before starting


i.e. in your app repo that you mount to the container you can have bash script that does the following...

```
#!/bin/bash

# Install app dependencies
npm install

# wait for database container to startup
while ! nc -w 1 -z db $DB_PORT; do echo "waiting for port"; sleep 1; done

npm start
```
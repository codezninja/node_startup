FROM node:4.8.3

RUN apt-get update
RUN apt-get -y install netcat

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN npm install npm@3.10.8 -g

ADD startup.sh .

EXPOSE 9000
CMD [ "./startup.sh" ]
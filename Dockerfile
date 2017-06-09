FROM node:4.3.2

RUN apt-get update
RUN apt-get -y install netcat

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD startup.sh .

EXPOSE 9000
CMD [ "./startup.sh" ]
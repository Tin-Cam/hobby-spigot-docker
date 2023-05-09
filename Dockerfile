FROM alpine

# Install required packages
RUN apk add --no-cache openjdk17
RUN apk add --no-cache git

#RUN git config --global --unset core.autocrlf

# Create and switch to minecraft user
RUN adduser -D minecraft
USER minecraft
WORKDIR /home/minecraft/server

# Install server as minecraft user
RUN wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -jar BuildTools.jar
RUN java -jar spigot-1.19.4.jar

EXPOSE 25565

CMD [/bin/bash]
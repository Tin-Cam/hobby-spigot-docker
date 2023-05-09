FROM alpine

# TODO - Arguments

# Environment variables
ENV DIR_WORLDS /worlds
ENV DIR_SERVER /opt/spigot

# Install required packages
RUN apk add --no-cache openjdk17
RUN apk add --no-cache git
RUN apk add --no-cache --upgrade bash

# Copy image scripts
COPY server-startup /usr/local/bin

#RUN git config --global --unset core.autocrlf

# Create and switch to minecraft user
RUN adduser -D minecraft
USER minecraft
WORKDIR ${DIR_SERVER}

# Download server build tools as minecraft user
RUN wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

# Expose minecraft port
EXPOSE 25565

CMD ["/usr/local/bin/server-startup"]
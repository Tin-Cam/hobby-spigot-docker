FROM alpine

# Arguments
ARG spigot_version=1.19.4

# Environment variables
ENV DIR_SERVER /opt/spigot
ENV DIR_WORLDS /worlds
ENV DIR_PLUGINS /plugins
ENV SPIGOT_APP spigot-$spigot_version.jar
ENV EULA false

# Volumes
VOLUME $DIR_SERVER
VOLUME $DIR_WORLDS
VOLUME $DIR_PLUGINS

VOLUME [ “/sys/fs/cgroup” ]

RUN mkdir -p $DIR_SERVER
RUN mkdir -p $DIR_WORLDS
RUN mkdir -p $DIR_PLUGINS

# Install required packages
RUN apk add --no-cache openjdk17
RUN apk add --no-cache git
RUN apk add --no-cache screen
RUN apk add --no-cache --upgrade bash
RUN apk add --no-cache openrc

# Copy image scripts
COPY server-init /usr/local/bin
COPY server-start /usr/local/bin
COPY server-eula /usr/local/bin
RUN chmod 755 /usr/local/bin

COPY spigotd /etc/init.d/
RUN chmod +x /etc/init.d/spigotd


#RUN git config --global --unset core.autocrlf

# Create and switch to minecraft user
RUN adduser -D minecraft
RUN chown minecraft:minecraft $DIR_SERVER
RUN chown minecraft:minecraft $DIR_WORLDS
RUN chown minecraft:minecraft $DIR_PLUGINS
USER minecraft
WORKDIR ${DIR_SERVER}

# Expose minecraft port
EXPOSE 25565

CMD ["/usr/local/bin/server-init"]
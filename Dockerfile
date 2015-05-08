FROM alpine:3.1

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN apk update
RUN apk add rsyslog curl "postgresql@edge>9.4"
RUN apk add bash vim
RUN mkdir -p /run/openrc && echo "" > /run/openrc/softlevel
RUN apk add openssh
RUN curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64"
RUN chmod +x /usr/local/bin/gosu

ENV LANG en_US.utf8
ENV PGDATA /var/lib/postgresql/data
VOLUME /var/lib/postgresql/data

COPY docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]    

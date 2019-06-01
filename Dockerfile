FROM ubuntu:disco
MAINTAINER Ross Golder <ross@golder.org>

# Set terminal to be noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Indicate that we want to use the master config, not the slave
ENV LDAP_IS_MASTER=True

RUN sed -i 's/deb-src/# deb-src/' /etc/apt/sources.list
RUN apt-get update && \
    apt-get upgrade -y -f && \
    apt-get install --no-install-recommends -y slapd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mv /etc/ldap/slapd.d /etc/ldap/slapd.dist

EXPOSE 389

VOLUME ["/etc/ldap", "/var/lib/ldap"]

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["slapd", "-d", "0", "-h", "ldap:///", "-u", "openldap", "-g", "openldap"]

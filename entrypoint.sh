#!/bin/bash

# When not limiting the open file descritors limit, the memory consumption of
# slapd is absurdly high. See https://github.com/docker/docker/issues/8231
ulimit -n 1024

set -e

chown -R openldap:openldap /etc/ldap /var/lib/ldap/ /var/run/slapd/

exec "$@"

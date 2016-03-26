# Dockerfile for LDAP

To build:

	docker build -t openldap .

To run:

	docker run --restart=always -d -p 636:636 -v /etc/ldap:/etc/ldap -v /var/lib/ldap:/var/lib/ldap --name openldap openldap


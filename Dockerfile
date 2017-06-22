FROM resin/raspberrypi3-debian:latest

# Packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update -q --fix-missing && \
  apt-get -y upgrade && \
  apt-get -y install --no-install-recommends \
  rsyslog \
  postfix postfix-pcre postfix-ldap \
  cron getmail4 \
  mutt swaks \
  dovecot-core dovecot-imapd dovecot-pop3d dovecot-lmtpd dovecot-ldap \
  libsasl2-2 sasl2-bin libsasl2-modules-ldap

RUN addgroup --system --gid 5000 vmail && \
    adduser --system --home /srv/vmail --uid 5000 --gid 5000 --disabled-password --disabled-login vmail

RUN adduser postfix sasl

COPY config /tmp/config

COPY getmail /etc/getmail

COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh

CMD ["/usr/local/bin/startup.sh"]

FROM gitlab/gitlab-ce:latest
MAINTAINER Ilija Boshkov

# For add-apt-repository
RUN apt-get update
RUN apt-get install -y software-properties-common python
RUN apt-get update

# Add letsencrypt certbot repo and install
RUN add-apt-repository ppa:certbot/certbot
RUN apt-get update
RUN apt-get install -y certbot

RUN mkdir /var/www/letsencrypt/

# Renew letsencrypt certificates
RUN (crontab -l ; echo "15 3 * * * /usr/bin/certbot renew --quiet --renew-hook \"/usr/bin/gitlab-ctl restart nginx\"")| crontab -

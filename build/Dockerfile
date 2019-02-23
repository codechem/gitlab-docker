FROM gitlab/gitlab-ce:latest
MAINTAINER Ilija Boshkov

# For add-apt-repository
RUN apt-get update
RUN apt-get install -y software-properties-common python dirmngr
RUN apt-get update

# Add letsencrypt certbot repo and install
# export part fixes "dirmngr" issue with gitlab's PATH setting
RUN export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin && add-apt-repository ppa:certbot/certbot
RUN apt-get update
RUN apt-get install -y certbot

# Renew letsencrypt certificates
RUN (crontab -l ; echo "15 3 * * * /usr/bin/certbot renew --quiet --renew-hook \"/usr/bin/gitlab-ctl restart nginx\"")| crontab -

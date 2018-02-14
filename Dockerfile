FROM phusion/passenger-ruby24:0.9.28

CMD ["/sbin/my_init"]

RUN rm /etc/nginx/sites-enabled/default

COPY config/app.vhost.conf /etc/nginx/sites-enabled/

RUN rm -f /etc/service/nginx/down

USER app

WORKDIR /home/app/webapp/

COPY Gemfile Gemfile.lock ./

USER root

RUN bundle --without development test

USER app

COPY * ./

USER root

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

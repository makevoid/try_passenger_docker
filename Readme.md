# try_passenger_docker

Example setup of a docker container running passenger mounting a roda/rack app

#### Versions:

- Ruby 2.4
- Passenger 0.9.28

#### Virtualhost

See [app.vhost.conf](https://github.com/makevoid/try_passenger_docker/blob/master/config/app.vhost.conf):

```
server {
    listen 80;
    server_name _;
    root /home/app/webapp/public;

    passenger_enabled on;
    passenger_user app;

    passenger_ruby /usr/bin/ruby2.4;
}
```

---

#### Dockerfile

See [Dockerfile](https://github.com/makevoid/try_passenger_docker/blob/master/Dockerfile):

```docker
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
```

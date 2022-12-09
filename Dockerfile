FROM nginx

ADD default.conf /etc/nginx/conf.d/

COPY build/web/ /usr/share/nginx/html/

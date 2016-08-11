FROM library/ubuntu:14.04

COPY ./etc/sources.list /etc/apt/sources.list

RUN apt-get clean

RUN apt-get upgrade

RUN apt-get update

RUN apt-get install -f -y libreadline-dev make gcc libncurses5-dev libpcre3 libpcre3-dev openssl libssl-dev libz-dev

COPY ./lua /opt/lua

COPY ./luajit /opt/luajit

COPY ./lua-nginx-module /opt/lua-nginx-module

COPY ./ngx_devel_kit /opt/ngx_devel_kit

COPY ./nginx /opt/nginx

WORKDIR /opt/lua

RUN make linux

RUN make install

WORKDIR /opt/luajit

RUN make

RUN make install

RUN ln -s /usr/local/lib/libluajit-5.1.so.2 /lib64/libluajit-5.1.so.2

RUN ln -s /usr/local/lib/libluajit-5.1.so.2 /lib/libluajit-5.1.so.2

ENV LUAJIT_LIB=/usr/local/lib

ENV LUAJIT_INC=/usr/local/include/luajit-2.0

WORKDIR /opt/nginx

RUN ./configure --prefix=/usr/local --add-module=/opt/ngx_devel_kit --add-module=/opt/lua-nginx-module

RUN make -j2

RUN make install

WORKDIR /opt

RUN rm -rf lua
RUN rm -rf luajit
RUN rm -rf lua-nginx-module
RUN rm -rf ngx_devel_kit
RUN rm -rf nginx

WORKDIR /usr/local

COPY ./conf.d conf.d

COPY ./lib/lua lib/lua

COPY ./conf/nginx.conf conf/nginx.conf

EXPOSE 80

VOLUME ["/usr/local/logs"]  

COPY ./@app @app

CMD nginx -g "daemon off;"

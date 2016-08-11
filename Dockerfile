FROM kk/nginx

COPY ./kk lualib/kk

COPY ./kk.lua lualib/kk.lua

COPY ./conf.d/default.conf conf.d/default.conf

COPY ./@app @app



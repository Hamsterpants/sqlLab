# https://github.com/kea-dev/lamj/blob/main/README.md
FROM mysql:latest

EXPOSE 3306

ENV MYSQL_ROOT_PASSWORD=123

COPY src/mysql/init/* /docker-entrypoint-initdb.d

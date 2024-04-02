# https://github.com/kea-dev/lamj/blob/main/README.md
FROM mysql:latest

EXPOSE 3306

COPY src/mysql/init/* /docker-entrypoint-initdb.d

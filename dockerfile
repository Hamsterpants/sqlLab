FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install MySQL and other dependencies
RUN apt-get update && apt-get install -y mysql-server

ENV MYSQL_ROOT_PASSWORD=123

EXPOSE 3306

COPY src/mysql/init/* /docker-entrypoint-initdb.d

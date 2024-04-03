# Stage 1: Build and configure Apache HTTP Server
FROM httpd:2.4 AS apache

# Update the package repository and install necessary dependencies
RUN apt-get update && apt-get install -y \
    openssl
    # Add any other required dependencies

# Generate a self-signed SSL/TLS certificate (for demonstration purposes)
RUN openssl req -newkey rsa:2048 -nodes -keyout /usr/local/apache2/conf/server.key -x509 -days 365 -out /usr/local/apache2/conf/server.crt -subj "/C=US/ST=Example/L=Example/O=Example/CN=example.com"

# Copy the Apache configuration files
COPY apache-conf/httpd.conf /usr/local/apache2/conf/httpd.conf
COPY apache-conf/ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf

# Stage 2: Build the final image with MySQL and Apache
FROM mysql:latest

EXPOSE 3306 8080 443 

COPY src/mysql/init/* /docker-entrypoint-initdb.d

# Copy the Apache configuration and certificates from the previous stage
COPY --from=apache /usr/local/apache2/conf/httpd.conf /usr/local/apache2/conf/httpd.conf
COPY --from=apache /usr/local/apache2/conf/extra/httpd-ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf
COPY --from=apache /usr/local/apache2/conf/server.key /usr/local/apache2/conf/server.key
COPY --from=apache /usr/local/apache2/conf/server.crt /usr/local/apache2/conf/server.crt

# Start Apache HTTP Server and MySQL
CMD ["sh", "-c", "httpd-foreground & docker-entrypoint.sh mysqld"]

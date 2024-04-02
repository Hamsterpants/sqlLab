# sqlLab

Build Docker Image
```bash
docker build -t sqllab .
```

Run image
```bash
docker run -it --rm --name sqllab -p 8080:80 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123 sqllab
```

Start Bash shell inside container 
```bash
docker exec -it sqllab bash
```

Connect to MySQL server running in the container
```bash
mysql -u root -p
```

List running docker
```bash
docker ps
```

Stop container
```bash
docker stop container_name_or_id
```


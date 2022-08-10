# Welcome to inception 🐋

This project is about using Docker and Docker compose to create a small multi-containers application with a wordpress website, running with php-fmp, nginx and mariadb.

# Table of Contents
1. [Docker](#docker)
   - [Docker network](#docker-network)
2. [Docker compose](#docker-compose)
3. [Security](#security)
4. [Tips and advices](#tips-and-advices)
3. [Bonuses](#Bonuses)
   - [Redis cache](#redis-cache)
   - [FTP Server](#ftp-server)
   - [Static website using HUGO](#static-website-using-hugo)
   - [Adminer](#adminer)
   - [XXX service](#xxx-service)
4. [Installation](#installation)

# Inception

We need to build the following architecture with a certain set of constraints :

![project architecture](img/architecture.png)

## Docker

Docker is a set of platform as a service (PaaS) products that use OS-level virtualization to deliver software in packages called containers. The software that hosts the containers is called Docker Engine.

### Docker network

Docker documentation says :
>In terms of Docker, a **bridge network** uses a software bridge which allows containers connected to the same bridge network to communicate, while providing isolation from containers which are not connected to that bridge network. The Docker bridge driver automatically installs rules in the host machine so that containers on different bridge networks cannot communicate directly with each other.
>
>Bridge networks apply to containers running **on the same Docker daemon host**.

For this project, as it will run on a single Docker host and as I need different containers to communicate, I chose to use a **user-defined bridge network**.

Unlike default bridge network, which is automatically created by Docker when you start new containers, user-defined bridge networks comes with some benefits :
* Automatic DNS resolution between containers : you can directly reference a container to another using their names instead of --link flag
* Better isolation : the containers are not attached to a default network where they can communicate with other unrelated containers
* Containers on the same network share environment variables

## Docker compose

Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

## Security

### USER instruction in Dockerfile

```Dockerfile
USER    	www-data

ENTRYPOINT 	["docker-entrypoint.sh"]
```

The **USER** instruction allows you to execute the remaining commands of the dockerfile with a certain user.

I used it especially to **run the instructions at runtime with a non root user**, at the end of the Dockerfile. This is nice on multiple level :
* If you have folders that are binded between the host machine and a container, **every file a root user will create in it will be difficult to manage on the host if you are not root**.
* As a root, you can do a lot of things without restrictions on your container. This is convenient, but a **malicious user can use your container to get a root access on the host**.
* Finaly, using a non root user in your Dockerfile will **force you to understand and to manage properly the files and locations your application needs to access**. It is better if you are in a learning process.

### PORTS : binding host with containers in Docker-compose

```yml
 ftp:
    image: ftp:${TAG}
    build: ./bonus/ftp
    container_name: ftp
    restart: always
    ports: ['2222:2222']
    volumes: ['wordpress_data:/var/www/wordpress']
    networks: ['inception_network']
```

Docker-compose allows you to **bind a port of your host machine with a port of a container**.

It may seem like a good idea to bind the ports of your containers with the ports of your host, to have **easy access to them from the host**, for testing or monitoring the services.

**BUT** in the context of a **multi-containers application**, we have to think carefully about what should be the entrypoint(s) of the application, and only expose these. In our case, we only want to **bind port 443 of the host with the port 443 of Nginx container**.

### Networks

Containers on the same network can communicate.

If you need to secure a little bit more your multi-containers application, you can create **dedicated networks between certain containers instead of one big network for all containers**.

For example, in this project, I need my Nginx container to communicate with the wordpress/php-fpm container, but not with mariadb directly.

I could create multiple networks to allow communication between my containers :

```txt
network 1 : nginx / wordpress
network 2 : wordpress / mariadb
```

In the docker-compose.yml file, nginx will only be on `network 1`, mariadb on `network 2` and wordpress on `network 1` and `network 2`.

## Bonuses

### Redis cache

Very good article from [@Catherine Macharia](https://www.section.io/engineering-education/authors/catherine-macharia/) explaining Wordpress and Redis cache : [How to Set Up and Configure Redis Caching for WordPress](https://www.section.io/engineering-education/how-to-set-up-and-configure-redis-caching-for-wordpress/)

Some interesting quotes from this article :

#### What is redis

>Redis is an open-source in-memory data structure store that can be used as a caching system. It is a memory caching software that runs as a service in the background. This allows you to cache and store data in memory for high-performance data retrieval and storage. 

#### How Redis cache works

>Assume you have a web application running on a server using a database like MySQL. That web application needs to retrieve some records from this database. Such queries take some time to return the requested records. And, if the query is expensive, a user waiting for that data for more than one minute may have a bad experience.
>
>However, Redis is made to make such processing faster and efficient. With it, it’s possible to store data processed by a MySQL database query inside of a Redis cache instance. This allows data to be retrieved directly from the server’s memory. This way, the application will not go all the way back to the database.
>
>Instead, the web server can check with Redis if it has the data it wants. So when another call is made and requires the same query transaction, instead of hitting the MySQL server again, the Redis object will serve the request from the object cache.

### FTP server

### Static website (using HUGO)

### Adminer

### xxx server

## Installation

Be sure that you have Docker and Docker compose installed on you machine. Follow instructions on Docker website to [install Docker Engine](https://docs.docker.com/engine/install/). 

Clone the repository:
```sh
$> git clone git@github.com:twagger/inception.git
```
Make to build the complete application (build images and run them) :
```sh
$> make
```
Make clean to stop the containers and remove all (images, networks, volumes) :
```sh
$> make clean
```
Make fclean to clean everything, including the data on host machine (make re includes a fclean) :
```sh
$> make fclean
```

To access the website, launch a browser and enter (you will have to bypass the security warning as the certificate is self-signed) :
```
https://twagner.42.fr
```

## Author

👨 **Thomas WAGNER**

* Github: [@twagger](https://github.com/twagger/)

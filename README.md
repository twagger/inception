# Welcome to inception 🐋

This project is about using Docker and Docker compose to create a small infrastructure for a Wordpress website, with php-fmp and nginx.

# Table of Contents
1. [Docker](#docker)
2. [Docker compose](#docker-compose)
3. [Bonuses](#Bonuses)
        - [Redis cache](#redis-cache)
        - [SFTP Server](#sftp-server)
        - [Static website](#static-website)
        - [Adminer](#adminer)
        - [XXX service](#xxx-service)
4. [Installation](#installation)

# Inception

## Docker

Docker is a set of platform as a service (PaaS) products that use OS-level virtualization to deliver software in packages called containers. The software that hosts the containers is called Docker Engine.

## Docker compose

Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

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

### SFTP server

### Static website

### Adminer

### XXX service

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

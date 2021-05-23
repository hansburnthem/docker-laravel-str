
# About Docker-Laravel-Str

Docker-Laravel-Str is a repo for building image and container for full Laravel development on docker. Specially Laravel with PHP, Composer and NodeJS.

You can build your image and container yourself using this repo or use mine on [Docker Hub :D](https://hub.docker.com/r/hnifrma/docker-laravel-str)

List of component (source are from [Docker Hub Repository](https://hub.docker.com/)):
- PHP [php:7.4-fpm](https://hub.docker.com/_/php?tab=tags&page=1&ordering=-name&name=7.4-fpm).
- NodeJS [node:lts](https://hub.docker.com/_/node?tab=tags&page=1&ordering=-name&name=lts). with NPM and NPX
- Composer [composer:latest](https://hub.docker.com/_/composer?tab=tags&page=1&ordering=last_updated&name=latest) as PHP Package Manager
- NGINX [nginx:alpine](https://hub.docker.com/_/nginx?tab=tags&page=1&ordering=-name&name=alpine) as Webserver
- Linux standard package (git curl libpng-dev libonig-dev libxml2-dev zip unzip nano htop zsh wget)
- ZSH and Oh-my-zsh $SHELL

## Build

First, make sure you already have Docker machine & Compose on Linux or Docker Dekstop on Win10 & MacOS.

Clone the repository into your local drive, and change directory to your folder.
Open your favorite shell, and run this command.

- edit the **docker-compose.yml** file, **app** section
`nano ./docker-compose.yml`
Change the **user:** with your aliases. 
Change **image:** and **container_name:** (Optional)
```yaml
app:
    build: 
        args: 
            user: hansburnthem
            uid: 1000
        context: ./
        dockerfile: Dockerfile
    image: docker-laravel-str:8.42.1
    container_name: laravel8-app
    restart: unless-stopped
    working_dir: /var/www/
    volumes: 
        - ./:/var/www
    networks: 
        - default
```
- edit the **docker-compose.yml** file, **nginx** section
Change **container_name:** (Optional)
```yaml
nginx:
    image: nginx:alpine
    container_name: laravel8-nginx
    restart: unless-stopped
    ports: 
        - 8000:80
    volumes: 
        - ./:/var/www
        - ./config/nginx:/etc/nginx/conf.d/
    networks: 
        - default
```
- edit the **docker-compose.yml** file, **name** section
Change **name:** to your database docker network. 
For example, you had **MySQL Server** on docker container with **Database** as network bridge, then you should write **name: Database**.
in case you didn't have network bridge:
`docker network create YOUR_NETWORK_NAME`
connect to your db and network config.
`docker network connect NETWORK_ID CONTAINER_ID`
```yaml
networks: 
    default:
        external: true
        name: Database
```

- **Optional** if you want add another package or image add from **Dockerfile**

- `docker-compose build app` -> this will build your docker image.

- `docker-compose up -d` ->  this will create container for your image.

**Voila you're done**

**ZSH to container** `docker exec -it CONTAINER_ID zsh`

## Author

Check my [blog-site](https://hnifrma.maleskuliah.org) :D

## Contributing

You can contribute if you want by clone this repo and push to pr tq.

## License

The Docker-Laravel-Str is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).

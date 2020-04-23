# Docker image for Yii/Laravel + Node production

```
docker pull acirulis/php74-nginx-prod:latest
```

List of included software:

*Based on Debian Buster (10 LTS)*


- Nginx
- PHP 7.4 (with production php.ini) with extensions for PostgreSQL and MySQL, Yii, Laravel, etc.
- Composer
- NVM (Node version manager) 
- Node 12 (default) ```nvm use 12```
- Build tools for different npm packages (nasm pkg-config libpng-dev automake libtool autoconf)



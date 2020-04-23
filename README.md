# Docker image for Yii/Laravel + Node development

```
docker pull acirulis/php74-nginx:latest
```

List of included software:

*Based on Debian Buster (10 LTS)*


- Nginx
- PHP 7.4 (with development php.ini) with extensions for PostgreSQL and MySQL, Yii, Laravel, etc.
- XDebug
- Composer
- NVM (Node version manager) 
- Node 10 + 12 (default) ```nvm use 10; nvm use 12```
- Build tools for different npm packages (nasm pkg-config libpng-dev automake libtool autoconf)
- Yarn


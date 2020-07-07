#!/bin/bash
service cron start
service php7.4-fpm start
nginx -g "daemon off;"

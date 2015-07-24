#!/bin/bash

echo starting now
# initialize runtime data
if [ ! -e "/var/lib/weblate/data" ]
then
    mkdir /var/lib/weblate/data
fi

# user config
if [ ! -e "/var/lib/weblate/settings_user.py" ]
then
    cp /usr/lib/weblate/weblate/settings_user_default.py /var/lib/weblate/settings_user.py
fi
ln -s /var/lib/weblate/settings_user.py /usr/lib/weblate/weblate/settings_user.py

# secret key
if [ ! -e "/var/lib/weblate/secret_key.py" ]
then
    /usr/lib/weblate/examples/generate-secret-key | \
        sed -e 's/^/SECRET_KEY = "/' -e 's/$/"/' > \
        /var/lib/weblate/secret_key.py
fi
ln -s /var/lib/weblate/secret_key.py /usr/lib/weblate/weblate/secret_key.py

# configure database
if \
    [ -n "$DB_PORT_3306_TCP_ADDR" ] && \
    [ -n "$DB_PORT_3306_TCP_PORT" ] && \
    [ -n "$DB_ENV_MYSQL_DATABASE" ] && \
    [ -n "$DB_ENV_MYSQL_USER" ] && \
    [ -n "$DB_ENV_MYSQL_PASSWORD" ]
then
    sed -i \
        -e "/^DATABASES/,/^}/s#'ENGINE'.*#'ENGINE': 'django.db.backends.mysql',#" \
        -e "/^DATABASES/,/^}/s#'NAME'.*#'NAME': '$DB_ENV_MYSQL_DATABASE',#" \
        -e "/^DATABASES/,/^}/s#'USER'.*#'USER': '$DB_ENV_MYSQL_USER',#" \
        -e "/^DATABASES/,/^}/s#'PASSWORD'.*#'PASSWORD': '$DB_ENV_MYSQL_PASSWORD',#" \
        -e "/^DATABASES/,/^}/s#'HOST'.*#'HOST': '$DB_PORT_3306_TCP_ADDR',#" \
        -e "/^DATABASES/,/^}/s#'PORT'.*#'PORT': '$DB_PORT_3306_TCP_PORT',#" \
        /usr/lib/weblate/weblate/settings.py
else
    sed -i \
        -e "/^DATABASES/,/^}/s#'ENGINE'.*#'ENGINE': 'django.db.backends.sqlite3',#" \
        -e "/^DATABASES/,/^}/s#'NAME'.*#'NAME': '/var/lib/weblate/weblate.db',#" \
        -e "/^DATABASES/,/^}/s#'USER'.*#'USER': '',#" \
        -e "/^DATABASES/,/^}/s#'PASSWORD'.*#'PASSWORD': '',#" \
        -e "/^DATABASES/,/^}/s#'HOST'.*#'HOST': '',#" \
        -e "/^DATABASES/,/^}/s#'PORT'.*#'PORT': '',#" \
        /usr/lib/weblate/weblate/settings.py
fi

# configure memcached
if [ -n "$MEMCACHED_PORT_11211_TCP_ADDR" ] && [ -n "$MEMCACHED_PORT_11211_TCP_PORT" ]
then
    sed -i \
        -e "/^CACHES/,/^}/s#'BACKEND'.*#'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',#" \
        -e "/^CACHES/,/^}/s#'LOCATION'.*#'LOCATION': '$MEMCACHED_PORT_11211_TCP_ADDR:$MEMCACHED_PORT_11211_TCP_PORT',#" \
        /usr/lib/weblate/weblate/settings.py
else
    sed -i \
        -e "/^CACHES/,/^}/s#'BACKEND'.*#'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',#" \
        -e "/^CACHES/,/^}/s#'LOCATION'.*#'LOCATION': '',#" \
        /usr/lib/weblate/weblate/settings.py
fi

exec "$@"

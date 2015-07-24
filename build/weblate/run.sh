#!/bin/sh

alias weblate='python /usr/lib/weblate/manage.py'
cd /usr/lib/weblate
echo no | weblate syncdb || exit $?
weblate migrate || exit $?
weblate createadmin --password=admin 2>/dev/null
weblate runserver 0.0.0.0:8000


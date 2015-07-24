 
USER_SETTINGS = {
    'DEBUG': True,

    # Local time zone for this installation. Choices can be found here:
    # http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
    # although not all choices may be available on all operating systems.
    # On Unix systems, a value of None will cause Django to use the same
    # timezone as the operating system.
    # If running in a Windows environment this must be set to the same as your
    # system time zone.
    'TIME_ZONE': 'UTC',

    # Language code for this installation. All choices can be found here:
    # http://www.i18nguy.com/unicode/language-identifiers.html
    'LANGUAGE_CODE': 'en-us',

    # URL prefix to use, please see documentation for more details
    'URL_PREFIX': '',

    # Title of site to use
    'SITE_TITLE': 'Weblate',

    # E-mail address that error messages come from.
    'SERVER_EMAIL': 'noreply@weblate.org',

    # Default email address to use for various automated correspondence from
    # the site managers. Used for registration emails.
    'DEFAULT_FROM_EMAIL': 'noreply@weblate.org',

    # List of URLs your site is supposed to serve, required since Django 1.5
    'ALLOWED_HOSTS': [],

    # Toggle user registeration
    'REGISTRATION_OPEN': True,

    'EMAIL_HOST' : '',
    'EMAIL_HOST_USER' : '',
    'EMAIL_HOST_PASSWORD' :'',
    'EMAIL_PORT' : ''
}


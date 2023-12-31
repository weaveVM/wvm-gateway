#!/usr/bin/env sh

# This is a copy of docker-entrypoint.sh from the official Envoy Docker image
# with code added to apply templating to the Envoy config file.

set -e

loglevel="${LOG_LEVEL:-}"
USERID=$(id -u)

# Update env vars
ytt --data-values-env TVAL -f /etc/envoy/envoy.template.yaml >  /etc/envoy/envoy.yaml
chmod go+r /etc/envoy/envoy.yaml

# if the first argument look like a parameter (i.e. start with '-'), run Envoy
if [ "${1#-}" != "$1" ]; then
    set -- envoy "$@"
fi

if [ "$1" = 'envoy' ]; then
    # set the log level if the $loglevel variable is set
    if [ -n "$loglevel" ]; then
        set -- "$@" --log-level "$loglevel"
    fi
fi

if [ "$ENVOY_UID" != "0" ] && [ "$USERID" = 0 ]; then
    if [ -n "$ENVOY_UID" ]; then
        usermod -u "$ENVOY_UID" envoy
    fi
    if [ -n "$ENVOY_GID" ]; then
        groupmod -g "$ENVOY_GID" envoy
    fi
    # Ensure the envoy user is able to write to container logs
    chown envoy:envoy /dev/stdout /dev/stderr
    exec su-exec envoy "${@}"
else
    exec "${@}"
fi

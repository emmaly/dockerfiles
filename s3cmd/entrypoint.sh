#!/bin/bash

if [ -z "$AWS_ACCESS_KEY" ]; then
    echo "AWS_ACCESS_KEY is not set"
    exit 1
fi

if [ -z "$AWS_SECRET_KEY" ]; then
    echo "AWS_SECRET_KEY is not set"
    exit 1
fi

sed -e "s|\$AWS_ACCESS_KEY|$AWS_ACCESS_KEY|g" \
    -e "s|\$AWS_SECRET_KEY|$AWS_SECRET_KEY|g" \
    /s3cmd.conf.template > /home/user/.s3cfg

exec "$@"

FROM debian:latest

LABEL maintainer="Emmaly <emmaly@emma.ly>"

RUN apt-get update \
    && apt-get install -y \
        ca-certificates \
        s3cmd \
        --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r user \
    && useradd --no-log-init -r -g user user \
    && mkdir -p /home/user \
    && chown -R user:user /home/user \
    && mkdir -p /workdir \
    && chown -R user:user /workdir

COPY s3cmd.conf.template /s3cmd.conf.template
COPY entrypoint.sh /entrypoint.sh

USER user
WORKDIR /workdir

ENTRYPOINT ["/entrypoint.sh", "/usr/bin/s3cmd"]
CMD ["--help"]

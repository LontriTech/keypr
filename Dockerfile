FROM python:3.9.13-alpine3.16 AS base

LABEL org.opencontainers.image.title="Keypr" \
      org.opencontainers.image.description="Configuration Keeper for GitHub Repositories." \
      org.opencontainers.image.url="https://github.com/fr-platform/keypr/blob/main/README.md" \
      org.opencontainers.image.documentation="https://github.com/fr-platform/keypr/wiki" \
      org.opencontainers.image.source="https://github.com/fr-platform/keypr" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="Fr Platform" \
      org.opencontainers.image.base.name="registry.hub.docker.com/python/python:3.9.13-alpine3.16"

WORKDIR /app

ENV PYTHONPATH /app

ENV GH_CONFIG_DIR /app/gh_config

RUN addgroup -S python \
    && adduser -S python -G python \
    && apk update \
    && apk add --no-cache --virtual .build-deps curl \
    && apk add --no-cache git github-cli \
    && apk del --purge .build-deps \
    && mkdir --mode=777 /app/gh_config \
    && chown --recursive python:python /app/gh_config

COPY --chown=python:python requirements.txt ./

RUN pip install --no-cache-dir --no-color --no-python-version-warning --disable-pip-version-check --requirement requirements.txt \
    && rm -f requirement.txt

FROM base AS deploy

COPY --chown=python:python src keypr

USER python

CMD [ "python", "-m" , "keypr"]

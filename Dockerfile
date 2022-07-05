FROM python:3.9-slim-buster

LABEL org.opencontainers.image.title="LRO Repo Scaffolder" \
      org.opencontainers.image.description="Repository Scaffolder for GitHub." \
      org.opencontainers.image.url="https://github.com/OLeonardoRodrigues/lro-repo-scaffolder/blob/main/README.md" \
      org.opencontainers.image.documentation="https://github.com/OLeonardoRodrigues/lro-repo-scaffolder/wiki" \
      org.opencontainers.image.source="https://github.com/OLeonardoRodrigues/lro-repo-scaffolder" \
      org.opencontainers.image.licenses="GPL-3.0-only" \
      org.opencontainers.image.vendor="Leonardo Rodrigues de Oliveira - OLeonardoRodrigues" \
      org.opencontainers.image.base.name="registry.hub.docker.com/python/python:3.9-slim-buster" \
      org.opencontainers.image.base.digest="sha256:a32a3204b2b44f3e7e699e5b4af1a5784b6a9b8a4f4446dbb8a3aa65375a8d7d"
      
WORKDIR /app

ENV PYTHONPATH /app

RUN useradd -m python

RUN mkdir ~/.config \
    && chown -R `whoami` ~ \
    && chmod -R 777 ~ \
    && ls -la ~

COPY --chown=python:python requirements.txt ./

RUN pip3 install -r requirements.txt

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install curl -y \
    && apt-get install git -y \
    && curl -L https://github.com/cli/cli/releases/download/v2.7.0/gh_2.7.0_linux_amd64.deb \
    > gh_2.7.0_linux_amd64.deb \
    && dpkg -i ./gh_2.7.0_linux_amd64.deb

COPY --chown=python:python src lro_repo_scaffolder

USER python

CMD [ "python3.9", "-m" , "lro_repo_scaffolder"]

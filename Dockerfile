FROM python:3.9-slim-buster

LABEL org.opencontainers.image.title="LRO Repo Scaffolder" \
      org.opencontainers.image.description="Repository Scaffolder for GitHub." \
      org.opencontainers.image.url="https://github.com/OLeonardoRodrigues/lro-repo-scaffolder/blob/main/README.md" \
      org.opencontainers.image.documentation="https://github.com/OLeonardoRodrigues/lro-repo-scaffolder/wiki" \
      org.opencontainers.image.source="https://github.com/OLeonardoRodrigues/lro-repo-scaffolder"

WORKDIR /app

RUN useradd -m python

COPY --chown=python:python requirements.txt ./

RUN pip3 install -r requirements.txt

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install curl -y \
    && apt-get install git -y \
    && curl -L https://github.com/cli/cli/releases/download/v2.7.0/gh_2.7.0_linux_amd64.deb \
    > gh_2.7.0_linux_amd64.deb \
    && dpkg -i ./gh_2.7.0_linux_amd64.deb

COPY --chown=python:python src/lro_repo_scaffolder lro_repo_scaffolder

USER python

CMD [ "python3.9", "-m" , "lro_repo_scaffolder"]

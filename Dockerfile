FROM python:3.9-slim-buster

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.name="LRO Repo Scaffolder" \
      org.label-schema.description = "Repository Scaffolder for GitHub." \
      org.label-schema.usage= "./README.md" \
      org.label-schema.vcs-url = "https://github.com/OLeonardoRodrigues/lro-repo-scaffolder"

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

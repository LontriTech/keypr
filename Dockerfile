FROM python:3.9-slim-buster

WORKDIR /app

RUN useradd -m python

COPY --chown=python:python requirements.txt ./

RUN pip3 install -r requirements.txt

RUN apt-get update && apt-get upgrade -y && apt-get install curl -y

RUN curl https://github.com/cli/cli/releases/download/v2.7.0/gh_2.7.0_linux_arm64.deb /
    && sudo dpkg -i gh_2.7.0_linux_arm64.deb

COPY --chown=python:python src/lro_repo_scaffolder lro_repo_scaffolder

USER python

CMD [ "python3.9", "-m" , "lro_repo_scaffolder"]

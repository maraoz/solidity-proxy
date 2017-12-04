FROM node:8.7.0
ARG USER_NAME
RUN apt-get update && apt-get install -y sudo && npm install -g truffle
RUN useradd --user-group --create-home --shell /bin/false ${USER_NAME} &&\
  echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USER_NAME}
RUN mkdir /opt/work && \
chown ${USER_NAME}:${USER_NAME} /opt/work
USER ${USER_NAME}
WORKDIR /opt/work

FROM node

RUN apt-get update && apt-get -y install libgtkextra-dev libgconf2-dev libnss3 libasound2 libxtst-dev libxss1 libgtk-3-0
RUN apt-get update && apt-get install -y curl sudo

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y locales && locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8
RUN curl -o- -L https://yarnpkg.com/install.sh | bash && export PATH="$PATH:`yarn global bin`"

ARG DOCKER_UID=1001
ARG DOCKER_USER=docker
ARG DOCKER_PASSWORD=docker
RUN useradd -m -u ${DOCKER_UID} -G sudo ${DOCKER_USER} && echo ${DOCKER_USER}:${DOCKER_PASSWORD} | chpasswd

WORKDIR /home/${DOCKER_USER}/app
RUN yarn -D add electron
USER ${DOCKER_USER}

ENV QT_X11_NO_MITSHM=1


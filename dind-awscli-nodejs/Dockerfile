FROM docker:stable

# Host Environment
ARG ENV
ENV ENV=$ENV

# NodeJS Environment
ARG NODE_ENV
ENV NODE_ENV=$NODE_ENV

# Update repositories
RUN apk update

# Install aws cli
RUN \
    apk -Uuv add --no-cache make gcc groff less git openssh \
        musl-dev libffi-dev openssl-dev \
        python2-dev py-pip && \
    pip install awscli && \
    apk --purge -v del py-pip && \
    rm /var/cache/apk/*

# Install NodeJS and update NPM
RUN \
    apk add --no-cache gettext nodejs npm && \
    npm install -g npm@latest && \
    npm --version && \
    node --version

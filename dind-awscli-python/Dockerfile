FROM docker:20.10.5-dind  AS build

# Install aws cli
RUN \
    apk -Uuv add --no-cache gcc make groff openssh \
        libc-dev musl-dev libffi-dev openssl-dev \
        python3-dev py-pip py3-pip rust cargo

RUN python3 --version && \
    pip3 --version

RUN pip3 install awscli aws-sam-cli docker-compose --upgrade

FROM build
# Host Environment
ARG ENV
ENV ENV=$ENV

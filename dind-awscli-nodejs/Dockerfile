# C compiler/development headers, python, pip and other build dependencies
FROM docker:20.10.18-dind-alpine3.16 AS system-requirements
RUN apk -Uuv add --no-cache \
    "bash=5.1.16-r2" \
    "gcc=11.2.1_git20220219-r2" \
    "make=4.3-r0" \
    "groff=1.22.4-r1" \
    "openssh=9.0_p1-r2" \
    "libc-dev=0.7.2-r3" \
    "musl-dev=1.2.3-r0" \
    "libffi-dev=3.4.2-r1" \
    "openssl-dev=1.1.1q-r0" \
    "python3-dev=3.10.5-r0" \
    "docker-compose=1.29.2-r2" \
    "poetry=1.1.13-r2" \
    "py3-pip=22.1.1-r0" \
    "nodejs=16.17.1-r0" \
    "npm=8.10.0-r0" \
    "gettext=0.21-r2"


FROM system-requirements AS pip-requirements
WORKDIR /
COPY pip/requirements.txt .
RUN pip install --no-cache-dir --no-deps -r requirements.txt \
    && rm requirements.txt


FROM pip-requirements AS nodejs-requirements
RUN npm i -g npm@8.19.2


# check whether the relevant binaries are accessible on $PATH
FROM nodejs-requirements AS binary-test
RUN python3 --version \
    && pip3 --version \
    && node --version \
    && npm --version \
    && aws --version \
    && docker --version \
    && docker-compose --version


# host environment
FROM pip-requirements AS host-environment
ARG ENV
ENV ENV=$ENV

ARG NODE_ENV
ENV NODE_ENV=$NODE_ENV

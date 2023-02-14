FROM docker:20.10.23-dind-alpine3.17@sha256:159779839c75eeafc7ad8b915e50459a8317c1d091cd6d4db33e92a215fc12f1 AS system-requirements
RUN apk -Uuv add --no-cache \
    "bash=5.2.15-r0" \
    "gcc=12.2.1_git20220924-r4" \
    "make=4.3-r1" \
    "groff=1.22.4-r2" \
    "openssh=9.1_p1-r2" \
    "libc-dev=0.7.2-r3" \
    "musl-dev=1.2.3-r4" \
    "libffi-dev=3.4.4-r0" \
    "openssl-dev=3.0.8-r0" \
    "python3-dev=3.10.10-r0" \
    "docker-compose=1.29.2-r2" \
    "poetry=1.2.2-r0" \
    "py3-pip=22.3.1-r1" \
    "nodejs=18.12.1-r0" \
    "npm=9.1.2-r0" \
    "gettext=0.21.1-r1"


FROM system-requirements AS pip-requirements
WORKDIR /
COPY pip/requirements.txt .
RUN pip install --no-cache-dir --no-deps -r requirements.txt \
    && rm requirements.txt


FROM pip-requirements AS nodejs-requirements
RUN npm i -g npm@9.4.0


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

FROM docker:20.10.22-dind-alpine3.17@sha256:56a2d342dd7f25fd604f71513f765526bd522f3c256bead83b6d30c5a8006fa6 AS system-requirements
RUN apk -Uuv add --no-cache \
    "bash=5.2.15-r0" \
    "gcc=12.2.1_git20220924-r4" \
    "make=4.3-r1" \
    "groff=1.22.4-r2" \
    "openssh=9.1_p1-r1" \
    "libc-dev=0.7.2-r3" \
    "musl-dev=1.2.3-r4" \
    "libffi-dev=3.4.4-r0" \
    "openssl-dev=3.0.7-r2" \
    "python3-dev=3.10.9-r1" \
    "docker-compose=1.29.2-r2" \
    "poetry=1.2.2-r0" \
    "py3-pip=22.3.1-r1"


FROM system-requirements AS pip-requirements
WORKDIR /
COPY pip/requirements.txt .
RUN pip install --no-cache-dir --no-deps -r requirements.txt \
    && rm requirements.txt


# check whether the relevant binaries are accessible on $PATH
FROM pip-requirements AS binary-test
RUN python3 --version \
    && pip3 --version \
    && aws --version \
    && docker --version \
    && docker-compose --version


# host environment
FROM pip-requirements AS host-environment
ARG ENV
ENV ENV=$ENV

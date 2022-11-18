# ======================================================================================================================
FROM golang:1.19.3-bullseye@sha256:d388153691a825844ebb3586dd04d1c60a2215522cc445701424205dffc8a83e AS go-compiler

ENV TERRAFORM_GIT_URL=https://github.com/hashicorp/terraform.git
ENV TERRAFORM_VERSION=v1.3.5

ENV TERRAGRUNT_GIT_URL=https://github.com/gruntwork-io/terragrunt.git
ENV TERRAGRUNT_VERSION=v0.40.2

ENV ATLANTIS_GIT_URL=https://github.com/runatlantis/atlantis.git
ENV ATLANTIS_VERSION=v0.20.1

ENV INFRACOST_GIT_URL=https://github.com/infracost/infracost.git
ENV INFRACOST_VERSION=v0.10.13

ENV BUILD_DIR=/build
WORKDIR ${BUILD_DIR}

# .................
FROM go-compiler AS terraform-build
RUN git clone --depth 1 --branch "$TERRAFORM_VERSION" "$TERRAFORM_GIT_URL" . \
    && go build -v -trimpath -ldflags "-w -s" .

# .................
FROM go-compiler AS terragrunt-build
RUN git clone --depth 1 --branch "$TERRAGRUNT_VERSION" "$TERRAGRUNT_GIT_URL" . \
    && go build -v -trimpath -ldflags "-w -s" .

# .................
FROM go-compiler AS atlantis-build
RUN git clone --depth 1 --branch "$ATLANTIS_VERSION" "$ATLANTIS_GIT_URL" . \
    && go build -v -trimpath -ldflags "-w -s" .

# .................
FROM go-compiler AS infracost-build
# hadolint ignore=DL3003
RUN git clone --depth 1 --branch "$INFRACOST_VERSION" "$INFRACOST_GIT_URL" . \
    && cd "${BUILD_DIR}/cmd/infracost" \
    && go build -v -trimpath -ldflags "-w -s" . \
    && mv infracost ../..

# .................
FROM go-compiler AS compiled-binaries
WORKDIR /cbin
COPY --from=terraform-build  "${BUILD_DIR}/terraform" .
COPY --from=terragrunt-build "${BUILD_DIR}/terragrunt" .
COPY --from=atlantis-build   "${BUILD_DIR}/atlantis" .
COPY --from=infracost-build  "${BUILD_DIR}/infracost" .

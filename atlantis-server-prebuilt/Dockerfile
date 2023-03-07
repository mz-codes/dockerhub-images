# ======================================================================================================================
FROM golang:1.20.1-bullseye@sha256:b03e75040e516c6e349e27a0f64a99883728958b38e744ea0293389e3643ecbb AS go-compiler

ENV TERRAFORM_GIT_URL=https://github.com/hashicorp/terraform.git
ENV TERRAFORM_VERSION=v1.3.9

ENV TERRAGRUNT_GIT_URL=https://github.com/gruntwork-io/terragrunt.git
ENV TERRAGRUNT_VERSION=v0.44.4

ENV ATLANTIS_GIT_URL=https://github.com/runatlantis/atlantis.git
ENV ATLANTIS_VERSION=v0.23.2

ENV INFRACOST_GIT_URL=https://github.com/infracost/infracost.git
ENV INFRACOST_VERSION=v0.10.17

ENV TERRAFORM_DOCS_GIT_URL=https://github.com/terraform-docs/terraform-docs.git
ENV TERRAFORM_DOCS_VERSION=v0.16.0

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
FROM go-compiler AS terraform-docs-build
RUN git clone --depth 1 --branch "$TERRAFORM_DOCS_VERSION" "$TERRAFORM_DOCS_GIT_URL" . \
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
COPY --from=terraform-docs-build  "${BUILD_DIR}/terraform-docs" .

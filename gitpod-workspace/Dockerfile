FROM gitpod/workspace-full:2023-01-16-03-31-28@sha256:d5787229cd062aceae91109f1690013d3f25062916492fb7f444d13de3186178 AS base


# ===================================================================
FROM base AS packages
USER root
RUN apt-get update \
    && apt-get upgrade --yes \
    && apt-get install --yes --no-install-recommends "neovim=0.4.3*" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER gitpod
RUN brew link cmake \
    && brew update \
    && brew upgrade \
    && brew install \
        terraform \
        terraform-docs \
        terragrunt \
        infracost \
        shellcheck \
        hadolint \
        awscli \
        fd \
        bat \
        exa \
        mongosh \
        dive \
        itchyny/tap/mmv


# ===================================================================
FROM packages AS altvers
USER gitpod
SHELL ["/usr/bin/bash", "-c"]

# hadolint ignore=SC1091
RUN source "$HOME/.nvm/nvm-lazy.sh" \
    && nvm install 14 \
    && nvm install 18 \
    && nvm install 19 \
    && pyenv install 3.9 \
    && pyenv install 3.10 \
    && pyenv install 3.11


# ===================================================================
FROM altvers AS zshconf
USER gitpod

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && git clone --depth=1 \
        "https://github.com/romkatv/powerlevel10k.git" \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" \
    && git clone --depth=1 \
        "https://github.com/zsh-users/zsh-autosuggestions" \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" \
    && git clone --depth=1 \
        "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

FROM altvers AS runtime
ENV DOCKER_BUILDKIT=1
WORKDIR /home/gitpod
COPY --chown=gitpod:gitpod .zshrc .

USER root
RUN chsh -s /usr/bin/zsh

USER gitpod
CMD ["zsh"]

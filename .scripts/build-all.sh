#!/usr/bin/env bash

source ./.scripts/shared.sh

FALLBACK_TAG="vX.P.T.O"

DOCKER_ACC_USERNAME="mzgroup"
HERE=$(pwd)


check_and_build() {
    ew "Checking remote repository..."

    local repo
    local tag
    repo="$1"
    tag="$2"

    local proj_tagged
    proj_tagged="${DOCKER_ACC_USERNAME}/${repo}:${tag}"

    if docker manifest inspect "$proj_tagged" > /dev/null 2>&1; then
        ef "tag already exists; skipping"
    else
        ef "not found"
        ei "Building image..."
        newl

        if docker build -t "$proj_tagged" .; then
            newl

            if [[ "$tag" != "$FALLBACK_TAG" ]]; then
                ei "Pushing to remote repository..."
                newl

                if docker push "$proj_tagged"; then
                    newl
                    ei "FINISHED"
                else
                    log "$HERE" "$repo" "Could not push image to remote"
                fi
            fi
        else
            log "$HERE" "$repo" "Could not build image"
        fi
    fi
}

main() {
    printf "\n%s\n" "--- ROUTINE STARTED ---"

    for docker_proj in */; do
        newl
        echo "ENTERING PROJECT: ${docker_proj}"

        local dp_nfs  # [d]ocker [p]roject - [n]o [f]inal [s]lash
        dp_nfs="${docker_proj%*/}"

        local dp_dir  # [d]ocker [p]roject - dir
        dp_dir="${HERE}/${docker_proj}"
        (
            cd "$dp_dir" || return 1

            local df_path  # [d]ocker[f]ile path
            df_path="${dp_dir}/Dockerfile"

            local version
            version="${CI_COMMIT_TAG:-$FALLBACK_TAG}"

            if [[ -f "$df_path" ]]; then
                check_and_build "$dp_nfs" "$version"
            else
                ei "Dockerfile not found; skipping"
            fi
        )
    done

    see_logs "$HERE"
    printf "\n%s\n" "--- ROUTINE FINISHED ---"
}

main

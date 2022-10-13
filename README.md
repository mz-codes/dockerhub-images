[![it-works](https://forthebadge.com/images/badges/it-works-why.svg)](https://forthebadge.com)
[![powered-by](https://forthebadge.com/images/badges/powered-by-black-magic.svg)](https://forthebadge.com)

# DockerHub Images

<img src="ship.png" height="360px" align="right"/>

This is a monorepository containing the "recipes" (Dockerfile and other required files) of all the publicly available
images (on [DockerHub][mzdh]) maintained and used by MZ Group.


[[_TOC_]]


## Content

Brief summary of what images are available and what does what:

| Image name | Details | Usage |
| ---        | ---     | ---   |
| [`dind-awscli-python`](/dind-awscli-python) | ![][dap-ver]<br>![][dap-pulls]<br>![][dap-size] | Docker image used on Gitlab-CI pipelines to build dockerized Python applications |
| [`dind-awscli-nodejs`](/dind-awscli-nodejs) | ![][dan-ver]<br>![][dan-pulls]<br>![][dan-size] | Docker image used on Gitlab-CI pipelines to build dockerized NodeJS applications |


[mzdh]: https://hub.docker.com/u/mzgroup

[dap-ver]: https://img.shields.io/docker/v/mzgroup/dind-awscli-python?logo=docker&style=social
[dap-pulls]: https://img.shields.io/docker/pulls/mzgroup/dind-awscli-python?label=pulls&logo=docker&style=social
[dap-size]: https://img.shields.io/docker/image-size/mzgroup/dind-awscli-python?label=size&logo=docker&style=social

[dan-ver]: https://img.shields.io/docker/v/mzgroup/dind-awscli-nodejs?logo=docker&style=social
[dan-pulls]: https://img.shields.io/docker/pulls/mzgroup/dind-awscli-nodejs?label=pulls&logo=docker&style=social
[dan-size]: https://img.shields.io/docker/image-size/mzgroup/dind-awscli-nodejs?label=size&logo=docker&style=social


## Git development flow

```mermaid
%%{ init: { 'theme':'default' } }%%
    gitGraph
        commit
        branch feature/some-change
        checkout feature/some-change
        commit
        commit
        commit
        checkout main
        merge feature/some-change
        commit tag: "v0.1.0"
        branch feature/another-change
        checkout feature/another-change
        commit
        commit
        commit
        commit
        checkout main
        merge feature/another-change
        commit tag: "v0.2.0"
```

1. A new feature branch is created from `main`;
1. Changes are commited to the feature branch;
1. Feature branch is merged back to `main`;
1. A new release is created using a [semver tag](https://semver.org).


## How this project works

Each directory located at the root of this project represents an image on DockerHub. The directory name matches the
image name exactly. Versioning is "global", meaning that when a git tag is pushed, all images are built and pushed with
that tag.

Considering a project structure that looks like this:

```
.
├── my-image-a
│   └── Dockerfile
├── my-image-b
│   └── Dockerfile
└── README.md

2 directories, 3 files
```

A new git tag named `v0.1.0` would build/push two Docker images tagged `mzgroup/my-image-a:v0.1.0` and `mzgroup/my-image-b:v0.1.0`.

### Under the hood

The magic that makes this repository alive is located at [`.scripts`](/.scripts).

- [`lint-all.sh`](/.scripts/lint-all.sh) runs [Hadolint][hadolint] against the Dockerfile inside each top-level directory;
- [`build-all.sh`](/.scripts/build-all.sh) runs docker build/push against each top-level directory (image).

The linting and build pipeline is runned for all merge requests opened against `main`. The build and push pipeline is runned for all tag pushes.

[hadolint]: https://github.com/hadolint/hadolint

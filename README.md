[![it-works](https://forthebadge.com/images/badges/it-works-why.svg)](https://forthebadge.com)
[![powered-by](https://forthebadge.com/images/badges/powered-by-black-magic.svg)](https://forthebadge.com)

# DockerHub Images

<img src="ship.png" height="360px" align="right"/>

This is a monorepository containing the "recipes" (Dockerfile and other required files) of all the publicly available
images (on [DockerHub][mzdh]) maintained and used by MZ Group.

| Image name | Details | Usage |
| ---        | ---     | ---   |
| [`dind-awscli-python`](/dind-awscli-python) | ![][dap-ver]<br>![][dap-pulls]<br>![][dap-size] | Docker image used on Gitlab-CI pipelines to build dockerized Python applications |
| [`dind-awscli-nodejs`](/dind-awscli-nodejs) | ![][dan-ver]<br>![][dan-pulls]<br>![][dan-size] | Docker image used on Gitlab-CI pipelines to build dockerized NodeJS applications |


[mzdh]: https://hub.docker.com/u/mzgroup

[dap-ver]: https://img.shields.io/docker/v/mzgroup/dind-awscli-python?logo=docker&style=social
[dap-pulls]: https://img.shields.io/docker/pulls/mzgroup/dind-awscli-python?label=pulls&logo=docker&style=social
[dap-size]: https://img.shields.io/docker/image-size/mzgroup/dind-awscli-python?label=size&logo=docker&style=social

[dan-ver]: https://img.shields.io/docker/v/mzgroup/dind-awscli-python?logo=docker&style=social
[dan-pulls]: https://img.shields.io/docker/pulls/mzgroup/dind-awscli-python?label=pulls&logo=docker&style=social
[dan-size]: https://img.shields.io/docker/image-size/mzgroup/dind-awscli-python?label=size&logo=docker&style=social

# virtual-biotic-pollination-flow

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Build Status](https://travis-ci.com/kguidonimartins/virtual-biotic-pollination-flow.svg?token=yxuzigPBpgHFpwAypqgf&branch=master)](https://travis-ci.com/kguidonimartins/virtual-biotic-pollination-flow)
![r-test-check](https://github.com/kguidonimartins/virtual-biotic-pollination-flow/workflows/r-test-check/badge.svg)
![docker-build-push](https://github.com/kguidonimartins/virtual-biotic-pollination-flow/workflows/docker-build-push/badge.svg)

## Run app in a docker container

Download the image:

```bash
docker pull kguidonimartins/vbpflow-app
```

Run the container:

```bash
docker run --rm -p 3838:3838 kguidonimartins/vbpflow-app
```

In your preferred browser, navigate to [http://localhost:3838/](http://localhost:3838/).

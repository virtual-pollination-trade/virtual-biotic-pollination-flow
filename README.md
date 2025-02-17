# virtual-biotic-pollination-flow

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Build Status](https://travis-ci.com/kguidonimartins/virtual-biotic-pollination-flow.svg?token=yxuzigPBpgHFpwAypqgf&branch=master)](https://travis-ci.com/kguidonimartins/virtual-biotic-pollination-flow)
![r-test-check](https://github.com/kguidonimartins/virtual-biotic-pollination-flow/workflows/r-test-check/badge.svg)
![docker-build-push](https://github.com/kguidonimartins/virtual-biotic-pollination-flow/workflows/docker-build-push/badge.svg)
[![](https://img.shields.io/badge/Shiny-shinyapps.io-blue?style=flat&labelColor=white&logo=RStudio&logoColor=blue)](https://virtual-pollination-trade.shinyapps.io/virtual-biotic-pollination-flow/)

This repository hosts the source code of the `virtual-biotic-pollination-flow` app, a shiny application available at this link: https://virtual-pollination-trade.shinyapps.io/virtual-biotic-pollination-flow/

The `virtual-biotic-pollination-flow` app is a supplementary material accompanying the publication:

#### F. D. S. Silva [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0001-9445-9493), L. G. Carvalheiro [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0001-7655-979X), J. Aguirre-Gutiérrez [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0001-9190-3229), M. Lucotte [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0002-6360-2979), K. Guidoni-Martins [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0002-8458-8467), F. Mertens [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0002-1449-8140). *Virtual pollination trade uncovers global dependence on biodiversity of developing countries*. Published in *Science Advances*, 10 March 2021 [https://advances.sciencemag.org/content/7/11/eabe6636](https://advances.sciencemag.org/content/7/11/eabe6636)

<!-- <https://doi.org/> -->

## Usage

### Run `virtual-biotic-pollination-flow` app locally

In order to run this app locally, you need install [`R`](https://www.r-project.org/) programming language.

Download the repository as a [zip](https://github.com/virtual-pollination-trade/virtual-biotic-pollination-flow/archive/trunk.zip) or clone using [`git`](https://git-scm.com/) command line:

```bash
git clone --depth 1 https://github.com/virtual-pollination-trade/virtual-biotic-pollination-flow.git
```

Access the app folder:

```bash
cd virtual-biotic-pollination-flow
```

And run a new app instance with:

```r
Rscript app.R
```

In your preferred browser, access the URL generated by the app instance.


### Run app in a docker container

Download the image:

```bash
docker pull kguidonimartins/vbpflow-app
```

Run the container:

```bash
docker run --rm -p 3838:3838 kguidonimartins/vbpflow-app
```

In your preferred browser, navigate to [http://localhost:3838/](http://localhost:3838/).

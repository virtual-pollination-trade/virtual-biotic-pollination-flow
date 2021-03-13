# get shiny serves plus tidyverse packages image
FROM rocker/shiny-verse

# system libraries of general use
RUN apt-get update && apt-get install -y \
    build-essential \
    bwidget \
    libcairo2-dev \
    libcurl4-gnutls-dev \
    libgdal-dev \
    libgeos++-dev \
    libgeos-dev \
    libgsl0-dev \
    libproj-dev \
    libspatialite-dev \
    libssh2-1-dev \
    libssl-dev \
    libudunits2-dev \
    libxml2-dev \
    libxt-dev \
    netcdf-bin \
    pandoc \
    pandoc-citeproc

# install R packages required
# (change it dependeing on the packages you need)
RUN R -e "pkg <- c( \
                    'dplyr', \
                    'DT', \
                    'ggplot2', \
                    'ggtext', \
                    'here', \
                    'knitr', \
                    'magrittr', \
                    'qs', \
                    'rmarkdown', \
                    'rsconnect', \
                    'scales', \
                    'sf', \
                    'shiny', \
                    'shinydashboard', \
                    'shinythemes', \
                    'usethis'); \
           install.packages(pkg, repos = \
           'http://mran.revolutionanalytics.com/snapshot/2020-05-28/')"

# create folder to store data
RUN rm -rf /srv/shiny-server/*
RUN mkdir -p /srv/shiny-server/{inst/extdata,R,www}

# copy the app to the image
COPY app.R global.R /srv/shiny-server/
COPY inst/extdata/* /srv/shiny-server/inst/extdata/
COPY R/* /srv/shiny-server/R/
COPY www/google-analytics.html /srv/shiny-server/www/
COPY ABOUT.md /srv/shiny-server/

# this file needs to be executable.
# dont forget: `sudo chmod +x shiny-server.sh`
COPY shiny-server.sh /usr/bin/shiny-server.sh

# select port
EXPOSE 3838

# run app
CMD ["/usr/bin/shiny-server.sh"]

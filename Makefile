.PHONY: help test_pkg test_shiny check clean
.DEFAULT_GOAL := help

DOCKER_IMAGE := kguidonimartins/vbpflow-app

all: test_pkg check clean ## run test_pkg, check, and clean targets

run:          ## run shiny app locally
	xdg-open http://127.0.0.1:8080/
	Rscript -e "shiny::runApp(appDir = '.', port = 8080, quiet = TRUE)"

deploy_app:   ## deploy the last version of shiny app
	mv .Rprofile bkp_rprofile
	Rscript -e "rsconnect::deployApp(appDir = '.', upload = TRUE, launch.browser = TRUE, forceUpdate = TRUE, logLevel = 'verbose', lint = TRUE)"
	mv bkp_rprofile .Rprofile

show_logs:    ## show the last 200 logs of the website
	Rscript -e "rsconnect::showLogs(entries = 200)"

show_online:  ## open URL of the shiny app
	xdg-open https://kguidonimartins.shinyapps.io/virtual-biotic-pollination-flow/

test_pkg:     ## test functions and shiny app
	Rscript -e "devtools::test()"

test_shiny:   ## test shinyapp
	# Rscript -e "shinytest::installDependencies()"
	# Rscript -e "shinytest::testApp(appDir = '.', quiet = TRUE, compareImages = FALSE)"

check:        ## check package build, documentation, and tests
	Rscript -e "devtools::check()"

docker_build: ## build the docker image based on Dockerfile
	docker build -t $(DOCKER_IMAGE) .

docker_run:   ## run the docker container
	xdg-open http://127.0.0.1:3838/
	docker run --rm -p 3838:3838 $(DOCKER_IMAGE)

docker_push:  ## push docker image to dockerhub
	docker login && docker push $(DOCKER_IMAGE)

clean:        ## remove junk things
	if [ -f tests/testthat/Rplots.pdf ]; then rm tests/testthat/Rplots.pdf; fi

help:         ## show this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

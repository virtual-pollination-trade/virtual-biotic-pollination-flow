.DEFAULT_GOAL := help

.PHONY: help tests clean

all: test_pkg check clean ## run check and clean targets

run:          ## run shiny app locally
	xdg-open http://127.0.0.1:8080/
	Rscript -e "shiny::runApp(appDir = '.', port = 8080, quiet = TRUE)"

deploy_app:   ## deploy the last version of shiny app
	Rscript -e "rsconnect::deployApp(appDir = '.', upload = TRUE, launch.browser = TRUE, forceUpdate = TRUE, logLevel = 'verbose', lint = TRUE)"

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
	Rscript -e "devtools::check(cran = FALSE)"

docker_build: ## build the docker image based on Dockerfile
	docker build -t vbpflow-app .

docker_run:   ## run the docker container
	xdg-open http://127.0.0.1:3838/
	docker run --rm -p 3838:3838 vbpflow-app

clean:        ## remove junk things
	rm tests/testthat/Rplots.pdf

help:         ## show this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

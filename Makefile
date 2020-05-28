.DEFAULT_GOAL := help

.PHONY: help tests clean

all: tests check clean ## run tests, check, and clean targets

run: ## run shiny app locally
	@echo
	@echo "--------------------------------"
	@echo "      Running shiny app         "
	@echo "--------------------------------"
	@echo
	xdg-open http://127.0.0.1:8080/
	Rscript -e "shiny::runApp(appDir = '.', port = 8080, quiet = TRUE)"
	@echo

deploy: ## deploy the last version of shiny app
	@echo
	@echo "--------------------------------"
	@echo "    Deploying shiny app         "
	@echo "--------------------------------"
	@echo
	Rscript -e "rsconnect::deployApp(appDir = '.', upload = TRUE, launch.browser = TRUE, forceUpdate = TRUE, logLevel = 'verbose', lint = TRUE)"
	@echo

show_logs: ## show the last 200 logs of the website
	@echo
	@echo "--------------------------------"
	@echo "        Getting logs            "
	@echo "--------------------------------"
	@echo
	Rscript -e "rsconnect::showLogs(entries = 200)"
	@echo

show_online: ## open URL of the shiny app
	@echo
	@echo "--------------------------------"
	@echo "      Opening online app        "
	@echo "--------------------------------"
	@echo
	xdg-open https://kguidonimartins.shinyapps.io/virtual-biotic-pollination-flow/
	@echo

tests: ## test functions and shiny app 
	@echo
	@echo "--------------------------------"
	@echo "        Running tests           "
	@echo "--------------------------------"
	@echo
	@echo "Testing functions"
	@echo
	Rscript -e "devtools::test()"
	@echo
	# @echo "Testing shiny app"
	# @echo
	# Rscript -e "shinytest::installDependencies()"
	# Rscript -e "shinytest::testApp(appDir = '.', quiet = TRUE, compareImages = FALSE)"
	# @echo

check: ## check package build, documentation, and tests
	@echo
	@echo "--------------------------------"
	@echo "        Checking package        "
	@echo "--------------------------------"
	@echo
	Rscript -e "devtools::check()"
	@echo

clean: ## remove junk things
	@echo
	@echo "--------------------------------"
	@echo "     Removing junk things       "
	@echo "--------------------------------"
	@echo
	rm tests/testthat/Rplots.pdf
	@echo

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


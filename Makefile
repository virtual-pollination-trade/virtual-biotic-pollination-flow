all: run

run:
	@echo
	@echo "--------------------------------"
	@echo "      Running shiny app         "
	@echo "--------------------------------"
	@echo
	Rscript -e "shiny::runApp(appDir = '.', port = 8080, launch.browser = TRUE, quiet = TRUE)"
	@echo

deploy:
	@echo
	@echo "--------------------------------"
	@echo "    Deploying shiny app         "
	@echo "--------------------------------"
	@echo
	Rscript -e "rsconnect::deployApp(appDir = '.', upload = TRUE, launch.browser = TRUE, forceUpdate = TRUE, logLevel = 'verbose', lint = TRUE)"
	@echo

show_logs:
	@echo
	@echo "--------------------------------"
	@echo "        Getting logs            "
	@echo "--------------------------------"
	@echo
	Rscript -e "rsconnect::showLogs(entries = 200)"
	@echo

show_online:
	@echo
	@echo "--------------------------------"
	@echo "      Opening online app        "
	@echo "--------------------------------"
	@echo
	Rscript -e "utils::browseURL('https://kguidonimartins.shinyapps.io/virtual-biotic-pollination-flow/')"
	@echo

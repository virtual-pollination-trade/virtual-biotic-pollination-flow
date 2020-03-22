all: run

run:
	Rscript -e "utils::browseURL('http://127.0.0.1:8080')"
	Rscript -e "shiny::runApp(appDir = '.', port = 8080)" 

deploy:
	Rscript -e "rsconnect::deployApp('.')"

show_logs:
	Rscript -e "rsconnect::showLogs(entries = 200)"

show_online:
	Rscript -e "utils::browseURL('https://kguidonimartins.shinyapps.io/virtual-pollinators-flow-app/')"

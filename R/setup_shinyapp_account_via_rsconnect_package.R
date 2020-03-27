library(rsconnect)

setAccountInfo(
  name = "kguidonimartins",
  token = Sys.getenv(SHINY_TOKEN),
  secret = Sys.getenv(SHINY_SECRET)
)

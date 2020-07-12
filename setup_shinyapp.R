library(rsconnect)
library(dotenv)

load_dot_env(file = ".env")

setAccountInfo(
  name = "kguidonimartins",
  token = Sys.getenv("SHINY_TOKEN"),
  secret = Sys.getenv("SHINY_SECRET")
)

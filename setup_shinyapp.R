library(rsconnect)
library(dotenv)

load_dot_env(file = ".env")

setAccountInfo(
  name   = "virtual-pollination-trade",
  token  = Sys.getenv("SHINY_TOKEN"),
  secret = Sys.getenv("SHINY_SECRET")
)

options(rsconnect.http.trace   = TRUE)
options(rsconnect.http.verbose = TRUE)

rsconnect::deployApp(
  appDir         = '.',
  account        = "virtual-pollination-trade",
  upload         = TRUE,
  launch.browser = TRUE,
  forceUpdate    = TRUE,
  logLevel       = 'verbose',
  lint           = TRUE
)

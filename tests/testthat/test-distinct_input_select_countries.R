context("Testing `distinct_input_select_countries()`")

pkg_data <-
  system.file("extdata", "virtual-pollinators-flow.qs", package = "vbpflow")

df <-
  qread(pkg_data)

# xpectr::gxs_selection("distinct_input_select_countries(df, reporter_countries)")

## Testing 'distinct_input_select_countries(df, reporter_c...'              ####
## Initially generated by xpectr
xpectr::set_test_seed(42)
# Assigning output
output_19148 <- distinct_input_select_countries(df, reporter_countries)
# Testing class
expect_equal(
  class(output_19148),
  "character",
  fixed = TRUE
)
# Testing type
expect_type(
  output_19148,
  type = "character"
)
# Testing values
expect_equal(
  xpectr::smpl(output_19148, n = 30),
  c(
    "Azerbaijan", "Belize", "Bhutan", "Botswana", "Costa Rica", "Egypt",
    "France", "Greece", "Indonesia", "Iran", "Kiribati", "Kuwait",
    "Nepal", "Netherlands", "Oman", "Papua New Guinea", "Poland",
    "Russia", "Saudi Arabia", "Singapore", "Slovakia", "Suriname",
    "Sweden", "Syria", "Tonga", "Trinidad and Tobago", "Tunisia",
    "Ukraine", "United Arab Emirates", "Zambia"
  ),
  fixed = TRUE
)
# Testing names
expect_equal(
  names(xpectr::smpl(output_19148, n = 30)),
  NULL,
  fixed = TRUE
)
# Testing length
expect_equal(
  length(output_19148),
  157L
)
# Testing sum of element lengths
expect_equal(
  sum(xpectr::element_lengths(output_19148)),
  157L
)
## Finished testing 'distinct_input_select_countries(df, reporter_c...'     ####

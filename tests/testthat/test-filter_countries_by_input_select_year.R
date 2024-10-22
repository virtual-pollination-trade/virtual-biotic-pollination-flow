context("Testing `filter_countries_by_input_select_year()`")

pkg_data <-
  system.file("extdata", "virtual-pollinators-flow.qs", package = "vbpflow")

df <-
  qread(pkg_data)

# xpectr::gxs_selection("filter_countries_by_input_select_year(df, 2001)")

## Testing 'filter_countries_by_input_select_year(df, 2001)'                ####
## Initially generated by xpectr
xpectr::set_test_seed(42)
# Assigning output
output_19148 <- filter_countries_by_input_select_year(df, 2001)
# Testing class
expect_equal(
  class(output_19148),
  c("tbl_df", "tbl", "data.frame"),
  fixed = TRUE
)
# Testing column values
expect_equal(
  xpectr::smpl(output_19148[["reporter_countries"]], n = 30),
  c(
    "Belgium", "Bulgaria", "Canada", "Canada", "Egypt", "France",
    "Greece", "Indonesia", "Iran", "Iran", "Israel", "Italy", "Italy",
    "Lithuania", "Netherlands", "Netherlands", "Peru", "Portugal",
    "Russia", "Spain", "Spain", "Turkey", "Turkey", "United Kingdom",
    "United Kingdom", "United Republic of Tanzania", "United Republic of Tanzania",
    "United States of America", "United States of America", "United States of America"
  ),
  fixed = TRUE
)
expect_equal(
  xpectr::smpl(output_19148[["partner_countries"]], n = 30),
  c(
    "Slovakia", "Denmark", "France", "Lithuania", "Netherlands", "Togo",
    "Germany", "Singapore", "Morocco", "United Arab Emirates", "Switzerland",
    "Albania", "United Kingdom", "Italy", "Germany", "United States of America",
    "Sweden", "Germany", "Armenia", "Morocco", "Saudi Arabia", "Oman",
    "Switzerland", "South Africa", "Ireland", "Japan", "Kenya",
    "Haiti", "Costa Rica", "Russia"
  ),
  fixed = TRUE
)
expect_equal(
  xpectr::smpl(output_19148[["year"]], n = 30),
  c(
    2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001,
    2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001,
    2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001
  ),
  tolerance = 1e-4
)
expect_equal(
  xpectr::smpl(output_19148[["vp_flow"]], n = 30),
  c(
    20.04133, 369.42866, 172.00421, 8.02828, 0.06555, 0.02367, 89.46413,
    1.70035, 7.70062, 8445.01235, 6.86107, 38.44043, 1240.34448,
    6.53552, 920.40072, 1.56816, 1018.77266, 0.65377, 1.02095, 93.50816,
    407.91864, 0.38073, 22.70546, 0.44719, 1398.21708, 1533.82165,
    201.48725, 70.04264, 26900.60709, 1672.05303
  ),
  tolerance = 1e-4
)
expect_equal(
  xpectr::smpl(output_19148[["reporter_long"]], n = 30),
  c(
    4.64065, 25.21553, -98.30777, -98.30777, 29.8619, -2.76173, 22.95556,
    117.24011, 54.27407, 54.27407, 35.00445, 12.07001, 12.07001,
    23.88719, 5.28145, 5.28145, -74.38243, -8.50104, 96.68656, -3.64755,
    -3.64755, 35.16895, 35.16895, -2.86563, -2.86563, 34.8131, 34.8131,
    -112.46167, -112.46167, -112.46167
  ),
  tolerance = 1e-4
)
expect_equal(
  xpectr::smpl(output_19148[["reporter_lat"]], n = 30),
  c(
    50.63982, 42.7689, 61.36206, 61.36206, 26.49593, 42.17344, 39.0747,
    -2.21505, 32.57503, 32.57503, 31.4611, 42.79663, 42.79663, 55.32611,
    52.10079, 52.10079, -9.1528, 39.59551, 61.98052, 40.24449, 40.24449,
    39.0616, 39.0616, 54.12387, 54.12387, -6.27565, -6.27565, 45.67955,
    45.67955, 45.67955
  ),
  tolerance = 1e-4
)
expect_equal(
  xpectr::smpl(output_19148[["partner_long"]], n = 30),
  c(
    19.47905, 10.02801, -2.76173, 23.88719, 5.28145, 0.96233, 10.38578,
    103.81726, -8.45616, 54.30017, 8.20867, 20.04983, -2.86563,
    12.07001, 10.38578, -112.46167, 16.74558, 10.38578, 44.92993,
    -8.45616, 44.53686, 56.09166, 8.20867, 25.0839, -8.13794, 138.0309,
    37.79594, -72.68528, -84.19209, 96.68656
  ),
  tolerance = 1e-4
)
expect_equal(
  xpectr::smpl(output_19148[["partner_lat"]], n = 30),
  c(
    48.70548, 55.98125, 42.17344, 55.32611, 52.10079, 8.52531, 51.10698,
    1.35876, 29.83763, 23.90528, 46.79786, 41.14245, 54.12387, 42.79663,
    51.10698, 45.67955, 62.77967, 51.10698, 40.28953, 29.83763,
    24.12246, 20.60515, 46.79786, -29.00034, 53.17545, 37.5923,
    0.59988, 18.93503, 9.97634, 61.98052
  ),
  tolerance = 1e-4
)
expect_equal(
  xpectr::smpl(output_19148[["reporter_hdi"]], n = 30),
  c(
    0.8964, 0.76613, 0.8976, 0.8976, 0.6528, 0.87527, 0.84613, 0.65033,
    0.73693, 0.73693, 0.8806, 0.86293, 0.86293, 0.81747, 0.90367,
    0.90367, 0.7118, 0.81427, 0.7706, 0.85567, 0.85567, 0.72027,
    0.72027, 0.89533, 0.89533, 0.47053, 0.47053, 0.90607, 0.90607,
    0.90607
  ),
  tolerance = 1e-4
)
expect_equal(
  xpectr::smpl(output_19148[["partner_hdi"]], n = 30),
  c(
    0.81347, 0.90793, 0.87527, 0.81747, 0.90367, 0.45067, 0.91167,
    0.8828, 0.60167, 0.83293, 0.9182, 0.72727, 0.89533, 0.86293,
    0.91167, 0.90607, 0.90613, 0.91167, 0.7112, 0.60167, 0.79653,
    0.773, 0.9182, 0.6402, 0.8994, 0.88153, 0.51967, 0.46633, 0.74753,
    0.7706
  ),
  tolerance = 1e-4
)
# Testing column names
expect_equal(
  names(output_19148),
  c(
    "reporter_countries", "partner_countries", "year", "vp_flow",
    "reporter_long", "reporter_lat", "partner_long", "partner_lat",
    "reporter_hdi", "partner_hdi"
  ),
  fixed = TRUE
)
# Testing column classes
expect_equal(
  xpectr::element_classes(output_19148),
  c(
    "character", "character", "numeric", "numeric", "numeric", "numeric",
    "numeric", "numeric", "numeric", "numeric"
  ),
  fixed = TRUE
)
# Testing column types
expect_equal(
  xpectr::element_types(output_19148),
  c(
    "character", "character", "double", "double", "double", "double",
    "double", "double", "double", "double"
  ),
  fixed = TRUE
)
# Testing dimensions
expect_equal(
  dim(output_19148),
  c(30134L, 10L)
)
# Testing group keys
expect_equal(
  colnames(dplyr::group_keys(output_19148)),
  character(0),
  fixed = TRUE
)
## Finished testing 'filter_countries_by_input_select_year(df, 2001)'       ####

# xpectr::gxs_selection("filter_countries_by_input_select_year(df, 'All years')")

## Testing 'filter_countries_by_input_select_year(df, 'All...'              ####
## Initially generated by xpectr
xpectr::set_test_seed(42)
# Assigning output
output_19148 <- filter_countries_by_input_select_year(df, "All years")
# Testing class
expect_equal(
  class(output_19148),
  c("tbl_df", "tbl", "data.frame"),
  fixed = TRUE
)
# Testing column values
expect_equal(
  xpectr::smpl(output_19148[["reporter_countries"]], n = 30),
  c(
    "India", "Switzerland", "Estonia", "Jamaica", "Kazakhstan", "Chile",
    "Singapore", "Indonesia", "Hong Kong S.A.R.", "Argentina", "Burkina Faso",
    "Denmark", "Burkina Faso", "United Kingdom", "Thailand", "Kazakhstan",
    "Sweden", "Honduras", "Tunisia", "Ecuador", "Albania", "Uganda",
    "Luxembourg", "Latvia", "Croatia", "Ecuador", "Argentina", "Latvia",
    "Canada", "Italy"
  ),
  fixed = TRUE
)
expect_equal(
  xpectr::smpl(output_19148[["partner_countries"]], n = 30),
  c(
    "Bolivia", "Bosnia and Herzegovina", "Saint Vincent and the Grenadines",
    "Singapore", "Saint Helena", "Mauritius", "Malta", "Belarus",
    "Spain", "Macedonia", "Greece", "Haiti", "Spain", "Hong Kong S.A.R.",
    "France", "Pakistan", "France", "Norway", "United Arab Emirates",
    "United Kingdom", "Montenegro", "Singapore", "Germany", "Netherlands",
    "Republic of Serbia", "Belgium", "Israel", "Lithuania", "Pakistan",
    "Austria"
  ),
  fixed = TRUE
)
expect_equal(
  xpectr::smpl(output_19148[["reporter_long"]], n = 30),
  c(
    79.61198, 8.20867, 25.54249, -77.31483, 67.29149, -71.38256, 103.81726,
    117.24011, 114.1138, -65.17981, -1.75457, 10.02801, -1.75457,
    -2.86563, 101.00288, 67.29149, 16.74558, -86.61517, 9.55288,
    -78.75202, 20.04983, 32.36908, 6.07182, 24.91236, 16.40413,
    -78.75202, -65.17981, 24.91236, -98.30777, 12.07001
  ),
  tolerance = 1e-4
)
expect_equal(
  xpectr::smpl(output_19148[["reporter_lat"]], n = 30),
  c(
    22.88578, 46.79786, 58.67193, 18.15695, 48.15688, -37.73071, 1.35876,
    -2.21505, 22.39828, -35.38135, 12.26954, 55.98125, 12.26954,
    54.12387, 15.11816, 48.15688, 62.77967, 14.82688, 34.11956,
    -1.42382, 41.14245, 1.27469, 49.76725, 56.85085, 45.08048, -1.42382,
    -35.38135, 56.85085, 61.36206, 42.79663
  ),
  tolerance = 1e-4
)
expect_equal(
  xpectr::smpl(output_19148[["reporter_hdi"]], n = 30),
  c(
    0.5626, 0.9182, 0.8356, 0.7042, 0.75687, 0.80093, 0.8828, 0.65033,
    0.88707, 0.7978, 0.35313, 0.90793, 0.35313, 0.89533, 0.70667,
    0.75687, 0.90613, 0.58713, 0.70087, 0.70767, 0.72727, 0.4632,
    0.8826, 0.8072, 0.79773, 0.70767, 0.7978, 0.8072, 0.8976, 0.86293
  ),
  tolerance = 1e-4
)
expect_equal(
  xpectr::smpl(output_19148[["partner_long"]], n = 30),
  c(
    -64.68539, 17.76877, -61.2013, 103.81726, -9.54779, 57.57121,
    14.40523, 28.03209, -3.64755, 21.68211, 22.95556, -72.68528,
    -3.64755, 114.1138, -2.76173, 69.33958, -2.76173, 15.34835,
    54.30017, -2.86563, 19.23884, 103.81726, 10.38578, 5.28145,
    20.78958, 4.64065, 35.00445, 23.88719, 69.33958, 14.12648
  ),
  tolerance = 1e-4
)
expect_equal(
  xpectr::smpl(output_19148[["partner_lat"]], n = 30),
  c(
    -16.70815, 44.1745, 13.22472, 1.35876, -12.40356, -20.27769, 35.9215,
    53.53131, 40.24449, 41.59531, 39.0747, 18.93503, 40.24449, 22.39828,
    42.17344, 29.94975, 42.17344, 68.75016, 23.90528, 54.12387,
    42.7889, 1.35876, 51.10698, 52.10079, 44.2215, 50.63982, 31.4611,
    55.32611, 29.94975, 47.58549
  ),
  tolerance = 1e-4
)
expect_equal(
  xpectr::smpl(output_19148[["partner_hdi"]], n = 30),
  c(
    0.6422, 0.7152, 0.7056, 0.8828, 0, 0.73427, 0.82967, 0.75967,
    0.85567, 0.71793, 0.84613, 0.46633, 0.85567, 0.88707, 0.87527,
    0.511, 0.87527, 0.93607, 0.83293, 0.89533, 0.78177, 0.8828,
    0.91167, 0.90367, 0, 0.8964, 0.8806, 0.81747, 0.511, 0.8758
  ),
  tolerance = 1e-4
)
expect_equal(
  xpectr::smpl(output_19148[["vp_flow"]], n = 30),
  c(
    0.78109, 1.49295, 1.99237, 2.12816, 9.59768, 13.50054, 38.3087,
    71.51181, 80.56767, 84.61936, 97.31219, 153.02402, 163.68754,
    270.31415, 694.09969, 818.73369, 1467.6149, 1772.90573, 2266.96987,
    9270.15019, 10044.50097, 36455.8252, 37559.25034, 48994.67782,
    78194.14496, 84882.96906, 87560.11374, 103713.12972, 361122.34041,
    614788.16637
  ),
  tolerance = 1e-4
)
# Testing column names
expect_equal(
  names(output_19148),
  c(
    "reporter_countries", "partner_countries", "reporter_long", "reporter_lat",
    "reporter_hdi", "partner_long", "partner_lat", "partner_hdi",
    "vp_flow"
  ),
  fixed = TRUE
)
# Testing column classes
expect_equal(
  xpectr::element_classes(output_19148),
  c(
    "character", "character", "numeric", "numeric", "numeric", "numeric",
    "numeric", "numeric", "numeric"
  ),
  fixed = TRUE
)
# Testing column types
expect_equal(
  xpectr::element_types(output_19148),
  c(
    "character", "character", "double", "double", "double", "double",
    "double", "double", "double"
  ),
  fixed = TRUE
)
# Testing dimensions
expect_equal(
  dim(output_19148),
  c(11386L, 9L)
)
# Testing group keys
expect_equal(
  colnames(dplyr::group_keys(output_19148)),
  character(0),
  fixed = TRUE
)
## Finished testing 'filter_countries_by_input_select_year(df, 'All...'     ####

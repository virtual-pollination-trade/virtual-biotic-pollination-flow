#' Informs when countries doesn't have relationships
#'
#' @import graphics
#'
#' @return a plot
#'
#' @export
#'
no_vp_flow <- function() {

  plot(
    x = 1:10,
    type = "n",
    xaxt = "n",
    yaxt = "n",
    ann = FALSE,
    frame.plot = FALSE
  )

  text(
    x = 5.5,
    y = 7.5,
    labels = paste(
      "These countries do not share virtual biotic pollination flow."
    ),
    cex = 2.5
  )

}

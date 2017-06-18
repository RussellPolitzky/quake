#' @title Timeline theme with no y axis
#'
#' @description \code{theme_timeline} is a \code{ggplot2} theme useful
#' for timelines because it turns off the superfluous y-axis.
#'
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 element_blank
#'
#' @example inst/examples/example_timeline_label.R
#'
#' @export
theme_timeline <- ggplot2::theme(
  axis.title.y    = ggplot2::element_blank(),
  axis.text.y     = ggplot2::element_blank(),
  axis.line.y     = ggplot2::element_blank(),
  axis.ticks.y    = ggplot2::element_blank(),
  legend.position = "bottom"
)

#' @title Timeline theme with minimal y-axis
#'
#' @description \code{theme_timeline_with_y_axis_text} is a \code{ggplot2}
#' theme useful' for timelines because it turns off the superfluous y-axis
#' parts while leaving the y-axis labels.
#'
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 element_blank
#'
#' @example inst/examples/example_timeline_label.R
#'
#' @export
theme_timeline_with_y_axis_text <- ggplot2::theme(
  axis.title.y    = ggplot2::element_blank(),
  axis.line.y     = ggplot2::element_blank(),
  axis.ticks.y    = ggplot2::element_blank(),
  legend.position = "bottom"
)

# Build a geom for ggplot2 called geom_timeline() for plotting a time line of
# earthquakes ranging from xmin to xmax dates with a point for each earthquake.
# Optional aesthetics include color, size, and alpha (for transparency). The
# x aesthetic is a date and an optional y aesthetic is a factor indicating some
# stratification in which case multiple time lines will be plotted for each
# level of the factor (e.g. country).

# look at the example geom_point.


#' @title A \code{ggplot2} \cide{Geom} prototype object for timelines
#'
#' @description \code{GeomTimeline} is a \code{ggplot2} \cide{Geom} prototype
#' object for timelines.  The geom plots a time line of earthquakes ranging
#' from \code{xmin} to \code{xmax} dates with a point for each earthquake.
#' Optional aesthetics include \code{color}, \code{size}, and \code{alpha} (for transparency).
#' The \code{x} aesthetic is a \code{Date} and an optional \code{y} aesthetic is a \code{factor}
#' indicating some stratification in which case multiple time lines will be plotted for each
#' level of the factor (e.g. country).
#'
#' @param
#'
#' @return
#'
#' @seealso \link{\code{geom_timeline}}
#'
#'
#' @rdname ggplot2-ggproto
#' @format NULL
#' @usage NULL
#'
#' @importFrom ggplot2 ggproto
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 draw_key_point
#' @importFrom grid pointsGrob
#' @importFrom ggplot2 alpha
#' @importFrom grid unit
#' @importFrom grid gList
#' @importFrom grid gpar
#'
#' @example examples/example_timeline_plot.R
#'
#' @export
GeomTimeline <- ggplot2::ggproto(
  "GeomTimeline",

  ggplot2::Geom,

  required_aes = c("x"),

  optional_aes = c(
    "y"       , "size"    , "shape"   , "colour", "fill",
    "linesize", "linetype", "fontsize", "stroke",
    "xmin"    ,  "xmax"
  ),

  default_aes  = ggplot2::aes(
    shape    = 19     ,
    y        = 1      ,
    size     = 5      ,
    alpha    = 0.15   ,
    colour   = 'black',
    fill     = "black",
    linesize = 0.5    ,
    linetype = 1      ,
    fontsize = 10     ,
    stroke   =  1     #,
    #xmin     = -1     ,
    #xmax     = -1
  ),

  draw_key = ggplot2::draw_key_point,

  setup_data = function(data, params) {
    data[ # filter based on given xmin and xmax
       data$x >= params$xmin &
       data$x <= params$xmax,
    ]
  },

  draw_panel = function(data, panel_scales, coord) {
    coords <-coord$transform(data, panel_scales)
    if (length(unique(coords$y)) == 1) coords$y = 0.1875 # plot line close to the bottom of the panel
    points <- grid::pointsGrob(
      x    = coords$x                      ,
      y    = coords$y                      ,
      size = grid::unit(coords$size , "mm"),
      pch  = coords$shape                  ,
      gp   = grid::gpar(
        col      = ggplot2::alpha(coords$colour, coords$alpha),
        fill     = coords$fill                                ,
        fontsize = grid::unit(coords$fontsize, "points")
      )
    )
    ys     <- unique(coords$y)
    rangex <- range(coords$x)
    lines  <- grid::segmentsGrob(
      x0 = rangex[1],
      x1 = rangex[2],
      y0 = ys,
      y1 = ys,
      gp = grid::gpar(
        col  = ggplot2::alpha(coords$colour[1], coords$alpha[1]),
        fill = ggplot2::alpha(coords$colour[1], coords$alpha[1]),
        lwd  = grid::unit(coords$linesize[1], "mm"),
        lty  = coords$linetype[1]
      )
    )
    grid::gTree(children = grid::gList(lines, points))
})


geom_timeline <- function(mapping     = NULL,       data        = NULL, stat = "identity",
                          position    = "identity", na.rm       = FALSE,
                          show.legend = NA        , inherit.aes = TRUE,
                          xmin = .Machine$double.xmin,
                          xmax = .Machine$double.xmax,
                          ...) {
  ggplot2::layer(
    geom = GeomTimeline      , mapping     = mapping    , position = position,
    data = data              , stat        = stat       ,
    show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(
      xmin  = as.numeric(xmin),
      xmax  = as.numeric(xmax),
      na.rm = na.rm,
      ...
      )
  )
}

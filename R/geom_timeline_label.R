#' @title A TimelineLabel geometry prototype object
#'
#' @description \code{GeomTimelineLabel} is the geometry prototype object
#' used by the \link{geom_timeline_label} geometry, layer function.
#'
#' @inheritParams ggplot2::Geom
#'
#' @format NULL
#' @usage NULL
#'
#' @return \code{GeomTimelineLabel} doesn't return anything per se.
#' Instead \code{GeomTimelineLabel} is as a prototype, or template
#' for objects of this type.
#'
#' @importFrom ggplot2 ggproto
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 alpha
#' @importFrom grid nullGrob
#' @importFrom grid textGrob
#' @importFrom grid textGrob
#' @importFrom grid segmentsGrob
#' @importFrom grid gpar
#' @importFrom grid unit
#' @importFrom grid gTree
#' @importFrom grid gList
#'
#' @example inst/examples/example_timeline_label.R
#'
GeomTimelineLabel  <- ggplot2::ggproto(

  "GeomTimelineLabel",

  ggplot2::Geom,

  required_aes = c("x", "label"),

  optional_aes = c(
    "y", "size", "shape", "colour",
    "linesize", "linetype", "fontsize", "stroke",
    "pointerheight", "angle", "labelcolour",
    "n_max", "fill", "xmin" ,  "xmax"
  ),

  default_aes  = ggplot2::aes(
    shape         = 19     , # shape 19 is a circle.
    y             = 1      ,
    size          = 5      ,
    alpha         = 0.15   ,
    colour        = "black",
    linesize      = 0.5    ,
    linetype      = 1      ,
    fontsize      = 10     ,
    stroke        = 1      ,
    pointerheight = 0.05   ,
    angle         = 45
  ),

  draw_key = function(data, params, size) grid::nullGrob(), # Don't want any key for labels.  This is a null function.

  setup_data = function(data, params) {
    sub_set_data <- function(data, n_max) { # Remove any data with size < n-max

      if (n_max < (.Machine$integer.max)) {
        num_rows <- nrow(data)
        last_row <- min(n_max, num_rows) # don't try to display rows > nrow of data frame.
        data[ order(-data[, "size"]), ][1:last_row, ]
      } else {
        data
      }
    }

    data                              %>%
      GeomTimeline$setup_data(params) %>% # filter by nmax and nmin
      sub_set_data(params$n_max)          # filter to show only n_max by size.
  },

  draw_panel = function(data, panel_scales, coord) {
    coords <-coord$transform(data, panel_scales)
    if (length(unique(coords$y)) == 1) coords$y = 0.1875 # plot line close to the bottom of the panel
    txt <- grid::textGrob(
      coords$label,
      coords$x,
      coords$y + (1.2 * coords$pointerheight), # 1.2 provides reasonable spacing.
      default.units = "native"    ,
      just          = "left"      ,
      rot           = coords$angle,
      gp = grid::gpar(
        col       = coords$labelcolour,
        fontsize  = grid::unit(coords$fontsize, "points")
      ),
      check.overlap = FALSE # check_overlap
    )
    lines <- grid::segmentsGrob(
      x0 = coords$x,
      x1 = coords$x,
      y0 = coords$y,
      y1 = coords$y + coords$pointerheight,
      gp = grid::gpar(
        col  = ggplot2::alpha(coords$colour, coords$alpha),
        fill = ggplot2::alpha(coords$colour, coords$alpha),
        lwd  = grid::unit(coords$linesize, "mm"),
        lty  = coords$linetype
      )
    )
    grid::gTree(children = grid::gList(txt, lines))
  }
)

#' @md
#' @title Add text labels to timelines produced with \link{geom_timeline}
#'
#' @description \code{geom_timeline_label} adds annotations to earthquake data
#' timelines produced with \link{geom_timeline}. This geom adds a vertical
#' line to each data point with a text annotation (e.g. the location of an
#' earthquake) attached atop to each line.
#' \code{geom_timeline_label} provides an option to subset to \code{n_max} number
#' of earthquakes, where \code{n_max} selects the largest (by magnitude) earthquakes.
#' This geometry supports the following aesthetics
#' * x is the date of the earthquake and
#' * label is the column name from which annotations will be obtained
#'
#' @inheritParams ggplot2::layer
#'
#' @param pointerheight is a \code{numeric} indicating the height of the pointer lines
#' used for labels.  This height is epcified as a faction of the viewport height,
#' and will usually not required adjustment.  The default value for this parameter
#' is set to 0.05.
#' @param angle is a \code{numeric} indicating the text label angle. Text is printed
#' at an angle to allow good reaability and to reduce label collisions for dense
#' time lines.  This angle won't usually require adjustment and is set at 45 degrees
#' by default.
#' @param n_max is a \code{numeric} giving the maximum number of labels to display.  This
#' reduces the number of label collisions in dense, timelime plots.  The labels to show
#' are chosen based on the \code{size} aestheic.  Setting \code{n_max} will result
#' in a maximum of \code{n_max} labels, ordered by the aesthetic \code{size}, being rendered.
#' @param labelcolour is a \code{string} giving the label colour.  This is set to 'black' by
#' default.
#' @param na.rm a \code{boolean} indicating whether or not to remove NAs.
#' \code{na.rm = FALSE} by default.
#' @param fill a \code{string} colour the fill colour ro be used for labels
#' \code{fill = 'black'} by default.
#' @param xmin is a \code{numeric} specifiying the minimum \code{x} value to consider.
#' \code{xmin = .Machine$double.xmin} by default.
#' @param xmax is a \code{numeric} specifiying the maximum \code{x} value to consider.
#' \code{xmax = .Machine$double.xmax} by default.
#' @param ... a \code{...} indicates a list of additional parameters
#' use for a geom.  \code{geom_timeline} doesn't make use of these.
#'
#' @return a \code{ggplot} object representing timeline labels.  This is intended to be
#' used with \link{geom_timeline}.
#'
#' @example inst/examples/example_timeline_label.R
#
#' @export
geom_timeline_label <- function(mapping     = NULL       , data          = NULL , stat        = "identity",
                                position    = "identity" , na.rm         = FALSE, show.legend = NA        ,
                                inherit.aes = TRUE       , pointerheight = 0.05 , angle       = 45        ,
                                labelcolour = "black"    , n_max         = .Machine$integer.max ,
                                fill        = "black"    ,
                                xmin        = .Machine$double.xmin,
                                xmax        = .Machine$double.xmax,
                                ...) {
  ggplot2::layer(
    geom = GeomTimelineLabel, mapping = mapping,
    data = data, stat = stat, position = position,
    show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(
      pointerheight = pointerheight,
      angle         = angle,
      labelcolour   = labelcolour,
      xmax          = as.numeric(xmax),
      xmin          = as.numeric(xmin),
      n_max         = n_max,
      na.rm         = na.rm,
      ...
    )
  )
}

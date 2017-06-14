

# 2. Build a geom called geom_timeline_label() for adding annotations to the
# earthquake data. This geom adds a vertical line to each data point with a text
# annotation (e.g. the location of the earthquake) attached to each line. There
# should be an option to subset to n_max number of earthquakes, where we take
# the n_max largest (by magnitude) earthquakes. Aesthetics are x, which is the
# date of the earthquake and label which takes the column name from which
# annotations will be obtained.

GeomTimelineLabel  <- ggplot2::ggproto(
  
  "GeomTimelineLabel",
  
  ggplot2::Geom,
  
  required_aes = c("x", "label"),
  
  optional_aes = c(
    "y", "size", "shape", "colour", "linesize", 
    "linetype", "fontsize", "stroke", "pointerheight",
    "angle", "labelcolour", "n_max", "fill"
  ),
  
  default_aes  = ggplot2::aes(
    shape         = 19     , 
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
  
  # Don't want any key for labels.
  draw_key = function(data, params, size) grid::nullGrob(),
               
  draw_panel = function(data, panel_scales, coord) {

    # Remove any data with size < n-max
    sub_set_data <- function(data, n_max) {
      if (n_max < (.Machine$integer.max)) {
        num_rows <- nrow(data)
        last_row <- min(n_max, num_rows) # don't try to display rows > nrow of data frame.
        data[ order(-data[, "size"]), ][1:last_row, ]
      } else {
        data
      }
    }


    n_max <- data[1, "n_max"]
    data  <- sub_set_data(data, n_max)
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
      check.overlap = FALSE #check_overlap
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


geom_timeline_label <- function(mapping     = NULL       , data          = NULL , stat        = "identity",
                                position    = "identity" , na.rm         = FALSE, show.legend = NA        , 
                                inherit.aes = TRUE       , pointerheight = 0.05 , angle       = 45        ,
                                labelcolour = "black"    , n_max         = .Machine$integer.max ,
                                fill        = "black"    ,
                                ...) {
  ggplot2::layer(
    geom = GeomTimelineLabel, mapping = mapping,  
    data = data, stat = stat, position = position, 
    show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(
      pointerheight = pointerheight, 
      angle         = angle,
      labelcolour   = labelcolour,
      n_max         = n_max,
      na.rm         = na.rm, 
      ...
    )
  )
}



 




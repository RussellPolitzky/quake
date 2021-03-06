% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom_timeline_label.R
\name{geom_timeline_label}
\alias{geom_timeline_label}
\title{Add text labels to timelines produced with \link{geom_timeline}}
\usage{
geom_timeline_label(mapping = NULL, data = NULL, stat = "identity",
  position = "identity", na.rm = FALSE, show.legend = NA,
  inherit.aes = TRUE, pointerheight = 0.05, angle = 45,
  labelcolour = "black", n_max = .Machine$integer.max, fill = "black",
  xmin = .Machine$double.xmin, xmax = .Machine$double.xmax, ...)
}
\arguments{
\item{mapping}{Set of aesthetic mappings created by \code{\link{aes}} or
\code{\link{aes_}}. If specified and \code{inherit.aes = TRUE} (the
default), it is combined with the default mapping at the top level of the
plot. You must supply \code{mapping} if there is no plot mapping.}

\item{data}{The data to be displayed in this layer. There are three
   options:

   If \code{NULL}, the default, the data is inherited from the plot
   data as specified in the call to \code{\link{ggplot}}.

   A \code{data.frame}, or other object, will override the plot
   data. All objects will be fortified to produce a data frame. See
   \code{\link{fortify}} for which variables will be created.

   A \code{function} will be called with a single argument,
   the plot data. The return value must be a \code{data.frame.}, and
   will be used as the layer data.}

\item{stat}{The statistical transformation to use on the data for this
layer, as a string.}

\item{position}{Position adjustment, either as a string, or the result of
a call to a position adjustment function.}

\item{na.rm}{a \code{boolean} indicating whether or not to remove NAs.
\code{na.rm = FALSE} by default.}

\item{show.legend}{logical. Should this layer be included in the legends?
\code{NA}, the default, includes if any aesthetics are mapped.
\code{FALSE} never includes, and \code{TRUE} always includes.}

\item{inherit.aes}{If \code{FALSE}, overrides the default aesthetics,
rather than combining with them. This is most useful for helper functions
that define both data and aesthetics and shouldn't inherit behaviour from
the default plot specification, e.g. \code{\link{borders}}.}

\item{pointerheight}{is a \code{numeric} indicating the height of lable, pointer lines
This height is specified as a faction of the viewport height,
and will usually not require adjustment.  The default value for this parameter
is 0.05.}

\item{angle}{is a \code{numeric} indicating the text label angle. Text is printed
at an angle to allow good readability and to reduce label collisions for dense
time lines.  This angle won't usually require adjustment and is set at 45 degrees
by default.}

\item{labelcolour}{is a \code{string} giving the label colour.  This is set to 'black' by
default.}

\item{n_max}{is a \code{numeric} giving the maximum number of labels to display.  This
reduces the number of label collisions in dense, timelime plots.  The labels to show
are chosen based on the \code{size} aestheic.  Setting \code{n_max} will result
in a maximum of \code{n_max} labels, ordered by the aesthetic \code{size}, being rendered.}

\item{fill}{a \code{string} indicating the label, fill colour.
\code{fill = 'black'} by default.}

\item{xmin}{is a \code{numeric} specifiying the minimum \code{x} value to consider.
\code{xmin = .Machine$double.xmin} by default.}

\item{xmax}{is a \code{numeric} specifiying the maximum \code{x} value to consider.
\code{xmax = .Machine$double.xmax} by default.}

\item{...}{a \code{...} indicates a list of additional parameters
used for a geom.  \code{geom_timeline_label} doesn't make use of these.}
}
\value{
a \code{ggplot2} object representing timeline labels.  This is intended to be
used with \link{geom_timeline}.
}
\description{
\code{geom_timeline_label} adds annotations to earthquake data
timelines produced with \link{geom_timeline}. This geom adds a vertical
line to each data point with a text annotation (e.g. the location of an
earthquake) attached atop each line.
\code{geom_timeline_label} provides an option to subset to \code{n_max} number
of earthquakes, where \code{n_max} selects the largest (by magnitude) earthquakes.
This geometry supports the following aesthetics:
\itemize{
\item \code{x} is the date of the earthquake and
\item \code{label} is the column name from which annotations will be obtained
}
}
\examples{
library(quake     )
library(magrittr  )
library(data.table)
library(ggplot2   )

# Create dummy data

n         <- 100 # start with 100 data samples
countries <- c("USA", "China", "India", "South Africa")

dt <- data.table(
  date      = as.Date('2017-01-01') + seq(1, 365, 365/n),
  country   = factor(sample(countries, replace = TRUE, size = n)),
  intensity = runif(n)*10, # mag is somewhere beteen 0 and 10
  deaths    = runif(n)*12
)

head(dt) # show dummy data

start_date       <- as.Date('2017-07-01') # only show quakes from July 2017
end_date         <- as.Date('2017-07-30') # only show quakes from July 2017
no_labels_toshow <- 3 # show only three labels from highest intensity quakes

dt \%>\%
  ggplot() +
  geom_timeline_label(
    aes(
      label = as.character(country),
      x     = date     ,
      y     = country  ,
      size  = intensity
    ),
    n_max = no_labels_toshow,
    xmin  = start_date,
    xmax  = end_date
  ) +
  geom_timeline(
    aes(
      x    = date     ,
      y    = country  ,
      size = intensity,
      col  = deaths
    ),
    xmin  = start_date,
    xmax  = end_date,
    alpha = 0.8
  ) +
  labs(x = "DATE")                                     +
  scale_size_continuous (name = "Richter scale value") +
  scale_color_continuous(name = "# deaths"           ) +
  theme_classic()                                      +
  theme_timeline_with_y_axis_text
}

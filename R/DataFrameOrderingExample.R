
d <- data.frame(
  x = runif(10),
  y = 1:10
)


d[ order(-d["x"]), ][1:5, ]

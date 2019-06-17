# - \usepackage{tabu}
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
my_table_format <- function(tt){
  res <- format.data.frame(tt, digits = 4, nsmall = 4, justify = "none")
  return(res)
}

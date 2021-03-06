reqins_pkg <- function(pkg){
  x <- require(pkg, character.only = TRUE, quietly = TRUE)
  if(!x){
    install.packages(pkg)
    x <- require(pkg, character.only = TRUE, quietly = TRUE)
  }
  x
}

# packages
# x <- lapply(c("knitr", "kableExtra", "ape"), library, character.only = TRUE)

pkgs <- c("microbenchmark", "drake", "usethis", "datelife", "devtools", "knitr",
          "kableExtra", "ape", "phytools", "plotrix", "ggplot2", "gplots", "phylocomr")
x <- lapply(pkgs, reqins_pkg)
if(!all(unlist(lapply(x, is.null)))){
  print("Some packages could not be loaded")
}
# load_all("~/Desktop/datelife/")
# install_github("LunaSare/phunding")

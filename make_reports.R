source("R/global_packages.R")
pkgconfig::set_config("drake::strings_in_dots" = "literals")
knitr::opts_knit$set(root.dir = "docs")
knitr::opts_knit$set(base.dir = "docs")
getwd()
source("R/global_functions.R")
source("R/plan.R")

make(Cetacea)

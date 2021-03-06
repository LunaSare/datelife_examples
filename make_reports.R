
setwd("/Users/luna/datelife_examples")
source("R/global_packages.R")
pkgconfig::set_config("drake::strings_in_dots" = "literals")
knitr::opts_knit$set(root.dir = "docs")
knitr::opts_knit$set(base.dir = "docs")
source("R/global_functions.R")
source("R/functions_plotting.R")
source("R/functions_plotting2.R")
source("R/functions_tables.R")
source("R/multi2di_test.R")
source("R/functions_plotting_1.R")
source("R/functions_plotting3.R")
source("R/functions_plotting4.R")
source("R/functions_plotting5.R")
source("R/functions_plotting6.R")
source("R/functions_plotting_data.R")
source("R/functions_data.R")
source("R/plan_query.R")
source("R/plan_summ.R")
source("R/plan_summ2.R")
# source("R/plan_sim.R")
source("R/plan_data.R") # self validation tests
source("R/plan_data2.R") # cross validation tests
source("R/plan_sim.R") # using each chronogram in phylo all to date an otol topology

source("R/plan_report.R")

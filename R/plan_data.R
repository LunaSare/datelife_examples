
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
loadd(tax_phyloallall)
loadd(tax_datedotolall)
loadd(tax_otolall)
loadd(tax_dqall)
# if(all(is.na(tax_datedotolall))){
#   tax_datedotolall <- lapply(seq(tax_datedotolall), function(i)
#     ape::compute.brlen(tax_otolall[[i]]))
# }
plan_data <- drake_plan(
  tax_allcalall = lapply(tax_phyloallall, get_all_calibrations),
  tax_allcal_datedotolall = lapply(seq(tax_datedotolall), function(i)
    suppressMessages(suppressWarnings(use_all_calibrations(tax_datedotolall[[i]], tax_allcalall[[i]])))),
  tax_eachcalall = lapply(seq(tax_phyloallall), function(i)
                        lapply(tax_phyloallall[[i]], get_all_calibrations)),
  tax_eachcal_datedotolall = lapply(seq(tax_datedotolall), function(i)
                        use_each_cal(tree = tax_datedotolall[[i]], tax_eachcalall[[i]])),

  # use_all_calibrations(phy = tax_datedotolall[[i]], eachcal[[1]])
  # sapply(tax_eachcalall, function(x) sapply(x, class))
  # sapply(tax_eachcalall, length)
  tax_crossvalall = lapply(seq(tax_phyloallall), function(i)
                        use_eachcal_crossval(trees = tax_phyloallall[[i]], eachcal = tax_eachcalall[[i]]))
  # this was just to chck that it was the same with our without branch lengths as input.
  # it is the same output so we are not running it again
  # tax_phyloall_wobrlenall = lapply(tax_phyloallall, rm_brlen.multiPhylo),
  # tax_crossval2all = lapply(seq(tax_phyloall_wobrlenall), function(i)
  #                       use_eachcal_crossval(trees = tax_phyloall_wobrlenall[[i]], eachcal = tax_eachcalall[[i]]))
)
make(plan_data)

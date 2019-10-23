# self validation tests
loadd(tax_phyloallall)
loadd(tax_datedotolall)
loadd(tax_otolall)
loadd(tax_dqall)
# if(all(is.na(tax_datedotolall))){
#   tax_datedotolall <- lapply(seq(tax_datedotolall), function(i)
#     ape::compute.brlen(tax_otolall[[i]]))
# }
plan_data <- drake_plan(
  # tax_allcal_datedotolall = lapply(seq(tax_datedotolall), function(i)
  #   suppressMessages(suppressWarnings(use_all_calibrations(tax_datedotolall[[i]], tax_allcalall[[i]])))),
  tax_selfcalall = lapply(seq(tax_phyloallall), function(i)
                        lapply(tax_phyloallall[[i]], get_all_calibrations)),
  # tax_eachcal_datedotolall = lapply(seq(tax_datedotolall), function(i)
  #                       use_each_cal(tree = tax_datedotolall[[i]], tax_selfcalall[[i]])),

  # use_all_calibrations(phy = tax_datedotolall[[i]], eachcal[[1]])
  # sapply(tax_selfcalall, function(x) sapply(x, class))
  # sapply(tax_selfcalall, length)
  # tax_selfvalall errored with: Error in write.pathd8(phy, calibrations, base) :
  # Some calibrations not encountered in tree
  tax_selfvalall = lapply(seq(tax_phyloallall), function(i){
      print(taxa[i])
      use_eachcal_crossval(trees = tax_phyloallall[[i]], eachcal = tax_selfcalall[[i]])
  })
  # this was just to check that it was the same with our without branch lengths as input.
  # it is the same output so we are not running it again
  # tax_phyloall_wobrlenall = lapply(tax_phyloallall, rm_brlen.multiPhylo),
  # tax_crossval2all = lapply(seq(tax_phyloall_wobrlenall), function(i)
  #                       use_eachcal_crossval(trees = tax_phyloall_wobrlenall[[i]], eachcal = tax_selfcalall[[i]]))
)
make(plan_data)

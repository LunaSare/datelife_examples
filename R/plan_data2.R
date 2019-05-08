plan_data2 <- drake_plan(
  tax_allcalall = lapply(tax_phyloallall, get_all_calibrations),
  tax_othercalall = lapply(tax_phyloallall, get_othercals),
  # length(tax_othercalall)
  # sapply(tax_othercalall, length)
  # sapply(tax_phyloallall, length)
  # tax_othercalall[[1]][1]
  crossval1 = mapply(use_othercals1, tax_phyloallall, tax_othercalall),
  crossval2 = mapply(use_othercals2, tax_phyloallall, tax_othercalall),
  crossval3 = mapply(use_othercals2, tax_phyloallall, tax_othercalall),
  tax_allcal_datedotolall = lapply(seq(tax_datedotolall), function(i)
    suppressMessages(suppressWarnings(use_all_calibrations(tax_datedotolall[[i]], tax_allcalall[[i]])))),
  tax_eachcalall = lapply(seq(tax_phyloallall), function(i)
                        lapply(tax_phyloallall[[i]], get_all_calibrations)),
  tax_eachcal_datedotolall = lapply(seq(tax_datedotolall), function(i)
                        use_each_cal(tree = tax_datedotolall[[i]], tax_eachcalall[[i]])),
  tax_crossvalall = lapply(seq(tax_phyloallall), function(i){
      print(taxa[i])
      use_eachcal_crossval(trees = tax_phyloallall[[i]], eachcal = tax_eachcalall[[i]])
})

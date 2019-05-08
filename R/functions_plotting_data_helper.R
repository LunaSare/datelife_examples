crossval <- use_othercals3(tax_phyloallall[[1]], tax_othercalall[[1]])
names(crossval) <- names(tax_phyloall)
tax_summary <- tax_summaryall[[1]]
tax_phyloall <- tax_phyloallall[[1]]
match(names(crossval)[which(!sapply(crossval, is.null))], studiesall)
mltt.plot(crossval[names(tax_phyloallall[[1]]) %in% studiesall[5]])
for(i in 1:2){
  plot(crossval[names(tax_phyloallall[[1]]) %in% studiesall[5]][i], cex = 0.75)
  ape::axisPhylo()
}
tax_othercalall[[1]][[3]][-6]
tax_phyloallall[[1]][[2]]$edge.length
for(i in 1:2){
  plot(tax_phyloallall[[1]][names(tax_phyloallall[[1]]) %in% studiesall[5]][i], cex = 0.75)
  ape::axisPhylo()
}
plot(tax_phyloallall[[1]][names(tax_phyloallall[[1]]) %in% studiesall[5]])
make_lttplot_data1(taxon = taxa[1], crossval, tax_summary, tax_phyloall, filename = "LTTplot_data_test")

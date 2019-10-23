# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
loadd(tax_drall)
loadd(tax_sdm_phyloall)
loadd(tax_median_phyloall)
loadd(tax_sdm_matrixall)
loadd(tax_otolall)
loadd(tax_phyloallall)
# length(tax_sdm_phyloall)
# class(tax_sdm_phyloall) <- "multiPhylo"
# ape::is.ultrametric(tax_sdm_phyloall)
# sapply(tax_sdm_phyloall, "[", "clustering_method")
# names(tax_sdm_phyloall[[3]])
# plot(tax_sdm_phyloall, cex = 0.1)
plan_sim <- drake_plan(
  # tax_sdm_bladjall = lapply(seq(tax_sdm_phyloall), function(i)
  #   get_bladjtree(dated_tree = tax_sdm_phyloall[[i]], backbone = tax_otolall[[i]])),
  # tax_med_bladjall = lapply(seq(tax_median_phyloall), function(i)
  #   get_bladjtree(dated_tree = tax_median_phyloall[[i]]$phylo_median, backbone = tax_otolall[[i]]))
  tax_eachcalall = lapply(tax_phyloallall, function(x) get_all_calibrations(x, each = TRUE)),
  sim_otol_eachall = lapply(seq(tax_otolall), function(i) use_each_calibration(phy = tax_otolall[[i]], calibrations = tax_eachcalall[[i]])$phy)
)
make(plan_sim)
# loadd(tax_med_bladjall)
# tax_med_bladjall[[1]]
# loadd(tax_sdm_bladjall)

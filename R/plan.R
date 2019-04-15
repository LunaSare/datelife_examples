# utils::data(subset2_taxa)
# length(unique(subset2_taxa))

# taxaall <- c("Spheniscidae","Cetacea", "Fringilidae", "Hominidae", "Phyllostomidae", "Anolis", "Primates")
# spp_from_taxon <- c(rep(TRUE, length(taxaall)))
plan_query <- drake_plan(
    taxa = c("Spheniscidae","Cetacea", "Fringilidae", "Hominidae", "Phyllostomidae", "Anolis", "Primates"),
    tax_dqall = lapply(seq_along(taxa), function(i)
                make_datelife_query(taxa[i], get_spp_from_taxon = TRUE)),
    tax_drall = lapply(tax_dqall, get_datelife_result),
    # lapply(tax_drall, length)
    tax_summall = lapply(seq(length(taxa)), function(i)
                      get_taxon_summary(datelife_query = tax_dqall[[i]],
                                        datelife_result = tax_drall[[i]])),
    tax_phyloallall = lapply(seq(length(taxa)), function(i)
                      summarize_datelife_result(datelife_query = tax_dqall[[i]],
                                                datelife_result = tax_drall[[i]],
                                                summary_format = "phylo_all",
                                                taxon_summary = "none")),
    tax_datedotolall = lapply(seq(length(taxa)), function(i)
                        get_dated_otol_induced_subtree(input = tax_dqall[[i]],
                          ott_id = tax_dqall[[i]]$ott_ids)),
    # length(tax_dqall)
    # get_treefromtax(tax_dq = tax_dqall[[5]]) # seg fault
    tax_treefromtaxall = lapply(tax_dqall, get_treefromtax),
    # do we need to resolve tax tree to compute brlens? No. So we're plotting them unresolved with compute.brlens inside the plotting functions
    tax_otolall = lapply(seq(length(taxa)), function(i)
                        get_otol_synthetic_tree(input = tax_dqall[[i]]))
)
make(plan_query)
# sapply(tax_datedotolall[[5]], is.binary) none of them are binary and yet they are fully plotted with plotSimmap
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
loadd(taxa)
loadd(tax_drall)
loadd(tax_dqall)
plan_summ <- drake_plan(
  tax_bestgroveall = lapply(seq(length(taxa)), function(i)
                      get_best_grove(datelife_result = tax_drall[[i]])),
  tax_median_matrixall = lapply(seq(length(taxa)), function(i)
                      datelife_result_median_matrix(tax_bestgroveall[[i]]$best_grove)),
  tax_median_phyclusterall = lapply(tax_median_matrixall, cluster_patristicmatrix),
  tax_median_phyloall = lapply(seq(length(taxa)), function(i)
                      summarize_datelife_result(
                        datelife_query = tax_dqall[[i]],
                        datelife_result = tax_drall[[i]],
                        summary_format = "phylo_median",
                        taxon_summary = "summary")),
  tax_sdm_matrixall = lapply(seq(length(taxa)), function(i)
                      get_sdm_matrix(tax_bestgroveall[[i]]$best_grove)),
  tax_sdm_phyclusterall = lapply(tax_sdm_matrixall, cluster_patristicmatrix),
  tax_sdm_phyloall = lapply(seq(length(taxa)), function(i)
                      summarize_datelife_result(
                        datelife_query = tax_dqall[[i]],
                        datelife_result = tax_drall[[i]],
                        summary_format = "phylo_sdm",
                        taxon_summary = "none"))
)
make(plan_summ)
loadd(tax_sdm_phyclusterall)
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
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
loadd(tax_drall)
loadd(tax_sdm_phyloall)
loadd(tax_median_phyloall)
loadd(tax_sdm_matrixall)
loadd(tax_otolall)
# length(tax_sdm_phyloall)
# class(tax_sdm_phyloall) <- "multiPhylo"
# ape::is.ultrametric(tax_sdm_phyloall)
# sapply(tax_sdm_phyloall, "[", "clustering_method")
# names(tax_sdm_phyloall[[3]])
# plot(tax_sdm_phyloall, cex = 0.1)
plan_sim <- drake_plan(
  tax_sdm_bladjall = lapply(seq(tax_sdm_phyloall), function(i)
    get_bladjtree(dated_tree = tax_sdm_phyloall[[i]], backbone = tax_otolall[[i]])),
  tax_med_bladjall = lapply(seq(tax_median_phyloall), function(i)
    get_bladjtree(dated_tree = tax_median_phyloall[[i]]$phylo_median, backbone = tax_otolall[[i]]))
)
make(plan_sim)
# loadd(tax_med_bladjall)
# tax_med_bladjall[[1]]
# loadd(tax_sdm_bladjall)

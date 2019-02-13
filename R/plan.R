taxaall <- c("Spheniscidae","Cetacea", "Fringilidae", "Hominidae", "Phyllostomidae", "Anolis", "Primates")
plan_query <- drake_plan(
    taxa = taxaall,
    tax_dqall = lapply(taxa, make_datelife_query, get_spp_from_taxon = TRUE),
    tax_drall = lapply(tax_dqall, get_datelife_result),
    # lapply(tax_drall, length)
    tax_summall = lapply(seq(length(taxa)), function(i)
                      get_taxon_summary(datelife_query = tax_dqall[[i]],
                                        datelife_result = tax_drall[[i]]))
)
loadd(taxa)
loadd(tax_dqall)
loadd(tax_drall)
plan_summ <- drake_plan(
    tax_phylomedall = lapply(seq(length(taxa)), function(i)
                      summarize_datelife_result(datelife_query = tax_dqall[[i]],
                                                datelife_result = tax_drall[[i]],
                                                summary_format = "phylo_median",
                                                taxon_summary = "summary")),
    tax_sdmmatrixall = lapply(tax_drall, get_sdm_matrix),
    tax_phyclusterall = lapply(tax_sdmmatrixall, cluster_patristicmatrix),
    tax_sdmall = lapply(seq(length(taxa)), function(i)
                      summarize_datelife_result(datelife_query = tax_dqall[[i]],
                                                datelife_result = tax_drall[[i]],
                                                summary_format = "phylo_sdm",
                                                taxon_summary = "none")),
    tax_phyloallall = lapply(seq(length(taxa)), function(i)
                      summarize_datelife_result(datelife_query = tax_dqall[[i]],
                                                datelife_result = tax_drall[[i]],
                                                summary_format = "phylo_all",
                                                taxon_summary = "none")),
    tax_datedotolall = lapply(seq(length(taxa)), function(i)
                        get_dated_otol_induced_subtree(input = tax_dqall[[i]],
                          ott_id = tax_dqall[[i]]$ott_ids)),
    # length(tax_dqall)
    # get_treefromtax(tax_dq = tax_dqall[[5]]) # still seg fault when using CoL
    tax_treefromtaxall = lapply(tax_dqall, get_treefromtax, source = "NCBI"),
    # do we need to resolve tax tree to compute brlens? No. So we're plotting them unresolved with compute.brlens inside the plotting functions
    tax_otolall = lapply(seq(length(taxa)), function(i)
                        get_otol_synthetic_tree(input = tax_dqall[[i]]))
)
make(plan_summ)
# sapply(tax_datedotolall[[5]], is.binary) none of them are binary and yet they are fully plotted with plotSimmap
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
loadd(tax_phyloallall)
loadd(tax_datedotolall)
loadd(tax_otolall)
loadd(tax_dqall)
taxon_names <- unname(tax_dqall[[5]]$cleaned_names)
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
  # we absolutely need a dated tree for use_all_calibrations
  # tax_phyloall_wobrlenall = lapply(tax_phyloallall, rm_brlen.multiPhylo)
  # tax_crossval2all = lapply(seq(tax_phyloall_wobrlenall), function(i)
  #                       use_eachcal_crossval(trees = tax_phyloall_wobrlenall[[i]], eachcal = tax_eachcalall[[i]]))
)
make(plan_data)
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
loadd(tax_drall)
loadd(tax_sdmall)
loadd(tax_phylomedall)
loadd(tax_sdmmatrixall)
tax_sdmmatrixall[[4]]
# length(tax_sdmall)
# class(tax_sdmall) <- "multiPhylo"
# ape::is.ultrametric(tax_sdmall)
# sapply(tax_sdmall, "[", "clustering_method")
# names(tax_sdmall[[3]])
# plot(tax_sdmall, cex = 0.1)
plan_sim <- drake_plan(
  tax_sdm_bladjall = lapply(seq(tax_sdmall), function(i)
    get_bladjtree(dated_tree = tax_sdmall[[i]], backbone = tax_otolall[[i]])),
  tax_med_bladjall = lapply(seq(tax_phylomedall), function(i)
    get_bladjtree(dated_tree = tax_phylomedall[[i]]$phylo_median, backbone = tax_otolall[[i]]))
)
make(plan_sim)

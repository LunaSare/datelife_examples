taxa <- c("Cetacea", "Fringilidae", "Hominidae", "Phyllostomidae", "Anolis")
plan_data <- drake_plan(
    taxa = c("Cetacea", "Fringilidae", "Hominidae", "Phyllostomidae", "Anolis"),
    tax_dqall = lapply(taxa, make_datelife_query, get_spp_from_taxon = TRUE),
    tax_drall = lapply(tax_dqall, get_datelife_result),
    tax_summall = lapply(seq(length(taxa)), function(i)
                      get_taxon_summary(datelife_query = tax_dqall[[i]],
                                        datelife_result = tax_drall[[i]])),
    tax_phylomedall = lapply(seq(length(taxa)), function(i)
                      summarize_datelife_result(datelife_query = tax_dqall[[i]],
                                                datelife_result = tax_drall[[i]],
                                                summary_format = "phylo_median",
                                                taxon_summary = "summary")),
    tax_sdmall = lapply(seq(length(taxa)), function(i)
                      summarize_datelife_result(datelife_query = tax_dqall[[i]],
                                                datelife_result = tax_drall[[i]],
                                                summary_format = "phylo_sdm",
                                                taxon_summary = "none")),
    tax_datedotolall = lapply(seq(length(taxa)), function(i)
                        get_dated_otol_induced_subtree(input = tax_dqall[[i]],
                          ott_id = tax_dqall[[i]]$ott_ids)),
    tax_treefromtaxall = lapply(seq(length(taxa)), function(i)
                        tree_from_taxonomy(taxa = tax_dqall[[i]]$cleaned_names, sources = "NCBI")),
    # tree_from_taxonomy(taxa = tax_dqall[[i]]$cleaned_names, sources = "Open Tree of Life Reference Taxonomy")
    # using sources = "Open Tree of Life Reference Taxonomy" gives an error, using NCBI for now
    # taxonomy trees are not well resolved at all, so its not even possible to plot them sometimes
    # do we need to resolve them to compute brlens?
    # tax_treefromtax_datesall = lapply(seq(length(taxa)), function(i)
    #                 compute_ape_brlens(tax_treefromtaxall[[i]]$phy))
    tax_otolall = lapply(seq(length(taxa)), function(i)
                        get_otol_synthetic_tree(input = tax_dqall[[i]]))
    # tax_otol_datesall = lapply(tax_otolall, compute_ape_brlens)
)
summarize_datelife_result(datelife_query = tax_dqall[[i]],
                          datelife_result = tax_drall[[i]],
                          summary_format = "phylo_sdm",
                          taxon_summary = "none")
make(plan_data)
# sapply(tax_datedotolall[[5]], is.binary) none of them are binary and yet they are fully plotted with plotSimmap

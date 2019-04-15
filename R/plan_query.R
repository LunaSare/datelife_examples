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

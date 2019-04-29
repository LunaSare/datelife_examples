# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
loadd(taxa)
loadd(tax_drall)
loadd(tax_dqall)
plan_summ <- drake_plan(
  tax_bestgroveall = lapply(seq(length(taxa)), function(i)
        get_best_grove(datelife_result = tax_drall[[i]])),
  tax_variance_matrixall = lapply(seq(length(taxa)), function(i)
        datelife_result_variance_matrix(tax_bestgroveall[[i]]$best_grove)),
  tax_median_matrixall = lapply(seq(length(taxa)), function(i)
        datelife_result_median_matrix(tax_bestgroveall[[i]]$best_grove)),
  tax_median_phyclusterall = lapply(seq(length(taxa)), function(i)
        cluster_patristicmatrix(tax_median_matrixall[[i]], tax_variance_matrixall[[i]])),
  tax_median_phyloall = lapply(seq(length(taxa)), function(i)
        summarize_datelife_result(datelife_query = tax_dqall[[i]],
        datelife_result = tax_drall[[i]], summary_format = "phylo_median",
        taxon_summary = "summary")),
  tax_sdm_matrixall = lapply(seq(length(taxa)), function(i)
        get_sdm_matrix(tax_bestgroveall[[i]]$best_grove)),
  tax_sdm_phyclusterall = lapply(seq(length(taxa)), function(i)
        cluster_patristicmatrix(tax_sdm_matrixall[[i]], tax_variance_matrixall[[i]])),
  tax_sdm_phyloall = lapply(seq(length(taxa)), function(i)
        summarize_datelife_result(datelife_query = tax_dqall[[i]],
        datelife_result = tax_drall[[i]], summary_format = "phylo_sdm",
        taxon_summary = "none")),
  sdm_summtreesall = lapply(seq(length(taxa)), function(i)
        get_summ_trees(tax_sdm_matrixall[[i]])),
  median_summtreesall = lapply(seq(length(taxa)), function(i)
        get_summ_trees(tax_median_matrixall[[i]]))
)
make(plan_summ)
# loadd(tax_sdm_phyclusterall)
xx <- ape::mvrs(tax_median_matrixall[[6]], tax_variance_matrixall[[6]])
xx$edge.length

# - \usepackage{tabu}
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
my_table_format <- function(tt){
  res <- format.data.frame(tt, digits = 4, nsmall = 4, justify = "none")
  return(res)
}
library(microbenchmark)
loadd(tax_allcal)
loadd(taxon)
loadd(tax_dq)
loadd(tax_dr)
loadd(tax_summ)
loadd(tax_phyloall)
phyloall_success <- ape::is.ultrametric(tax_phyloall, option = 2)
loadd(tax_median_phylo)
loadd(tax_sdm_phylo)
loadd(tax_sdm_matrix)
loadd(tax_median_matrix)
loadd(tax_datedotol)
loadd(tax_allcal_datedotol)
loadd(tax_otol)
loadd(tax_treefromtax)
loadd(tax_phyloall)
loadd(tax_eachcal_datedotol)
# loadd(tax_crossval)
loadd(tax_phycluster)
# loadd(tax_crossval2)
loadd(tax_summary)
loadd(tax_bestgrove)
fig_lttplot_phyloall <- "Fig. 1"
fig_lttplot_median <- "Fig. 2"
fig_lttplot_median_and_sdm <- "Fig. 3"
fig_lttplot_bladj <- "Fig. 4"
# fig_node_age_dist <- "Fig. "
figcap2 <- paste(taxon, "Species Tree from Taxonomy. This tree was obtained with `tree_from_taxonomy()` function.")
table_chronograms <- "Table 1"
table_crossval <- "Table 2"
fig_lttplot_sdm <- "Fig. 5"
negs_list <- list(SDM = which(tax_sdm_matrix < 0),
                 Median = which(tax_median_matrix < 0))
tax_summ_matrix <- list(tax_sdm_matrix, tax_median_matrix)
negs_sdm <- c()
if(length(negs_list$SDM) > 0){
  xx <- rownames(tax_sdm_matrix)[ceiling(negs_list$SDM/nrow(tax_sdm_matrix))]
  negs_sdm <- paste0("In this case, the SDM summary matrix has some negative values in the following taxa: *", paste(xx, collapse = "*, *"), "*. ")
} else {
  negs_sdm <- paste0("But, the SDM summary matrix of this taxon has no negative values.")
}
if(all(phyloall_success)){
  ultrametricity <- "All source chronograms are fully ultrametric"
} else {
  ultrametricity <- "Not all source chronograms are fully ultrametric. This cant't be right, CHECK THIS!!"
}
# Error producing PDF.
# ! Undefined control sequence.
# l.124 \toprule
# this occurs when the needed latex package is not specified in the yaml ^^

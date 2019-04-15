# I. Query
whale_query <- make_datelife_query("cetacea", get_spp_from_taxon = TRUE)
names(whale_query)
whale_query$cleaned_names

# make lists with valid ott names only: clean valid names from API
get_ott_children(input = "cetacea", ott_rank = "genus")
get_ott_clade(input = "cetacea", ott_rank = "order")
# get_ott_lineage(input = "cetacea")

# get the actual data:
whale_result <- get_datelife_result(whale_query)

# II. Summarize results of search
sdm_phylo <- summarize_datelife_result(datelife_result = whale_result,
                                      datelife_query = whale_query,
                                      summary_format = "phylo_sdm")
names(sdm_phylo)
best_grove <- get_best_grove(whale_result)$best_grove
sdm_matrix <- get_sdm_matrix(best_grove)
all_trees <- get_summ_trees(sdm_matrix)

for(i in 1:3){
  plot(all_trees[[i]], cex = 0.5)
  HPDbars(phy = all_trees[[i]], label = "calibrations", nodes = all_trees[[i]]$calibrations_MRCA)
  ape::axisPhylo()
}

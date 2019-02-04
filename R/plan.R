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
    tax_datedotolall = lapply(seq(length(taxa)), function(i)
                        get_dated_otol_induced_subtree(input = tax_dqall[[i]],
                          ott_id = tax_dqall[[i]]$ott_ids)),
    tax_treefromtaxall = lapply(seq(length(taxa)), function(i)
                        tree_from_taxonomy(taxa = tax_dqall[[i]]$cleaned_names, sources = "NCBI")),
# tree_from_taxonomy(taxa = tax_dqall[[i]]$cleaned_names, sources = "Open Tree of Life Reference Taxonomy")
    tax_otolall = lapply(seq(length(taxa)), function(i)
                        get_otol_synthetic_tree(input = tax_dqall[[i]])),
    tax_otol_datesall = lapply(tax_otolall, compute_ape_brlens)
    # taxonomy trees are not well resolved at all, so its not evven possible to plot them sometimes
    # tax_taxonomy_datesall = lapply(seq(length(taxa)), function(i)
    #                     compute_ape_brlens(tax_treefromtaxall[[i]]$phy))
    # compute_ape_brlens(tax_treefromtaxall[[5]]$phy)
    
    # title1all = paste0(taxa, " Species Presence across chronograms in DateLife Data Base")
)
make(plan_data)

loadd(taxa)
loadd(tax_dqall)
loadd(tax_drall)
loadd(tax_summall)
loadd(tax_phylomedall)
loadd(tax_datedotolall)
# loadd(title1all)
loadd(tax_otolall)
loadd(tax_treefromtaxall)
for(i in seq(taxa)){
    print(taxa[i])
    plan_report <- drake_plan(
    	taxon = taxa[i],
    	tax_dq = tax_dqall[[i]],
    	tax_dr = tax_drall[[i]],
    	tax_summ = tax_summall[[i]],
      tax_phyloall = suppressMessages(summarize_datelife_result(datelife_query = tax_dq, datelife_result = tax_dr, summary_format = "phylo_all")),
      tax_phylomedian = tax_phylomedall[[i]],
    	tax_datedotol = tax_datedotolall[[i]],
    	plot1 = make_plot_global(tax_datedotolall[[i]], title = NULL, taxa[i], tax_summall[[i]], omi3 = 0),
    	reportname = paste0("report_", taxa[i]),
    	mdname = paste0("docs/", reportname, ".md"),
    	report = make_report(mdname),
      summary_pdf_report = render_pdf(reportname, "docs", report)
    )
    assign(value = plan_report, x = taxa[i])
    make(get(taxa[i]))
    # make(Cetacea)
}

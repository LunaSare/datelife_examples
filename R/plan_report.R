loadd(taxa)
loadd(tax_dqall)
loadd(tax_drall)
loadd(tax_summall)
loadd(tax_phyloallall)
# loadd(tax_datedotolall)
loadd(tax_treefromtaxall)  # it errors only with CoL now (segfault) length(tax_treefromtaxall)
loadd(tax_otolall)
loadd(tax_allcalall)
loadd(tax_allcal_datedotolall)
loadd(tax_crossvalall)
# loadd(tax_crossval2all)
loadd(tax_eachcalall)
loadd(tax_eachcal_datedotolall)
# loadd(tax_med_bladjall)
# loadd(tax_sdm_bladjall)
loadd(tax_median_matrixall)
loadd(tax_median_phyclusterall)
loadd(tax_median_phyloall)
loadd(tax_sdm_matrixall)
loadd(tax_sdm_phyclusterall)
loadd(tax_sdm_phyloall)
loadd(tax_bestgroveall)
loadd(sdm_summtreesall)
loadd(median_summtreesall)
loadd(tax_datedotolall)
loadd(tax_summaryall)
for(i in seq(taxa)){
    print(taxa[i])
    plan_report <- drake_plan(
    	taxon = taxa[i], # this is just useful for rendering the report
        tax_allcal = tax_allcalall[[i]],
        # node_age_dist = make_fig_node_age_dist(tax_allcal)
    	tax_dq = tax_dqall[[i]],
    	tax_dr = tax_drall[[i]],
    	tax_summ = tax_summall[[i]],
    	tax_phyloall = tax_phyloallall[[i]],
        tax_summary = tax_summaryall[[i]],
        tax_bestgrove = tax_bestgroveall[[i]],
        # tax_phyloall = suppressMessages(summarize_datelife_result(datelife_query = tax_dq, datelife_result = tax_dr, summary_format = "phylo_all")),
        tax_median_phylo = tax_median_phyloall[[i]], # this is used inside report
        tax_sdm_phylo = tax_sdm_phyloall[[i]], # this is used inside report
    	tax_sdm_matrix = tax_sdm_matrixall[[i]],
    	negs_sdm = which(tax_sdm_matrix < 0),
    	tax_median_matrix = tax_median_matrixall[[i]],
    	tax_datedotol = tax_datedotolall[[i]],
        tax_otol = tax_otolall[[i]],
        tax_treefromtax = tax_treefromtaxall[[i]],
    	plot1 = make_plot_global(tree = tax_datedotolall[[i]], title = NULL, taxon = taxa[i],
            tax_summ = tax_summall[[i]], omi3 = 0, filename = "datedotol"),
        # plot2 = make_plot_global(tree = tax_treefromtaxall[[i]]$phy, title = NULL, taxon = taxa[i], tax_summall[[i]], omi3 = 0, filename = "treefromtax"),
        plot3 = make_plot_global(tree = tax_otolall[[i]], title = NULL, taxon = taxa[i],
            tax_summall[[i]], omi3 = 0, filename = "otol"),
    	tax_allcal_datedotol = tax_allcal_datedotolall[[i]],
    	tax_eachcal_datedotol = tax_eachcal_datedotolall[[i]],
    	tax_crossval = tax_crossvalall[[i]],
    	keep_median = !is.na(tax_median_phyclusterall[[i]]),
        keep_sdm = !is.na(tax_sdm_phyclusterall[[i]]),
    	lttplot_phyloall = make_lttplot_phyloall(taxa[i], tax_phyloall, tax_summary),
        # lttplot_phyloall2 = make_lttplot_summ2(taxa[i], tax_phyloall, tax_summary,
        #     filename = "make_lttplot_summ2_test", tax_phyloall_color = "other",
        #     tax_phycluster_median = tax_median_phyclusterall[[i]][keep_median],
        #     tax_phycluster_sdm = tax_sdm_phyclusterall[[i]][keep_sdm], add_legend = TRUE),
        lttplot_clustmedian = make_lttplot_summ3(taxa[i], tax_phyloall, tax_summary,
            filename = "lttplot_cluster_median", tax_phyloall_color = "other",
            tax_phycluster = tax_median_phyclusterall[[i]][keep_median], add_legend = TRUE),
        lttplot_clustsdm = make_lttplot_summ3(taxa[i], tax_phyloall, tax_summary,
            filename = "lttplot_cluster_sdm", tax_phyloall_color = "other",
            tax_phycluster = tax_sdm_phyclusterall[[i]][keep_sdm], add_legend = TRUE),
        lttplot_clust_both = make_lttplot_clusters(taxon, tax_phyloall, tax_summary,
                tax_median_phyclusterall[[i]][keep_median], tax_sdm_phyclusterall[[i]][keep_sdm]),
       lttplot_summchrono = make_lttplot_summchrono(taxa[i], tax_phyloall, tax_summary,
           sdm_summtreesall[[i]], median_summtreesall[[i]]),
      crossval_bladj = crossval_bladjall[[i]],
      lttplot_crossval3 = make_lttplot_data1(taxa[i], crossval_bladj, tax_summary, tax_phyloall,
        dating_method = "BLADJ", filename = "LTTplot_crossval_bladj"),
    	reportname = paste0(taxa[i], "_report"),
    	mdname = paste0("docs/", reportname, ".md"),
    	report = make_report(mdname),
        summary_pdf_report = render_pdf(reportname, "docs", report)
    )
    assign(value = plan_report, x = taxa[i])
    make(get(taxa[i]))
    # make(Cetacea)
}

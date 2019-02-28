loadd(taxa)
loadd(tax_dqall)
loadd(tax_drall)
loadd(tax_summall)
loadd(tax_phyloallall)
loadd(tax_datedotolall)
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

for(i in seq(taxa)){
    print(taxa[i])
    plan_report <- drake_plan(
    	taxon = taxa[i], # this is just useful for rendering the report
    	tax_dq = tax_dqall[[i]],
    	tax_dr = tax_drall[[i]],
    	tax_summ = tax_summall[[i]],
    	tax_phyloall = tax_phyloallall[[i]],
      # tax_phyloall = suppressMessages(summarize_datelife_result(datelife_query = tax_dq, datelife_result = tax_dr, summary_format = "phylo_all")),
      tax_median_phylo = tax_median_phyloall[[i]]$phylo_median, # this is used inside report
    	tax_sdm_matrix = tax_sdm_matrixall[[i]],
    	negs_sdm = which(tax_sdm_matrix < 0),
    	tax_median_matrix = tax_median_matrixall[[i]],
    	tax_datedotol = tax_datedotolall[[i]],
      tax_otol = tax_otolall[[i]],
      tax_treefromtax = tax_treefromtaxall[[i]],
    	plot1 = make_plot_global(tree = tax_datedotolall[[i]], title = NULL, taxon = taxa[i], tax_summ = tax_summall[[i]], omi3 = 0, filename = "datedotol"),
        # plot2 = make_plot_global(tree = tax_treefromtaxall[[i]]$phy, title = NULL, taxon = taxa[i], tax_summall[[i]], omi3 = 0, filename = "treefromtax"),
      plot3 = make_plot_global(tree = tax_otolall[[i]], title = NULL, taxon = taxa[i], tax_summall[[i]], omi3 = 0, filename = "otol"),
        # plot1 = make_plot1(tree = tax_datedotolall[[i]], title = NULL, taxa[i], tax_summall[[i]], omi3 = 0, filename = "datedotol"),
        # plot2 = make_plot1(tree = tax_treefromtaxall[[i]]$phy, title = NULL, taxa[i], tax_summall[[i]], omi3 = 0, filename = "treefromtax"),
        # plot3 = make_plot1(tree = tax_otolall[[i]], title = NULL, taxa[i], tax_summall[[i]], omi3 = 0, filename = "otol"),
    	tax_allcal_datedotol = tax_allcal_datedotolall[[i]],
    	tax_eachcal_datedotol = tax_eachcal_datedotolall[[i]],
    	tax_crossval = tax_crossvalall[[i]],
    	# tax_crossval2 = tax_crossval2all[[i]],
    	# tax_sdm_bladj = tax_sdm_bladjall[[i]],
    	# tax_med_bladj = tax_med_bladjall[[i]],
    	lttplot_phyloall = make_lttplot_phyloall(taxa[i], tax_phyloall, tax_datedotol, tax_median_phyloall[[i]]),
    	lttplot_sdm = make_lttplot_sdm(taxa[i], tax_phyloall, tax_datedotol, tax_phycluster = tax_phycluster,
    	                               negs = negs_sdm, sdm_matrix = tax_sdm_matrix),
    	lttplot_sdm2phy = make_lttplot_sdm(taxa[i], tax_phyloall, tax_datedotol, tax_phylomed = tax_median_phyloall[[i]]$phylo_median,
    	                                   tax_phycluster = tax_phycluster, sdm2phylo = tax_sdm_phyloall[[i]], filename = "LTTplot_sdm2phy"),
    	lttplot_summ_med = make_lttplot_summ(taxa[i], tax_phyloall, tax_datedotol, 
    	                                   tax_phylosummary = tax_median_phyloall[[i]]$phylo_median,
    	                                   tax_phycluster = tax_median_phyclusterall[[i]], 
    	                                   legend_phylosumm = "Median", 
    	                                   col_phylosummary = "orange",
    	                                   summ_matrix = tax_median_matrixall[[i]]),
    	lttplot_summ_sdm = make_lttplot_summ(taxa[i], tax_phyloall, tax_datedotol, 
    	                                   tax_phylosummary = tax_sdm_phyloall[[i]],
    	                                   tax_phycluster = tax_sdm_phyclusterall[[i]], 
    	                                   legend_phylosumm = "SDM", 
    	                                   col_phylosummary = "blue",
    	                                   summ_matrix = tax_sdm_matrixall[[i]]),
    	reportname = paste0(taxa[i], "_report"),
    	mdname = paste0("docs/", reportname, ".md"),
    	report = make_report(mdname),
        summary_pdf_report = render_pdf(reportname, "docs", report)
    )
    assign(value = plan_report, x = taxa[i])
    make(get(taxa[i]))
    # make(Cetacea)
}

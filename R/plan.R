plan_data <- drake_plan(
    taxa = c("Cetacea", "Fringilidae", "Hominidae"),
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
                          ott_id = tax_dqall[[i]]$ott_ids))
)
make(plan_data)
loadd(taxa)
loadd(tax_dqall)
loadd(tax_drall)
loadd(tax_summall)
loadd(tax_phylomedall)
loadd(tax_datedotolall)
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
    	reportname = paste0("report_", taxa[i]),
    	mdname = paste0("docs/", reportname, ".md"),
    	report = make_report(mdname),
      summary_pdf_report = render_pdf(reportname, "docs", report)
    )
    assign(value = plan_report, x = taxa[i])
    make(get(taxa[i]))
    # make(Cetacea)  
}

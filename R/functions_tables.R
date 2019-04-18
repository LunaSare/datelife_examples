make_table0 <- function(tax_dr, tax_summ, tax_dq, table_caption = ""){
    dd <- !duplicated(names(tax_dr)) # take only the first chronogram from the same publication
    # the most commoncase is that all chronograms in the same publication have the same species sampling
    # but there are cases in which this is not the case (e.g., De-Nova et al. 2018)
    # and there are several chronograms in the same publication that have different taxon sampling
    # a way to incorporate them would be putting the taxon presence of all source chronograms from the same publication in the same vector, separated by "\n"
    taxon_number <- sapply(seq(nrow(tax_summ$matrix))[dd], function(x) sum(tax_summ$matrix[x,]))
    xx <- table(names(tax_dr))
    table0 <- data.frame(var1 = paste0(seq(length(xx)), "."),
        var2 = names(xx), var3 = as.numeric(unname(xx)),
        var4 = paste0(taxon_number, "/", length(tax_dq$cleaned_names)))
    table0 <- dplyr::mutate(table0, var1 = cell_spec(var1, "latex", align = "r",
        bold = TRUE, italic = TRUE),
        var2 = cell_spec(var2, "latex", font_size = 8),
        var3 = cell_spec(var3, "latex", align = "c"),
        var4 = cell_spec(var4, "latex", align = "c"))
    t0 <- knitr::kable(table0, escape = FALSE, row.names = FALSE, format = "latex",
        booktabs = TRUE, caption = table_caption, linesep = "", longtable = TRUE)
    t0 <- gsub("var1", "   ", t0)
    t0 <- gsub("var2", "Citation", t0)
    t0 <- gsub("var3", "Source N", t0)
    t0 <- gsub("var4", "Taxon N", t0)
    kableExtra::kable_styling(kable_input = t0, latex_options = "hold_position") %>%
    column_spec(1, width = "0.4cm") %>%
    column_spec(2, width = "11cm") %>%
    column_spec(3, width = "1.5cm") %>%
    column_spec(4, width = "1.8cm") %>%
    # collapse_rows(columns = 3, latex_hline = "none", valign = "middle") %>%
    row_spec(0, bold = TRUE, align = "c", italic = TRUE, font_size = 9) %>%
    footnote(general = c("Source_N: Number of source chronograms reported in study.",
            "Taxon_N: Number of queried taxa found in source chronograms."),
            general_title = "") -> t0
    t0 <- gsub("Source\\\\_N", "{\\\\textbf{\\\\textit{Source N}}}", t0)
    t0 <- gsub("Taxon\\\\_N", "{\\\\textbf{\\\\textit{Taxon N}}}", t0)
    return(t0)
}

make_table0 <- function(tax_dr, tax_summ, tax_dq, table_caption = ""){
    taxon_number <- sapply(seq(nrow(tax_summ$matrix)), function(x) sum(tax_summ$matrix[x,]))
    # xx <- table(names(tax_dr))
    # Column2 = unname(xx),
    table0 <- data.frame(var1 = paste0(seq(length(taxon_number)), "."),
        var2 = paste0(taxon_number, "/", length(tax_dq$cleaned_names)),
        var3 = names(tax_dr))
    table0 <- dplyr::mutate(table0, var1 = cell_spec(var1, "latex", align = "r",
        bold = TRUE, italic = TRUE),
        var2 = cell_spec(var2, "latex", align = "c"))
    t0 <- knitr::kable(table0, escape = FALSE, row.names = FALSE, format = "latex",
        booktabs = TRUE, caption = table_caption, linesep = "", longtable = TRUE)
    t0 <- gsub("var1", "   ", t0)
    t0 <- gsub("var2", "Taxon Presence", t0)
    t0 <- gsub("var3", "Original Study Citation", t0)
    kableExtra::kable_styling(kable_input = t0, latex_options = "hold_position") %>%
    column_spec(1, width = "0.5cm") %>%
    column_spec(2, width = "2cm") %>%
    column_spec(3, width = "12cm") %>%
    collapse_rows(columns = 3, latex_hline = "major", valign = "middle") %>%
    row_spec(0, bold = TRUE, align = "c") -> t0
    return(t0)
}

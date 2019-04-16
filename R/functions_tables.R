make_table0 <- function(tax_dr, tax_summ, tax_dq){
    taxon_number <- sapply(seq(nrow(tax_summ$matrix)), function(x) sum(tax_summ$matrix[x,]))
    table0 <- data.frame(Original_Studies = names(tax_dr), Taxon_Number = paste0(taxon_number, "/", length(tax_dq$cleaned_names)))
    t0 <- knitr::kable(table0, escape = FALSE, row.names = TRUE, format = "markdown", booktabs = TRUE)

}

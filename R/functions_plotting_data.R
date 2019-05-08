crossval <- use_othercals2(tax_phyloallall[[1]], tax_othercalall[[1]])
# tax_phyloall <- tax_phyloallall[[1]]

make_lttplot_data1 <- function(taxon, crossval, tax_summary, tax_phyloall, filename = "LTTplot_data_"){
    crossval <- crossval[!is.na(crossval)]
    crossval <- crossval[sapply(crossval, ape::Ntip) > 2]
    max_ages <- tax_summary$mrca
    max_tips <- max(sapply(tax_phyloall, function(x) max(ape::Ntip(x))))
    studies <- sort(unique(names(tax_phyloall)))
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    # start the plot:
    file_name = paste0("docs/plots/", taxon, "_", filename, ".pdf")
    grDevices::pdf(file = file_name, height = 9, width = 7)
    par(omi = c(0.5,0,0.35,0))
    par(mfrow = c(ceiling(length(studies)*0.5), 2)) # graph ltt in two columns
    par(mai = c(0.2, 0.82, 0.2, 0.2))
    for(i in studies){
        trees <- tax_phyloall[names(tax_phyloall) %in% i]
        lttplot_data(taxon, trees, tax_phyloall, max_ages, max_tips)
    }

}
lttplot_data <- function(taxon, trees, tax_phyloall, max_ages, max_tips){
    length_arrowhead <- 0.075
    lwd_phyloall <- 1.5
    y_numbers <- rep(-max_tips*0.14, length(max_ages))
    cond1 <- duplicated(round(max_ages)) & !duplicated(study_number)
    y_numbers[cond1] <- -max_tips*0.23
    ape::ltt.plot(trees[[1]], xlim = c(-xlim0, 0),
          ylim = c(-max_tips*0.30, max_tips),
          col = paste0("#ffffff", "10"), ylab = paste(taxon, "Species"),
          xlab = "Time (MYA)") # we need to plot it white because argument plot = FALSE is not working with ltt.plot
    cond2 <- (!duplicated(study_number) | !duplicated(round(max_ages)))
    for (i in seq(length(tax_phyloall))){
      col_phyloall <- col_phyloall_sample[i]
      ape::ltt.lines(phy = tax_phyloall[[i]], col = paste0(col_phyloall), lwd = lwd_phyloall)
      x0 <- x1 <- -tax_summary$mrca[i]
      arrows(x0, y0 = -max_tips*0.075, x1, y1 = 0, length = length_arrowhead, col = paste0(col_phyloall), lwd = 2)
      text(x = -max_ages[i], y = y_numbers[i], labels = ifelse(cond2[i], study_number[i], ""),
          font = 4, col = col_phyloall, cex = 1.1)
    }
    for(i in seq(trees)){
        ape::ltt.lines(phy = trees[[i]], col = paste0("#9932CC", 80), lwd = lwd_phyloall)
    }
}

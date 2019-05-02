# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

make_lttplot_phyloall <- function(taxon, tax_phyloall, tax_summary, tax_datedotol = NULL,
    filename = "LTTplot_phyloall", add_legend = FALSE){
  file_name = paste0("docs/plots/", taxon, "_", filename, ".pdf")
  grDevices::pdf(file = file_name, height = 3.5, width = 7)
  par(mai = c(1.02, 0.82, 0.2, 0.2))
  trees <- tax_phyloall
  if(inherits(tax_datedotol, "phylo")){
      # ape::is.ultrametric(tax_datedotol)
      # ape::is.binary(tax_datedotol)
      tax_datedotol <- ape::collapse.singles(tax_datedotol)
      tax_datedotol <- phytools::force.ultrametric(tax_datedotol)
      trees <- c(trees, tax_datedotol)
  }
  class(trees) <- "multiPhylo"
  # class(tax_phyloall)
  # ape::is.ultrametric(tax_phyloall)
  max_ages <- sapply(trees, function(x) max(ape::branching.times(x)))
  xlim0 <- round(max(max_ages)+5, digits = -1)
  max_tipsall <- sapply(trees, function(x) max(ape::Ntip(x)))
  max_tips <- max(max_tipsall)
  col_datedotol <- "#808080" #gray
  col_phylomedian <- "#ffa500"  # orange
  # col_phyloall <- "#cce5ff" # blue
  y1 <- 0
  y0 <- -max_tips*0.075
  lwd_arrows <- 2
  length_arrowhead <- 0.075
  nn <- unique(names(tax_phyloall))[order(unique(names(tax_phyloall)))] # get ordered names
  # col_sample <- sample(gray.colors(n = length(nn)), length(nn))
  col_sample <- sample(rainbow(n = length(nn)), length(nn))
  col_phyloall_sample <- col_sample[match(names(tax_phyloall), nn)]
  study_number <- seq(length(nn))[match(names(tax_phyloall), nn)]
  ss <- which(table(study_number)>1)
  # max_ages <- tax_summary$mrca
  for(ii in ss){ # case when a study has multiple chronograms and we need to adjust x position of number
      tt <- which(ii==study_number)
      dd <- abs(diff(tax_summary$mrca[tt]))
      eq <- which(dd < 0.02*xlim0)
      if(length(eq) == 0) next
      for(j in eq){ # uses the mean age for those chronograms that are closer by less than 0.5 myrs
          max_ages[tt[c(j, j+1)]] <- mean(tax_summary$mrca[ii==study_number][c(j, j+1)])
      }
  }
  y_numbers <- rep(-max_tips*0.14, length(max_ages))
  cond1 <- duplicated(round(max_ages)) & !duplicated(study_number)
  y_numbers[cond1] <- -max_tips*0.23
  ape::ltt.plot(trees[[which.max(max_tipsall)]], xlim = c(-xlim0, 0),
        ylim = c(-max_tips*0.30, max_tips),
        col = paste0("#ffffff", "80"), ylab = paste(taxon, "Species"),
        xlab = "Time (MYA)")
  # ape::ltt.lines(phy = tax_phylomedian$phylo_median, col = paste0(col_phylomedian, "80"))
  cond2 <- (!duplicated(study_number) | !duplicated(round(max_ages)))
  for (i in seq(length(tax_phyloall))){
    col_phyloall <- col_phyloall_sample[i]
    ape::ltt.lines(phy = tax_phyloall[[i]], col = paste0(col_phyloall), lwd = 1.5)
    x0 <- x1 <- -tax_summary$mrca[i]
    arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_phyloall), lwd = lwd_arrows)
    text(x = -max_ages[i], y = y_numbers[i], labels = ifelse(cond2[i], study_number[i], ""),
        font = 4, col = col_phyloall, cex = 0.75)
  }
  text(labels = paste(taxon, "source chronograms"), x = -xlim0, y = max_tips*0.925, cex = 0.75, adj = 0, font = 1)
  if(add_legend){
      leg <- paste(taxon, c("dated OToL tree", "median summary chronogram",
                            "source chronograms"))
      legend(x = "topleft", #round(-max_age, digits = -1),
             # y = round(max_tips, digits = -2),
             # legend = leg, col = c(col_datedotol, col_phylomedian, col_phyloall),
             legend = leg, col = c(col_datedotol, col_phyloall),
             cex = 0.5, pch = 19, bty = "n")
  }
  dev.off()
}

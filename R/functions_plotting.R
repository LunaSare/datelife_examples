# make_phylobars_plot <-
# colors()[grep("blue", colors())]
make_lttplot_summtrees <- function(taxon, tax_phyloall, tax_datedotol,
                               summ_trees,
                               legend_summtrees = "Median",
                               col_summtrees = c("blue", "green", "forestgreen"),
                               filename = "LTTplot_summtrees_"){
  is.hex <- tryCatch(suppressWarnings(plotrix::color.id(col_summtrees)), error = function(e) FALSE)
  # if it is valid it is converted to hex so it can be transparent in some parts of the plot:
  if(!inherits(is.hex, "logical")){
    col_summtrees <- gplots::col2hex(col_summtrees)
  }
  file_name = paste0("docs/plots/", taxon, "_", filename, legend_summtrees, ".pdf")
  # print(file_name)
  trees <- c(tax_phyloall, tax_datedotol)
  if(inherits(summ_trees, "phylo")){
    trees <- c(trees, summ_trees)
  }
  if(inherits(summ_trees, "list")){
    class(summ_trees) <- "multiPhylo"
    trees <- c(trees, summ_trees)
  }
  trees <- trees[!sapply(trees, is.null)]
  max_age <- max(sapply(trees, function(x) max(ape::branching.times(x))))
  max_tips <- max(sapply(trees, function(x) max(ape::Ntip(x))))
  tax_datedotol <- ape::collapse.singles(tax_datedotol)
  tax_datedotol <- phytools::force.ultrametric(tax_datedotol)
  col_datedotol <- "#808080" #gray
  col_phyloall <- "#cce5ff" # light blue
  cols <- c(col_datedotol, col_phyloall, col_summtrees)
  leg_summ <- paste(legend_summtrees, gsub("_", " ", names(summ_trees)))
  leg <- paste(taxon, c("Dated OToL", "Source Chronograms", leg_summ))
  linetype <- rep(1, 5)

  y1 <- max_tips*0.05
  y0 <- max_tips*0.15
  lwd_arrows <- 2
  length_arrowhead <- 0.075
  grDevices::pdf(file = file_name, height = 3, width = 7)
  par(mai = c(1.02, 0.82, 0.2, 0.42))
  ape::ltt.plot(tax_datedotol, xlim = c(-max_age, 0), ylim = c(0, max_tips),
                col = paste0(col_datedotol, "80"), ylab = paste(taxon, "Species"),
                xlab = "Time (MYA)")
  # we will plot dated otol arrows at the end bc its too light
  for (i in seq(length(tax_phyloall))){
    ape::ltt.lines(phy = tax_phyloall[[i]], col = paste0(col_phyloall, "80"))
    # points(x = -max(ape::branching.times(tax_phyloall[[i]])),  y = 2, pch = 25, col = paste0(col_phyloall, "60"), lwd = 0.75)
    x0 <- x1 <- -max(ape::branching.times(tax_phyloall[[i]]))
    arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_phyloall, "99"), lwd = lwd_arrows)
  }
  for(i in seq_along(summ_trees)){
    ape::ltt.lines(phy = summ_trees[[i]], col = paste0(col_summtrees[i], "80"), lty = 1)
    x0 <- x1 <- -max(ape::branching.times(summ_trees[[i]]))
    arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_summtrees[i], "80"), lwd = lwd_arrows)
  }
  # dated otol arrow (max branching time):
  x0 <- x1 <- -max(ape::branching.times(tax_datedotol))
  arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_datedotol, "80"), lwd = lwd_arrows)

  legend(x = "topleft", #round(-max_age, digits = -1),
         # y = round(max_tips, digits = -2),
         legend = leg, col = cols,
         cex = 0.5, lty = linetype, bty = "n") # pch = 19
  dev.off()
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

make_lttplot_summ <- function(taxon, tax_phyloall, tax_datedotol, tax_phylosummary = NULL, col_phylosummary = "#ff0", legend_phylosumm = "Median", tax_phycluster = NULL, negs = c(), summ_matrix, sdm2phylo = NULL, filename = "LTTplot_"){
  # orange "#ffa500"
  # blue
  # as imple test to check that col_phylosummary is a valid color string, either character or hex:
  is.hex <- tryCatch(suppressWarnings(plotrix::color.id(col_phylosummary)), error = function(e) FALSE)
  # if it is valid it is converted to hex so it can be transparent in some parts of the plot:
  if(!inherits(is.hex, "logical")){
    col_phylosummary <- gplots::col2hex(col_phylosummary)
  }
  file_name = paste0("docs/plots/", taxon, "_", filename, legend_phylosumm, ".pdf")
  # print(file_name)
  trees <- c(tax_phyloall, tax_datedotol)
  if(inherits(tax_phylosummary, "phylo")){
    trees <- c(trees, tax_phylosummary)
  }
  if(inherits(tax_phycluster, "list")){
    class(tax_phycluster) <- "multiPhylo"
    trees <- c(trees, tax_phycluster)
  }
  if(inherits(sdm2phylo, "phylo")){
    trees <- c(trees, sdm2phylo)
  }
  trees <- trees[!sapply(trees, is.null)]
  max_age <- max(sapply(trees, function(x) max(ape::branching.times(x))))
  max_tips <- max(sapply(trees, function(x) max(ape::Ntip(x))))
  # ape::is.ultrametric(tax_datedotol)
  # ape::is.binary(tax_datedotol)
  tax_datedotol <- ape::collapse.singles(tax_datedotol)
  tax_datedotol <- phytools::force.ultrametric(tax_datedotol)
  col_datedotol <- "#808080" #gray
  col_phyloall <- "#cce5ff" # light blue

  col_nj <- "#ff3399"
  col_upgma <- "#b266ff"
  leg <- paste(taxon, c("Dated OToL", "Source Chronograms"))
  cols <- c(col_datedotol, col_phyloall)
  linetype <- c(1, 1)
  y1 <- max_tips*0.05
  y0 <- max_tips*0.15
  lwd_arrows <- 2
  length_arrowhead <- 0.075
  grDevices::pdf(file = file_name, height = 3, width = 7)
  par(mai = c(1.02, 0.82, 0.2, 0.42))
  ape::ltt.plot(tax_datedotol, xlim = c(-max_age, 0), ylim = c(0, max_tips),
                col = paste0(col_datedotol, "80"), ylab = paste(taxon, "Species"),
                xlab = "Time (MYA)")
  # we will plot dated otol arrows at the end bc its too light
  for (i in seq(length(tax_phyloall))){
    ape::ltt.lines(phy = tax_phyloall[[i]], col = paste0(col_phyloall, "80"))
    # points(x = -max(ape::branching.times(tax_phyloall[[i]])),  y = 2, pch = 25, col = paste0(col_phyloall, "60"), lwd = 0.75)
    x0 <- x1 <- -max(ape::branching.times(tax_phyloall[[i]]))
    arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_phyloall, "99"), lwd = lwd_arrows)
  }
  if(inherits(tax_phylosummary, "phylo")){
    ape::ltt.lines(phy = tax_phylosummary,
                   col = paste0(col_phylosummary, "80"),
                   lwd = 1.5)
    x0 <- x1 <- -max(ape::branching.times(tax_phylosummary))
    arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_phylosummary, "80"), lwd = lwd_arrows)
    leg <- c(leg, paste(legend_phylosumm, "Summary Chronogram"))
    cols <- c(cols, col_phylosummary)
    linetype <- c(linetype, 1)
  }
  if(inherits(tax_phycluster, "multiPhylo")){
    for(i in seq(tax_phycluster)){
      if(!is.null(tax_phycluster[[i]])){
        if(any(grepl("nj", names(tax_phycluster[i])))){
          col_sdm <- col_nj
        }
        if(any(grepl("upgma", names(tax_phycluster[i])))){
          col_sdm <- col_upgma
        }
        ape::ltt.lines(phy = tax_phycluster[[i]], col = paste0(col_sdm, "80"))
        # points(x = -max(ape::branching.times(tax_phycluster[[i]])), y = 2, pch = 25, col = paste0(col_sdm, "60"), lwd = 0.75)
        x0 <- x1 <- -max(ape::branching.times(tax_phycluster[[i]]))
        arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_sdm, "80"), lwd = lwd_arrows)
        leg <- c(leg, paste(taxon, legend_phylosumm, gsub("_", " ", toupper(names(tax_phycluster[i])))))
        cols <- c(cols, col_sdm)
        linetype <- c(linetype, 1)
      }
    }
  }
  if(length(negs) >0){
    # plot lttlines of corrected summ_matrix, both from nj and upgma
    # add to legend text leg and color col_leg_sdm (which is not transparent)
    summ_matrix[which(summ_matrix < 0)] <- 0.01
    tax_phycluster <- cluster_patristicmatrix(summ_matrix)
    for(i in seq(tax_phycluster)){
      if(!is.null(tax_phycluster[[i]])){
        if(any(grepl("nj", names(tax_phycluster[i])))){
          col_sdm <- col_nj
        }
        if(any(grepl("upgma", names(tax_phycluster[i])))){
          col_sdm <- col_upgma
        }
        ape::ltt.lines(phy = tax_phycluster[[i]], col = paste0(col_sdm, "80"), lty = 5)
        # points(x = -max(ape::branching.times(tax_phycluster[[i]])),  y = 2, pch = 25, col = paste0(col_sdm, "60"), lwd = 0.75)
        x0 <- x1 <- -max(ape::branching.times(tax_phycluster[[i]]))
        arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_sdm, "80"), lwd = lwd_arrows)
        cols <- c(cols, col_sdm)
        leg <- c(leg, paste(taxon, legend_phylosumm, gsub("_", " ", toupper(names(tax_phycluster[i]))), "no negative values"))
        linetype <- c(linetype, 5)
      }
    }
  }
  if(inherits(sdm2phylo, "phylo")){
    col_sdm2phy <- "#0000ff"
    ape::ltt.lines(phy = sdm2phylo, col = paste0(col_sdm2phy, "80"), lty = 1)
    # points(x = -max(ape::branching.times(sdm2phylo)), y = 2, pch = 25, col = paste0(col_sdm2phy, "80"))
    x0 <- x1 <- -max(ape::branching.times(sdm2phylo))
    arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_sdm2phy, "80"), lwd = lwd_arrows)
    leg <- c(leg, paste(taxon, legend_phylosumm, "with datelife algorithm"))
    cols <- c(cols, col_sdm2phy)
    linetype <- c(linetype, 1)
  }
  # dated otol arrow (max branching time):
  x0 <- x1 <- -max(ape::branching.times(tax_datedotol))
  arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_datedotol, "80"), lwd = lwd_arrows)

  legend(x = "topleft", #round(-max_age, digits = -1),
         # y = round(max_tips, digits = -2),
         legend = leg, col = cols,
         cex = 0.5, lty = linetype, bty = "n") # pch = 19
  dev.off()
  # print(file_name)
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

make_lttplot_sdm <- function(taxon, tax_phyloall, tax_datedotol, tax_phylomed = NULL, tax_phycluster = NULL, negs = c(), sdm_matrix, sdm2phylo = NULL, filename = "LTTplot_sdm"){
  file_name = paste0("docs/plots/", taxon, "_", filename, ".pdf")
  trees <- c(tax_phyloall, tax_datedotol)
  if(inherits(tax_phylomed, "phylo")){
    trees <- c(trees, tax_phylomed)
  }
  if(inherits(tax_phycluster, "list")){
    class(tax_phycluster) <- "multiPhylo"
    trees <- c(trees, tax_phycluster)
  }
  if(inherits(sdm2phylo, "phylo")){
    trees <- c(trees, sdm2phylo)
  }
  trees <- trees[!sapply(trees, is.null)]
  max_age <- max(sapply(trees, function(x) max(ape::branching.times(x))))
  max_tips <- max(sapply(trees, function(x) max(ape::Ntip(x))))
  # ape::is.ultrametric(tax_datedotol)
  # ape::is.binary(tax_datedotol)
  tax_datedotol <- ape::collapse.singles(tax_datedotol)
  tax_datedotol <- phytools::force.ultrametric(tax_datedotol)
  col_datedotol <- "#808080" #gray
  col_phyloall <- "#cce5ff" # light blue
  col_phylomedian <- "#ffa500"  # orange
  col_nj <- "#ff3399"
  col_upgma <- "#b266ff"
  leg <- paste(taxon, c("Dated OToL", "Source Chronograms"))
  cols <- c(col_datedotol, col_phyloall)
  linetype <- c(1, 1)
  y1 <- max_tips*0.05
  y0 <- max_tips*0.15
  lwd_arrows <- 2
  length_arrowhead <- 0.075
  grDevices::pdf(file = file_name, height = 3, width = 7)
  par(mai = c(1.02, 0.82, 0.2, 0.42))
  ape::ltt.plot(tax_datedotol, xlim = c(-max_age, 0), ylim = c(0, max_tips),
                col = paste0(col_datedotol, "80"), ylab = paste(taxon, "Species"),
                xlab = "Time (MYA)")
  x0 <- x1 <- -max(ape::branching.times(tax_datedotol))
  arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_datedotol, "80"), lwd = lwd_arrows)
  # points(x = -max(ape::branching.times(tax_datedotol)),  y = 2, pch = 25, col = paste0(col_datedotol, "60"), lwd = 0.75)
  for (i in seq(length(tax_phyloall))){
    ape::ltt.lines(phy = tax_phyloall[[i]], col = paste0(col_phyloall, "80"))
    # points(x = -max(ape::branching.times(tax_phyloall[[i]])),  y = 2, pch = 25, col = paste0(col_phyloall, "60"), lwd = 0.75)
    x0 <- x1 <- -max(ape::branching.times(tax_phyloall[[i]]))
    arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_phyloall, "99"), lwd = lwd_arrows)
  }
  if(inherits(tax_phylomed, "phylo")){
    ape::ltt.lines(phy = tax_phylomed, col = paste0(col_phylomedian, "80"))
    x0 <- x1 <- -max(ape::branching.times(tax_phylomed))
    arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_phylomedian, "80"), lwd = lwd_arrows)
    leg <- c(leg, "Median Summary Chronogram")
    cols <- c(cols, col_phylomedian)
    linetype <- c(linetype, 1)
  }
  if(inherits(tax_phycluster, "multiPhylo")){
    for(i in seq(tax_phycluster)){
      if(!is.null(tax_phycluster[[i]])){
        if(any(grepl("nj", names(tax_phycluster[i])))){
          col_sdm <- col_nj
        }
        if(any(grepl("upgma", names(tax_phycluster[i])))){
          col_sdm <- col_upgma
        }
        ape::ltt.lines(phy = tax_phycluster[[i]], col = paste0(col_sdm, "80"))
        # points(x = -max(ape::branching.times(tax_phycluster[[i]])), y = 2, pch = 25, col = paste0(col_sdm, "60"), lwd = 0.75)
        x0 <- x1 <- -max(ape::branching.times(tax_phycluster[[i]]))
        arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_sdm, "80"), lwd = lwd_arrows)
        leg <- c(leg, paste(taxon, "SDM", names(tax_phycluster[i])))
        cols <- c(cols, col_sdm)
        linetype <- c(linetype, 1)
      }
    }
  }
  if(length(negs) >0){
    # plot lttlines of corrected sdm_matrix, both from nj and upgma
    # add to legend text leg and color col_leg_sdm (which is not transparent)
    sdm_matrix[which(sdm_matrix < 0)] <- 0.01
    tax_phycluster <- cluster_patristicmatrix(sdm_matrix)
    for(i in seq(tax_phycluster)){
      if(!is.null(tax_phycluster[[i]])){
        if(any(grepl("nj", names(tax_phycluster[i])))){
          col_sdm <- col_nj
        }
        if(any(grepl("upgma", names(tax_phycluster[i])))){
          col_sdm <- col_upgma
        }
        ape::ltt.lines(phy = tax_phycluster[[i]], col = paste0(col_sdm, "80"), lty = 5)
        # points(x = -max(ape::branching.times(tax_phycluster[[i]])),  y = 2, pch = 25, col = paste0(col_sdm, "60"), lwd = 0.75)
        x0 <- x1 <- -max(ape::branching.times(tax_phycluster[[i]]))
        arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_sdm, "80"), lwd = lwd_arrows)
        cols <- c(cols, col_sdm)
        leg <- c(leg, paste(taxon, "SDM", names(tax_phycluster[i]), "no negative values"))
        linetype <- c(linetype, 5)
      }
    }
  }
  if(inherits(sdm2phylo, "phylo")){
    col_sdm2phy <- "#0000ff"
    ape::ltt.lines(phy = sdm2phylo, col = paste0(col_sdm2phy, "80"), lty = 1)
    # points(x = -max(ape::branching.times(sdm2phylo)), y = 2, pch = 25, col = paste0(col_sdm2phy, "80"))
    x0 <- x1 <- -max(ape::branching.times(sdm2phylo))
    arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_sdm2phy, "80"), lwd = lwd_arrows)
    leg <- c(leg, paste(taxon, "SDM with datelife algorithm"))
    cols <- c(cols, col_sdm2phy)
    linetype <- c(linetype, 1)
  }
  legend(x = "topleft", #round(-max_age, digits = -1),
         # y = round(max_tips, digits = -2),
         legend = leg, col = cols,
         cex = 0.5, lty = linetype, bty = "n") # pch = 19
  dev.off()

}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

make_lttplot_phyloall <- function(taxon, tax_phyloall, tax_summary, tax_datedotol = NULL,
    filename = "LTTplot_phyloall", legend = FALSE){
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
  nn <- unique(names(tax_phyloall))
  # col_sample <- sample(gray.colors(n = length(nn)), length(nn))
  col_sample <- sample(rainbow(n = length(nn)), length(nn))
  col_phyloall_sample <- col_sample[match(names(tax_phyloall), nn)]
  study_number <- seq(length(nn))[match(names(tax_phyloall), nn)]
  ss <- which(table(study_number)>1)
  # max_ages <- tax_summary$mrca
  for(i in ss){ # case when a study has multiple chronograms
      tt <- which(i==study_number)
      dd <- diff(tax_summary$mrca[tt])
      eq <- which(dd < 0.04*xlim0)
      if(length(eq) == 0) next
      for(j in eq){ # uses the mean age for those chronograms that are closer by less than 0.5 myrs
          max_ages[tt[c(j, j+1)]] <- mean(tax_summary$mrca[i==study_number][c(j, j+1)])
      }
  }

  ape::ltt.plot(trees[[which.max(max_tipsall)]], xlim = c(-xlim0, 0),
        ylim = c(-max_tips*0.15, max_tips),
        col = paste0("#ffffff", "80"), ylab = paste(taxon, "Species"),
        xlab = "Time (MYA)")
  # ape::ltt.lines(phy = tax_phylomedian$phylo_median, col = paste0(col_phylomedian, "80"))
  for (i in seq(length(tax_phyloall))){
    col_phyloall <- col_phyloall_sample[i]
    ape::ltt.lines(phy = tax_phyloall[[i]], col = paste0(col_phyloall), lwd = 1.5)
    x0 <- x1 <- -tax_summary$mrca[i]
    arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_phyloall), lwd = lwd_arrows)
    text(x = -max_ages[i], y = -max_tips*0.15, labels = study_number[i], font = 4, col = col_phyloall)
  }
  if(legend){
      leg <- paste(taxon, c("Dated OToL", "Median Summary Chronogram",
                            "Source Chronograms"))

      legend(x = "topleft", #round(-max_age, digits = -1),
             # y = round(max_tips, digits = -2),
             # legend = leg, col = c(col_datedotol, col_phylomedian, col_phyloall),
             legend = leg, col = c(col_datedotol, col_phyloall),
             cex = 0.5, pch = 19, bty = "n")
  }
  dev.off()
}

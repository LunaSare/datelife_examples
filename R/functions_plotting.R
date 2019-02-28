make_lttplot_summ <- function(taxon, tax_phyloall, tax_datedotol, tax_phylosummary = NULL, col_phylosummary = "#ff0", legend_phylosumm = "Median", tax_phycluster = NULL, negs = c(), summ_matrix, sdm2phylo = NULL, filename = "LTTplot_"){
  # orange "#ffa500"
  # blue
  # as imple test to check that col_phylosummary is a valid color string, either character or hex:
  is.hex <- tryCatch(suppressWarnings(plotrix::color.id(col_phylosummary)), error = function(e) FALSE)
  # if it is valid it is converted to hex so it can be transparent in some parts of the plot:
  if(!inherits(is.hex, "logical")){
    col_phylosummary <- col2hex(col_phylosummary)
  }
  file_name = paste0("docs/plots/", taxon, "_", filename, legend_phylosumm, ".pdf")
  print(file_name)
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
                xlab = "Time (myrs)")
  x0 <- x1 <- -max(ape::branching.times(tax_datedotol))
  arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_datedotol, "80"), lwd = lwd_arrows)
  # points(x = -max(ape::branching.times(tax_datedotol)),  y = 2, pch = 25, col = paste0(col_datedotol, "60"), lwd = 0.75)
  for (i in seq(length(tax_phyloall))){
    ape::ltt.lines(phy = tax_phyloall[[i]], col = paste0(col_phyloall, "80"))
    # points(x = -max(ape::branching.times(tax_phyloall[[i]])),  y = 2, pch = 25, col = paste0(col_phyloall, "60"), lwd = 0.75)
    x0 <- x1 <- -max(ape::branching.times(tax_phyloall[[i]]))
    arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_phyloall, "99"), lwd = lwd_arrows)
  }
  if(inherits(tax_phylosummary, "phylo")){
    ape::ltt.lines(phy = tax_phylosummary, col = paste0(col_phylosummary, "80"))
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
  legend(x = "topleft", #round(-max_age, digits = -1), 
         # y = round(max_tips, digits = -2), 
         legend = leg, col = cols,
         cex = 0.5, lty = linetype, bty = "n") # pch = 19
  dev.off()
  print(file_name)
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
                xlab = "Time (myrs)")
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
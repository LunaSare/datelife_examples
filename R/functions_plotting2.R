make_lttplot_summ2 <- function(taxon, tax_phyloall, tax_datedotol = NULL, tax_phylomed = NULL,
        tax_phycluster = NULL, sdm2phylo = NULL, negs = c(), sdm_matrix, filename = "LTTplot",
        tax_phycluster_sdm = NULL, tax_phycluster_median = NULL,
        tax_phyloall_color = "rainbow", add_legend = FALSE){

    file_name = paste0("docs/plots/", taxon, "_", filename, ".pdf")
    tax_phyloall_color <- match.arg(tax_phyloall_color, c("rainbow", "other"))
    trees <- tax_phyloall
    leg <- "Source Chronograms"
    lwd_phyloall <- 1.5
    if(inherits(tax_datedotol, "phylo")){
        # ape::is.ultrametric(tax_datedotol)
        # ape::is.binary(tax_datedotol)
        tax_datedotol <- ape::collapse.singles(tax_datedotol)
        tax_datedotol <- phytools::force.ultrametric(tax_datedotol)
        trees <- c(trees, tax_datedotol)
        leg <- c(leg, "Dated OToL")
    }
    if(inherits(tax_phycluster_median, "list")){
        if(inherits(tax_phycluster_median[[1]], "phylo")){
            class(tax_phycluster_median) <- "multiPhylo"
            trees <- c(trees, tax_phycluster_median)
            lwd_phyloall <- 1
        }
    }
    if(inherits(tax_phycluster_sdm, "list")){
        if(inherits(tax_phycluster_sdm[[1]], "phylo")){
            class(tax_phycluster_sdm) <- "multiPhylo"
            trees <- c(trees, tax_phycluster_sdm)
            lwd_phyloall <- 1
        }
    }
    class(trees) <- "multiPhylo"
    max_agesall <- sapply(trees, function(x) max(ape::branching.times(x)))
    xlim0 <- round(max(max_agesall)+5, digits = -1)
    max_tipsall <- sapply(trees, function(x) max(ape::Ntip(x)))
    max_tips <- max(max_tipsall)
    col_datedotol <- "#808080" #gray
    y1 <- 0
    y0 <- -max_tips*0.075
    lwd_arrows <- 2
    length_arrowhead <- 0.075
    nn <- unique(names(tax_phyloall))[order(unique(names(tax_phyloall)))] # get ordered names
    if(tax_phyloall_color == "rainbow"){
        col_sample <- sample(rainbow(n = length(nn)), length(nn))
    } else {
        # col_sample <- sample(gray.colors(n = length(nn)), length(nn))
        col_sample <- paste0("#778899", sample(20:90, length(nn))) #lightslategrey
    }
    col_phyloall_sample <- col_sample[match(names(tax_phyloall), nn)]
    study_number <- seq(length(nn))[match(names(tax_phyloall), nn)]
    ss <- which(table(study_number)>1)
    max_ages <- tax_summary$mrca
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

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    grDevices::pdf(file = file_name, height = 3.5, width = 7)
    par(mai = c(1.02, 0.82, 0.2, 0.2))
    ape::ltt.plot(trees[[which.max(max_tipsall)]], xlim = c(-xlim0, 0),
          ylim = c(-max_tips*0.30, max_tips),
          col = paste0("#ffffff", "10"), ylab = paste(taxon, "Species"),
          xlab = "Time (MYA)") # we need to plot it white because argument plot = FALSE is not working with ltt.plot
    cond2 <- (!duplicated(study_number) | !duplicated(round(max_ages)))
    for (i in seq(length(tax_phyloall))){
      col_phyloall <- col_phyloall_sample[i]
      ape::ltt.lines(phy = tax_phyloall[[i]], col = paste0(col_phyloall), lwd = lwd_phyloall)
      x0 <- x1 <- -tax_summary$mrca[i]
      arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(col_phyloall), lwd = lwd_arrows)
      text(x = -max_ages[i], y = y_numbers[i], labels = ifelse(cond2[i], study_number[i], ""),
          font = 4, col = col_phyloall, cex = 0.75)
    }
    foo <- function(tax_phycluster, color){
        for(i in seq(length(tax_phycluster))){
          if(inherits(tax_phycluster[[i]], "phylo")){
            if(any(grepl("nj", names(tax_phycluster[i])))){
              lty_here <- 6 # twodash
            }
            if(any(grepl("upgma", names(tax_phycluster[i])))){
              lty_here <- 1
            }
            ape::ltt.lines(phy = tax_phycluster[[i]], col = paste0(color, "90"), lty = lty_here, lwd = 2)
            # points(x = -max(ape::branching.times(tax_phycluster[[i]])), y = 2, pch = 25, col = paste0(col_here, "60"), lwd = 0.75)
            x0 <- x1 <- -max(ape::node.depth.edgelength(tax_phycluster[[i]]))
            arrows(x0, y0, x1, y1, length = length_arrowhead, col = paste0(color, "90"), lwd = lwd_arrows)
            leg <- c(leg, paste("SDM", names(tax_phycluster[i])))
          }
        }
        return(leg)
    }
    if(inherits(tax_phycluster_median, "multiPhylo")){
        leg_here <- foo(tax_phycluster_median, "#FF8C00") # dark orange
        leg <- c(leg, leg_here)
    }
    if(inherits(tax_phycluster_sdm, "multiPhylo")){
        leg_here <- foo(tax_phycluster_sdm, "#9932CC") # dark orchid
        leg <- c(leg, leg_here)
    }
    if(add_legend){
        leg <- paste(taxon, leg)
        legend(x = "topleft", #round(-max_age, digits = -1),
               # y = round(max_tips, digits = -2),
               # legend = leg, col = c(col_datedotol, col_phylomedian, col_phyloall),
               legend = leg, col = c(col_datedotol, col_phyloall),
               cex = 0.5, pch = 19, bty = "n")
    }
    dev.off()
}

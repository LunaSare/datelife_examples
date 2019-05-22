
lttplot_clusters <- function(taxon, trees, tax_phycluster, tax_phycluster_title, xlim0,
        tax_phyloall, tax_summary, study_number,
        max_ages, col_phyloall_sample, leg, add_legend){
    leg_color <- "#77889980"
    lwd_arrows <- 2
    length_arrowhead <- 0.075
    lwd_phyloall <- 1.5
    max_tipsall <- sapply(trees, function(x) max(ape::Ntip(x)))
    max_tips <- max(max_tipsall)
    y_numbers <- rep(-max_tips*0.14, length(max_ages))
    cond1 <- duplicated(round(max_ages)) & !duplicated(study_number)
    y_numbers[cond1] <- -max_tips*0.23
    ape::ltt.plot(trees[[which.max(max_tipsall)]], xlim = c(-xlim0, 0),
          ylim = c(-max_tips*0.30, max_tips),
          col = paste0("#ffffff", "10"), ylab = paste(taxon, "Species N"),
          xlab = "Time (MYA)") # we need to plot it white because argument plot = FALSE is not working with ltt.plot
    cond2 <- (!duplicated(study_number) | !duplicated(round(max_ages)))
    for (i in seq(length(tax_phyloall))){
      col_phyloall <- col_phyloall_sample[i]
      ape::ltt.lines(phy = tax_phyloall[[i]], col = paste0(col_phyloall), lwd = lwd_phyloall)
      x0 <- x1 <- -tax_summary$mrca[i]
      arrows(x0, y0 = -max_tips*0.075, x1, y1 = 0, length = length_arrowhead, col = paste0(col_phyloall), lwd = lwd_arrows)
      text(x = -max_ages[i], y = y_numbers[i], labels = ifelse(cond2[i], study_number[i], ""),
          font = 4, col = col_phyloall, cex = 0.75)
    }
    class(tax_phycluster) <- "multiPhylo"
    foo <- function(tax_phycluster){
        leg <- leg_color <- c()
        for(i in seq(length(tax_phycluster))){
          if(inherits(tax_phycluster[[i]], "phylo")){
            lty_here <- 1 # longdash; #6 twodash
            if(any(c("nj", "njs") %in% names(tax_phycluster[i]))){
              # lty_here <- 1 # longdash; #6 twodash
              labels_here <- "NJ"
              color_here <- "#FF8C00" # dark orange
              leg <- c(leg, "Neighbor-joining (NJ) method")
              leg_color <- c(leg_color, color_here)
            }
            if(any(grepl("upgma", names(tax_phycluster[i])))){
              # lty_here <- 1
              labels_here <- "UPGMA"
              color_here <- "#9932CC" # dark orchid
              leg <- c(leg, "Unweighted pair group method with arithmetic mean (UPGMA)")
              leg_color <- c(leg_color, color_here)
            }
            if(any(grepl("bionj", names(tax_phycluster[i])))){
              labels_here <- "BIONJ"
              color_here <- "#556B2F" # dark olive green
              leg <- c(leg, "Improved neighbor-joining method (BIONJ)")
              leg_color <- c(leg_color, color_here)
            }
            if(any(grepl("mvr", names(tax_phycluster[i])))){
              labels_here <- "MVR"
              color_here <- "#8B4513" # saddle brown
              leg <- c(leg, "Minimum Variance Reduction (MVR) method")
              leg_color <- c(leg_color, color_here)
            }
            if(any(grepl("triang", names(tax_phycluster[i])))){
              # lty_here <- 1
              labels_here <- "TM"
              color_here <- "#4682B4" # steelblue
              leg <- c(leg, "Triangle method (TM)")
              leg_color <- c(leg_color, color_here)
            }
            ape::ltt.lines(phy = tax_phycluster[[i]], col = paste0(color_here, "90"), lty = lty_here, lwd = 2)
            # points(x = -max(ape::branching.times(tax_phycluster[[i]])), y = 2, pch = 25, col = paste0(col_here, "60"), lwd = 0.75)
            x0 <- x1 <- -max(ape::node.depth.edgelength(tax_phycluster[[i]]))
            arrows(x0, y0 = 2.5+max_tips*0.1, x1, y1 = 2.5, length = length_arrowhead,
                col = paste0(color_here, "99"), lwd = 2.5, lty = lty_here)
            text(x = x0, y = 2.5+max_tips*0.14, labels = labels_here, srt = 45,
                adj = 0, cex = 0.5, col = color_here, font = 2)
          }
        }
        keep <- !duplicated(leg)
        leg <- leg[keep]
        leg_color <- leg_color[keep]
        return(list(leg = leg, leg_color = leg_color))
    }
    if(inherits(tax_phycluster, "multiPhylo")){
        keep <-  !is.na(tax_phycluster)
        ff <- foo(tax_phycluster[keep])
    }
    if(add_legend){
        legend(x = -xlim0, y = max_tips*1.05, #round(-max_age, digits = -1),
               # y = round(max_tips, digits = -2),
               legend = paste(taxon, leg), col = leg_color,
               cex = 0.45, bty = "n", pch = 19)
       if(inherits(tax_phycluster, "multiPhylo")){
           text(labels = paste(taxon, tax_phycluster_title, "summary chronograms obtained with:"),
            x = -xlim0, y = max_tips*0.925, cex = 0.45, adj = 0)
           legend(x = -xlim0, y = max_tips*0.925, pch = 19,
            legend = ff$leg, col = ff$leg_color, cex = 0.45, bty = "n")
        }
    }
}
make_lttplot_clusters <- function(taxon, tax_phyloall, tax_summary,
        tax_phycluster_median = NULL, tax_phycluster_sdm = NULL, filename = "LTTplot_clusters_both",
        add_legend = TRUE, tax_datedotol = NULL){
    leg <- "Source Chronograms"
    trees <- tax_phyloall
    max_agesall <- sapply(trees, function(x) max(ape::branching.times(x)))
    if(inherits(tax_datedotol, "phylo")){
        # ape::is.ultrametric(tax_datedotol)
        # ape::is.binary(tax_datedotol)
        tax_datedotol <- ape::collapse.singles(tax_datedotol)
        tax_datedotol <- phytools::force.ultrametric(tax_datedotol)
        trees <- c(trees, tax_datedotol)
        leg <- c(leg, "Dated OToL")
        max_agesall <- c(max_agesall, max(ape::branching.times(tax_datedotol)))
    }
    if(inherits(tax_phycluster_median, "list")){
        if(inherits(tax_phycluster_median[[1]], "phylo")){
            class(tax_phycluster_median) <- "multiPhylo"
            max_agesall <- c(max_agesall, sapply(tax_phycluster_median, function(x)
                max(ape::branching.times(x))))
            trees_median <- c(trees, tax_phycluster_median)
            class(trees_median) <- "multiPhylo"
        }
    }
    if(inherits(tax_phycluster_sdm, "list")){
        if(inherits(tax_phycluster_sdm[[1]], "phylo")){
            class(tax_phycluster_sdm) <- "multiPhylo"
            max_agesall <- c(max_agesall, sapply(tax_phycluster_sdm, function(x)
                max(ape::branching.times(x))))
            trees_sdm <- c(trees, tax_phycluster_sdm)
            class(trees_sdm) <- "multiPhylo"
        }
    }
    xlim0 <- round(max(max_agesall)+5, digits = -1)
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    # colors for source chronograms:
    nn <- unique(names(tax_phyloall))[order(unique(names(tax_phyloall)))] # get ordered names
    col_sample <- paste0("#778899", sample(20:90, length(nn))) #lightslategrey
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
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    # start the plot:
    file_name = paste0("docs/plots/", taxon, "_", filename, ".pdf")
    grDevices::pdf(file = file_name, height = 7, width = 7)
    par(mfrow = c(2,1))
    par(mai = c(1.02, 0.82, 0.2, 0.2))
    lttplot_clusters(taxon, trees_median, tax_phycluster_median, tax_phycluster_title = "Median",
            xlim0, tax_phyloall, tax_summary, study_number,
            max_ages, col_phyloall_sample, leg, add_legend)
    lttplot_clusters(taxon, trees_sdm, tax_phycluster_sdm, tax_phycluster_title = "SDM",
            xlim0, tax_phyloall, tax_summary, study_number,
            max_ages, col_phyloall_sample, leg, add_legend)
    dev.off()
}

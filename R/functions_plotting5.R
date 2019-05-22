lttplot_summaries <- function(taxon, trees, sdm_summs, median_summs, summs_title, xlim0,
        tax_phyloall, tax_summary, study_number, max_tips,
        max_ages, col_phyloall_sample, add_legend = FALSE, leg, leg_color){
    length_arrowhead <- 0.075
    lwd_phyloall <- 1.5
    y_numbers <- rep(-max_tips*0.14, length(max_ages))
    cond1 <- duplicated(round(max_ages)) & !duplicated(study_number)
    y_numbers[cond1] <- -max_tips*0.23
    ape::ltt.plot(trees[[1]], xlim = c(-xlim0, 0),
          ylim = c(-max_tips*0.30, max_tips),
          col = paste0("#ffffff", "10"), ylab = paste(taxon, "Species N"),
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
    foo <- function(phy, color_here, labels_here, length_arrowhead, max_tips){
        ape::ltt.lines(phy = phy, col = paste0(color_here, "90"), lty = 1, lwd = 2)
        # points(x = -max(ape::branching.times(tax_phycluster[[i]])), y = 2, pch = 25, col = paste0(col_here, "60"), lwd = 0.75)
        x0 <- x1 <- -max(ape::node.depth.edgelength(phy))
        arrows(x0, y0 = 2.5+max_tips*0.1, x1, y1 = 2.5, length = length_arrowhead,
            col = paste0(color_here, "99"), lwd = 2.5, lty = 1)
        text(x = x0, y = 2.5+max_tips*0.14, labels = labels_here, srt = 45,
            adj = 0, cex = 0.85, col = color_here, font = 2)
    }
    if(inherits(sdm_summs, "phylo")){ # blue
        foo(phy = sdm_summs, color_here = "#0000FF", labels_here = "SDM", length_arrowhead, max_tips)
    }
    if(inherits(median_summs, "phylo")){ # lime
        foo(phy = median_summs, color_here = "#00FF00", labels_here = "Median", length_arrowhead, max_tips)
    }
    text(labels = summs_title, x = -xlim0, y = max_tips*0.925, cex = 1.5, adj = 0, font = 2)
    if(add_legend){
        leg <- paste(taxon, c(leg, "median summary chronogram", "SDM summary chronogram"))
        legend(x = -xlim0, y = max_tips*1.35, legend = leg, cex = 0.9, pch = 19,
            bty = "n", xpd = NA, col = c(leg_color, "#00FF00", "#0000FF"), inset = -1)
    }
}

make_lttplot_summchrono <- function(taxon, tax_phyloall, tax_summary, sdm_summs3, median_summs3,
        filename = "LTTplot_summary_chronograms",
        add_legend = TRUE, tax_datedotol = NULL){
    leg <- "source chronograms"
    leg_color <- "#77889980"
    trees <- tax_phyloall
    max_agesall <- sapply(trees, function(x) max(ape::branching.times(x)))
    if(inherits(tax_datedotol, "phylo")){
        tax_datedotol <- ape::collapse.singles(tax_datedotol)
        tax_datedotol <- phytools::force.ultrametric(tax_datedotol)
        trees <- c(trees, tax_datedotol)
        leg <- c(leg, "dated OToL tree")
        leg_color <- c(leg_color, "#80808080")
        max_agesall <- c(max_agesall, max(ape::branching.times(tax_datedotol)))
    }
    xlim0 <- round(max(max_agesall)+5, digits = -1)
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    # general variables for source chronogram plotting:
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
    treesall <- c(trees, sdm_summs3, median_summs3)
    max_tips <- max(sapply(treesall, function(x) max(ape::Ntip(x))))
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    # start the plot:
    file_name = paste0("docs/plots/", taxon, "_", filename, ".pdf")
    grDevices::pdf(file = file_name, height = 9, width = 7)
    par(omi = c(0.5,0,0.35,0))
    par(mfrow = c(3,1))
    par(mai = c(0.2, 0.82, 0.2, 0.2))
    lttplot_summaries(taxon, trees, sdm_summs3$min_tree, median_summs3$min_tree, summs_title = "Min distances", xlim0,
            tax_phyloall, tax_summary, study_number, max_tips, max_ages, col_phyloall_sample, add_legend = TRUE, leg, leg_color)
    lttplot_summaries(taxon, trees, sdm_summs3$mean_tree, median_summs3$mean_tree, summs_title = "Mean distances", xlim0,
            tax_phyloall, tax_summary, study_number, max_tips, max_ages, col_phyloall_sample)
    lttplot_summaries(taxon, trees, sdm_summs3$max_tree, median_summs3$max_tree, summs_title = "Max distances", xlim0,
            tax_phyloall, tax_summary, study_number, max_tips, max_ages, col_phyloall_sample)
    mtext(text = "Time (MYA)", side= 1, cex = 0.85, adj = 0.5, font = 1, outer = TRUE, line = 2)
    dev.off()
}

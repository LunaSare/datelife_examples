make_lttplot_data1 <- function(taxon, crossval, tax_summary, tax_phyloall,
  dating_method = "BLADJ", filename = "LTTplot_data_"){
    names(crossval) <- names(tax_phyloall)
    crossval <- crossval[!is.na(crossval)]
    crossval <- crossval[sapply(crossval, ape::Ntip) > 2]
    max_ages <- tax_summary$mrca
    max_tips <- max(sapply(tax_phyloall, function(x) max(ape::Ntip(x))))
    studiesall <- sort(unique(names(tax_phyloall))) # same as unique(names(tax_phyloall))[order(unique(names(tax_phyloall)))]
    studies <- sort(unique(names(crossval)))
    xlim0 <- round(max(max_ages) + 5, digits = -1)
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    # general variables for source chronogram plotting:
    study_number <- seq(length(studiesall))[match(names(tax_phyloall), studiesall)]
    ss <- which(table(study_number)>1)
    col_sample <- paste0("#778899", sample(20:90, length(studiesall))) #lightslategrey
    col_phyloall_sample <- col_sample[match(names(tax_phyloall), studiesall)]
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
    rowsies <- ceiling(length(studies)*0.5)
    if(rowsies == 1){
      hh <- 3.5
    }
    if(rowsies == 2){
      hh <- 6.5
    }
    if(rowsies > 2){
      hh <- 9
    }
    grDevices::pdf(file = file_name, height = hh, width = 7)
    par(omi = c(0.5,0,0.35,0))
    par(mfrow = c(rowsies, 2)) # graph ltts in two columns
    for(i in studies){
      if(i %in% studies[seq(1, length(studies), 2)]){
        par(mai = c(0.2, 0.82, 0.2, 0))
      } else {
        par(mai = c(0.2, 0.5, 0.2, 0.3))
      }
        trees <- crossval[names(crossval) %in% i]
        col_phyloall_sample <- rep("#77889920", length(tax_phyloall))
        col_phyloall_sample[which(names(tax_phyloall) %in% i)] <- paste0("#9932CC", 50) #dark orchid
        lttplot_data(taxon, trees, tax_phyloall, max_ages, max_tips, tax_summary,
          study_number, xlim0, col_phyloall_sample, dating_method, add_legend =
          ifelse(studies[1] == i, TRUE, FALSE), add_xlabel =
          ifelse(i %in% studies[c(length(studies), length(studies)-1)], TRUE, FALSE),
          add_ylabel = ifelse(i %in% studies[seq(1, length(studies), 2)], TRUE, FALSE))
        text(labels = paste("Study", which(studiesall %in% i)), x = -xlim0, y = max_tips*0.925, cex = 1.5, adj = 0, font = 2)
    }
    dev.off()
}
lttplot_data <- function(taxon, trees, tax_phyloall, max_ages, max_tips, tax_summary,
  study_number, xlim0, col_phyloall_sample, dating_method, add_legend = FALSE,
  add_xlabel = FALSE, add_ylabel = FALSE){
    if(add_ylabel){
      ylabel <- paste(taxon, "Species N")
    } else {
      ylabel <- ""
    }
    length_arrowhead <- 0.075
    lwd_phyloall <- 1.5
    y_numbers <- rep(-max_tips*0.14, length(max_ages))
    cond1 <- duplicated(round(max_ages)) & !duplicated(study_number)
    y_numbers[cond1] <- -max_tips*0.23
    ape::ltt.plot(trees[[1]], xlim = c(-xlim0, 0),
          ylim = c(-max_tips*0.30, max_tips), xlab = "",
          col = paste0("#ffffff", "10"), ylab = ylabel, cex.lab = 1.3) # we need to plot it white because argument plot = FALSE is not working with ltt.plot
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
    for(i in seq(trees)){
        foo(trees[[i]], "#008000", dating_method, length_arrowhead, max_tips) # green
    }
    if(add_legend){
        leg <- paste(taxon, c("source chronograms used as calibrations",
        "source chronograms used only as topology", "newly generated chronograms"))
        legend(x = -xlim0, y = max_tips*1.38, legend = leg, cex = 0.9, pch = 19,
            bty = "n", xpd = NA, col = c("#77889980", "#9932CC80", "#00800080"), inset = -1)
    }
    if(add_xlabel){
        mtext(text = "Time (MYA)", side= 1, cex = 1, adj = 0.5, font = 1,
        outer = FALSE, line = 2.5)
    }
}

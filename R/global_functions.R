#functions
make_lttplot_phyloall <- function(taxon, tax_phyloall, tax_datedotol, tax_phylomedian, filename = "LTTplot_phyloall"){
  file_name = paste0("docs/plots/", taxon, "_", filename, ".pdf")
  grDevices::pdf(file = file_name, height = 3, width = 7)
  par(mai = c(1.02, 0.82, 0.2, 0.42))
  trees <- c(tax_phyloall, tax_datedotol, tax_phylomedian$phylo_median)
  class(trees) <- "multiPhylo"
  # class(tax_phyloall)
  # ape::is.ultrametric(tax_phyloall)
  max_age <- max(sapply(trees, function(x) max(ape::branching.times(x))))
  max_tips <- max(sapply(trees, function(x) max(ape::Ntip(x))))
  # ape::is.ultrametric(tax_datedotol)
  # ape::is.binary(tax_datedotol)
  tax_datedotol <- ape::collapse.singles(tax_datedotol)
  tax_datedotol <- phytools::force.ultrametric(tax_datedotol)
  col_datedotol <- "#808080" #gray
  col_phylomedian <- "#ffa500"  # orange
  col_phyloall <- "#cce5ff"
  ape::ltt.plot(tax_datedotol, xlim = c(-max_age, 0), ylim = c(0, max_tips), 
                col = paste0(col_datedotol, "80"), ylab = paste(taxon, "Species"), 
                xlab = "Time (myrs)")
  ape::ltt.lines(phy = tax_phylomedian$phylo_median, col = paste0(col_phylomedian, "80"))
  for (i in seq(length(tax_phyloall))){
    ape::ltt.lines(phy = tax_phyloall[[i]], col = paste0(col_phyloall, "80"))
  }
  leg <- paste(taxon, c("Dated OToL", "Median Summary Chronogram", 
                        "Source Chronograms"))
  legend(x = "topleft", #round(-max_age, digits = -1), 
         # y = round(max_tips, digits = -2), 
         legend = leg, col = c(col_datedotol, col_phylomedian, col_phyloall),
         cex = 0.5, pch = 19, bty = "n")
  dev.off()
}
# , tax_sdm_bladj, tax_med_bladj
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
get_sdm_matrix <- function(datelife_result){
  unpadded.matrices <- lapply(datelife_result, patristic_matrix_unpad)
  good.matrix.indices <- get_goodmatrices(unpadded.matrices, verbose = TRUE)
  if(length(good.matrix.indices) > 1) {
    unpadded.matrices <- unpadded.matrices[good.matrix.indices]
    sdm_matrix <- get_sdm(unpadded.matrices, weighting = "flat", verbose = TRUE)
  }
  return(sdm_matrix)
}
get_bladjtree <- function(dated_tree, backbone){
  res <- tryCatch(tree_add_dates(dated_tree = dated_tree,
                                 missing_taxa = backbone,
                                 dating_method = "bladj"),
                  error = function(e) NA)
  return(res)
}
get_treefromtax <- function(tax_dq, source){
  # tree_from_taxonomy(taxa = tax_dqall[[i]]$cleaned_names, sources = "Open Tree of Life Reference Taxonomy")
  # using sources = "Open Tree of Life Reference Taxonomy" gives an error, using NCBI for now
  # taxonomy trees are not well resolved at all, so its not even possible to plot them sometimes
  # tree_from_taxonomy(taxa = tax_dqall[[1]]$cleaned_names, sources = "Catalogue of Life")
  # unname(tax_dqall[[5]]$cleaned_names)
  res <- tryCatch(tree_from_taxonomy(taxa = tax_dq$cleaned_names, sources = source),
                    error = function(e) NA)
  return(res)
}
rm_brlen <- function(tree){
  res <- tree[c("edge", "tip.label", "Nnode")]
  class(res) <- "phylo"
  res
}
rm_brlen.multiPhylo <- function(trees){
  res <- lapply(trees, rm_brlen)
  class(res) <- "multiPhylo"
  res
}
use_eachcal_crossval <- function(trees, eachcal){
  res <- lapply(seq(trees), function(i) use_each_cal(tree = trees[[i]], eachcal))
  res
}
use_each_cal <- function(tree, eachcal){
  res <- lapply(seq(eachcal), function(i){
    xx <- suppressMessages(suppressWarnings(use_all_calibrations(phy = tree, eachcal[[i]])))
    return(xx$phy)
  })
  !sapply(res, is.null)
}
compute_ape_brlens <- function(tree){
    if(!multi2di_test(tree)){
      return(NA)
    }
    tree <- ape::multi2di(tree)
    tree <- ape::ladderize(tree)
    tree <- ape::compute.brlen(tree)
    tree
}
utils::data("strat2012", package = "phyloch")
make_plot_global <- function(tree, title, taxon, tax_summ, omi3, filename){
  if(!inherits(tree, "phylo")){
    return(NA)
  }
  if(!multi2di_test(tree)){
    return(NA)
  }
  if(ape::Ntip(tree) < 30){
    make_plot1(tree, title, taxon, filename, height = 4)
  } else {
      if(ape::Ntip(tree) < 150){
          cex <- 1
      } else if (ape::Ntip(tree) < 300){
          cex <- 0.8
      } else {
          cex <- 0.6
      }
    make_plot2(tree, title, taxon, tax_summ, omi3, filename, cex = cex)
  }
}
# require(geiger)
# require (phytools)
# tree<-rescale(sim.bdtree(b=1,d=0,stop= "taxa", n= 100),"BM", 0.3)
# mtree<-sim.history(tree,Q=matrix(c(-1,1,1,-1),2,2))
# mtrees<-make.simmap(tree,mtree$states,nsim=10)
# names(mtrees[[1]])
# mtrees[[1]]$maps
# names(mtrees[[1]]$maps[[1]])
# plotSimmap(mtrees[[1]])
make_plot1 <- function(tree, title = NULL, taxon, filename = "test", time_depth = NULL, axis_type = 1,
    cex = graphics::par("cex"), mai4 = NULL, write = "pdf", GTS = strat2012,
    height = 7, width = 6){
  # plot_phylo(tree = tree, title = title, write = "pdf", file_name = paste0("docs/", taxon, "_", filename, ".pdf"), cex = 0.75)
  file_name = paste0("docs/plots/", taxon, "_", filename, ".pdf")
  if(is.null(time_depth) & !is.null(tree$edge.length)){
    if(is.null(tree$root.edge)){
      time_depth <- round(max(ape::branching.times(tree)) + 5, digits = -1)
    } else {
      time_depth <- max(ape::branching.times(tree)) + tree$root.edge
    }
  }
  if(is.null(mai4)){
    ind <- which.max(nchar(tree$tip.label))
    mai4 <- graphics::strwidth(s = tree$tip.label[ind], units = "inches", cex = cex, font = 3)
  }
  # ho <- phylo_height_omi(tree = tree) # from original plot_phylo datelife function
  ho <- list(height = height*72, omi1 = 1)  # hieght is in pixels in plot_phylo
  if(any(c("png", "pdf") %in% write)){
    if("png" %in% write){
      grDevices::png(file = file_name, height = ho$height, width = width)
    } else {
      grDevices::pdf(file = file_name, height = ho$height/72, width = width)
    }
  }
  graphics::par(xpd = NA, mai = c(0,0,0,mai4), omi = c(ho$omi1, 0, 1, 0))
  # plot_chronogram.phylo(trees[[i]], cex = 1.5, edge.width = 2, label.offset = 0.5,
    # x.lim = c(0, max.depth), root.edge = TRUE, root.edge.color = "white")
  if(is.null(tree$edge.length)){
      ape::plot.phylo(tree, cex = cex, #edge.width = 2,
        label.offset = 0.5, plot = TRUE)  #, ...
  } else {
      ape::plot.phylo(tree, cex = cex, #edge.width = 2,
        label.offset = 0.5, x.lim = c(0, time_depth), root.edge = TRUE, plot = TRUE)  #, ...
  }
  graphics::par(xpd = FALSE)
  if(!is.null(tree$edge.length)){
      if(axis_type == 1){
        phyloch::axisGeo(GTS = GTS, unit = c("period"),
            col = c("gray80", "white"), gridcol = c("gray80", "white"), cex = 0.5,
            gridty = "twodash")
      }
      if(axis_type == 2){
        phyloch::axisGeo(GTS = GTS, unit = c("period","epoch"),
            col = c("gray80", "white"), gridcol = c("gray80", "white"), cex = 0.5,
            gridty = "twodash")
      }
      graphics::mtext("Time (MYA)", cex = cex, side = 1, font = 2, line = (ho$omi1-0.2)/0.2,
      outer = TRUE, at = 0.4)
  } else (
      message("tree has no edge.length, so time axis will not be plotted")
  )
  if(!is.null(title)){
    titlei <- wrap_string_to_plot(string = title, max_cex = 1, whole = FALSE)
    graphics::mtext(text = titlei$wrapped, outer = TRUE,
      cex = titlei$string_cex, font = titlei$string_font, line = 1)
  }
  if(any(c("png", "pdf") %in% write)){
    grDevices::dev.off()
  }
}
make_plot2 <- function(tree, title, taxon, tax_summ, omi3, filename, cex = 0.75){
  # nn <- sapply(1:ncol(tax_summ$matrix), function(i) sum(tax_summ$matrix[,i]))
  # frac <- nn/nrow(tax_summ$matrix)*100
  # names(frac) <- colnames(tax_summ$matrix)
  # x1 <- gsub(" ", "_", colnames(tax_summ$matrix))
  # x2 <- gsub(" ", "_", tree$tip.label)
  # fracmatches <- frac[x1 %in% x2]
  # is.binary(tree)
  # tree$edge
  # plot(tree)
  # edgelabels()
  # nodelabels()
  # names(tree)
  # t2 <- tree
  # tree$edge.length
  # fracmatches <- rep(1, ape::Ntip(tree))
  # names(fracmatches) <- tree$tip.label
  # all_values <- sum_tips(tree, fracmatches)
  # cols <- setNames(c("blue","pink"), c("hello", "bye"))
  if(!multi2di_test(tree)){ # trees giving C seg fault error cannot be plotted as fan, this tests that
    return(NA)
  }
  file_name <- paste0("docs/plots/", taxon, "_", filename, ".pdf")
  tree <- ape::collapse.singles(tree) # this is very important to match edges accurately
  prob <- 0.5
  names(prob) <- "black"
  tree$maps <- rep(list(prob), length(tree$edge.length))
  pdf(file = file_name)
  graphics::par(xpd = NA, omi = c(0,0,omi3,0))
  # even computing brlens, plotSimmap does not work with some trees, so tryCatch:
  fail <- FALSE
  fail <- tryCatch(plotSimmap(tree, type="fan", part= 0.97, fsize= cex*0.5, ftype="i", lwd= 0.9, offset = 10),
    error = function(e) TRUE) # when plotSimmap is sucesfil, fail == 0, as logical this is interpreted as FALSE
  if(fail){
      if(is.null(tree$edge.length)){
          tree <- ape::compute.brlen(tree)
      }
    plot.phylo(tree, type = "fan", cex = cex, label.offset = 0.05)
  }
  # title = paste0(taxon, " Species Presence across chronograms in DateLife Data Base")
  if(!is.null(title)){
      titlei <- wrap_string_to_plot(string = title, max_cex = 1, whole = FALSE)
      graphics::mtext(text = titlei$wrapped, outer = TRUE,
        cex = titlei$string_cex, font = titlei$string_font, line = 1)
  }
  dev.off()
}
make_report <- function(mdname){
  knitr::knit(knitr_in("docs/report_global.Rmd"), file_out(mdname), quiet = TRUE)
}
render_pdf <- function(reportname, dir, placeholder) {
    original.dir <- getwd()
    setwd(dir)
    system(paste0('pandoc ', paste0(reportname, '.md'), ' -o ', paste0(reportname, '.pdf --pdf-engine=xelatex -V mainfonts="DejaVu Sans"')))
    setwd(original.dir)
    # pandoc -o emoji.pdf --pdf-engine=lualatex -V mainfonts="DejaVu Sans"
    # pandoc -o emoji.pdf --pdf-engine=xelatex  -V mainfonts="DejaVu Sans"
}
#function from phunding package:
sum_tips <-  function(tree, values) {
    # tree <- ape::reorder.phylo(tree, "postorder")  # no need to reorder the whole tree
    res <- numeric(max(tree$edge))
    res[1:ape::Ntip(tree)] <- values[match(names(values), tree$tip.label)]
    for (i in ape::postorder(tree))  { # ape postorder doesn't include root
         tmp <- tree$edge[i,1]
         # print(i)
         res[tmp] <- res[tmp] + res[tree$edge[i, 2]]
         # print(res)
   }
   res
}

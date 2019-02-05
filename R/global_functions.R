#functions
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
  file_name = paste0("docs/", taxon, "_", filename, ".pdf")
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
  file_name <- paste0("docs/", taxon, "_", filename, ".pdf")
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
    system(paste0("pandoc ", paste0(reportname, ".md"), " -o ", paste0(reportname, ".pdf")))
    setwd(original.dir)
}

datelife_source <- function(taxon){
    tax_dq = make_datelife_query(input = taxon, get_spp_from_taxon = TRUE)
  	tax_dr = get_datelife_result(input = tax_dq)
    tax_phyloall = suppressMessages(summarize_datelife_result(datelife_query = tax_dq, datelife_result = tax_dr, summary_format = "phylo_all"))
    res <- list(tax_dq, tax_dr, tax_phyloall)
    return(res)
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

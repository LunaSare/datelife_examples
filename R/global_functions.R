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
make_plot_global <- function(tax_datedotol, title, taxon, tax_summ, omi3){
  if(!inherits(tax_datedotol, "phylo")){
    return(NA)
  }
  if(ape::Ntip(tax_datedotol) < 30){
    make_plot1(tax_datedotol, title, taxon)
  } else {
    make_plot2(tax_datedotol, title, taxon, tax_summ, omi3)
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

make_plot1 <- function(tax_datedotol, title, taxon){
  plot_phylo(tree = tax_datedotol, title = title, write = "pdf", file_name = paste0("docs/datedotol_", taxon, ".pdf"), cex =0.75)
}
make_plot2 <- function(tax_datedotol, title, taxon, tax_summ, omi3){
  # nn <- sapply(1:ncol(tax_summ$matrix), function(i) sum(tax_summ$matrix[,i]))
  # frac <- nn/nrow(tax_summ$matrix)*100
  # names(frac) <- colnames(tax_summ$matrix)
  # x1 <- gsub(" ", "_", colnames(tax_summ$matrix))
  # x2 <- gsub(" ", "_", tax_datedotol$tip.label)
  # fracmatches <- frac[x1 %in% x2]
  # is.binary(tax_datedotol)
  # tax_datedotol$edge
  # plot(tax_datedotol)
  # edgelabels()
  # nodelabels()
  # names(tax_datedotol)
  # t2 <- tax_datedotol
  # tax_datedotol$edge.length
  # fracmatches <- rep(1, ape::Ntip(tax_datedotol))
  # names(fracmatches) <- tax_datedotol$tip.label
  # all_values <- sum_tips(tax_datedotol, fracmatches)

  # cols <- setNames(c("blue","pink"), c("hello", "bye"))
  tax_datedotol <- ape::collapse.singles( tax_datedotol) # this is very important to match edges accurately
  prob <- 0.5
  names(prob) <- "black"
  tax_datedotol$maps <- rep(list(prob), length(tax_datedotol$edge.length))
  pdf(file = paste0("docs/datedotol_", taxon, ".pdf"))
  graphics::par(xpd = NA, omi = c(0,0,omi3,0))
  plotSimmap(tax_datedotol, type="fan", part= 0.97, fsize=0.2, ftype="i", lwd= 0.9, offset = 10)
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
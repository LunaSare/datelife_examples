#functions
utils::data("strat2012", package = "phyloch")
make_plot1 <- function(tax_datedotol, taxon){
  plot_phylo(tree = tax_datedotol, write = "pdf", file_name = paste0("datedotol_", taxon, ".pdf"), cex =0.75)
}
make_plot2 <- function(tax_datedotol, tax_summ){
  nn <- sapply(1:ncol(tax_summ$matrix), function(i) sum(tax_summ$matrix[,i]))
  frac <- nn/nrow(tax_summ$matrix)*100
  names(frac) <- colnames(tax_summ$matrix)
  x1 <- gsub(" ", "_", colnames(tax_summ$matrix))
  x2 <- gsub(" ", "_", tax_datedotol$tip.label)
  fracmatches <- frac[x1 %in% x2] 
  is.binary(tax_datedotol)
  tax_datedotol$edge
  plot(tax_datedotol)
  edgelabels()
  nodelabels()
  names(tax_datedotol)
  t2 <- tax_datedotol
  tax_datedotol <- ape::collapse.singles(t2)
  tax_datedotol$edge.length
  fracmatches <- rep(1, ape::Ntip(tax_datedotol))
  names(fracmatches) <- tax_datedotol$tip.label
  all_values <- sum_tips(tax_datedotol, fracmatches)
  edge_cols <- rep("blue", length(tax_datedotol$edge.length))
  namess <- rep("hello", length(edge_cols))
  
  cols <- setNames(c("blue","pink"), c("hello", "bye"))

  tax_datedotol$maps <- as.list(rep(1, length(edge_cols)))

  plotSimmap(tax_datedotol, type="fan",part= 0.9, fsize=0.3, ftype="i", colors = edge_cols)
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
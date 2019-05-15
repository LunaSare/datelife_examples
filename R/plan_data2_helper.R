tax_phyloall_boldi <- tax_phyloall_bold[[1]]
bold_is_phylo <- function(tax_phyloall_boldi){
    sapply(unname(tax_phyloall_boldi), inherits, "phylo")
}
bold_has_brlen <- function(tax_phyloall_boldi){
    pp <- bold_is_phylo(tax_phyloall_boldi)
    res <- sapply(seq(pp), function(i){
        if(pp[i]){
            !is.null(tax_phyloall_boldi[[i]]$edge.length)
        } else {
            FALSE
        }
    })
    return(res)
}
lapply(tax_phyloall_bold, bold_is_phylo)

lapply(tax_phyloall_bold, bold_has_brlen)
bold_is_phylo(tax_phyloall_bold[[1]])
bold_has_brlen(tax_phyloall_bold[[1]])
for(i in seq(tax_phyloall_bold[[1]])){
    print(i)
    plot(tax_phyloall_bold[[1]][[i]], cex =0.75, main = paste("Tree", i))
    ape::axisPhylo()
}

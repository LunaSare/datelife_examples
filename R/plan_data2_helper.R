tax_phyloall_boldi <- tax_phyloall_bold[[1]]

lapply(tax_phyloall_bold, bold_is_phylo)

lapply(tax_phyloall_bold, bold_has_brlen)
bold_is_phylo(tax_phyloall_bold[[1]])
bold_has_brlen(tax_phyloall_bold[[1]])
for(i in seq(tax_phyloall_bold[[1]])){
    print(i)
    plot(tax_phyloall_bold[[1]][[i]], cex =0.75, main = paste("Bold Tree", i))
    ape::axisPhylo()
}
for(i in seq(tax_phyloall_bold)){
    xx <- use_othercals4(taxa[i], tax_phyloall_bold[[i]], tax_othercalall[[i]], expand = 0)
    sapply(xx, inherits, "phylo")
    print(taxa[i])
    for(j in seq(xx)){
        # print(j)
        # print(xx[[j]]$edge.length)
        if(inherits(tax_phyloall_bold[[i]][[j]], "phylo")){
            par(mfrow = c(1,2))
            par(mai = c(1,0,1,0))
            plot(tax_phyloall_bold[[i]][[j]], cex =0.75, main = paste(taxa[i], "Bold Tree", j))
            ape::axisPhylo()
        } else {
            next
        }
        par(mai = c(1,0,1,0))
        if(inherits(xx[[j]], "phylo")){
            plot(xx[[j]], cex =0.75, main = paste(taxa[i], "Bold Tree pathd8 summ", j))
            ape::axisPhylo()
        } else {
            plot(tax_phyloall_bold[[1]][[j]], plot = FALSE)
        }
    }
}
xx <- use_othercals4(taxa[1], tax_phyloall_bold[[1]], tax_othercalall[[1]], expand = 0)
use_calibrations_pathd8(tax_phyloall_bold[[1]][[2]],
    calibrations = tax_othercalall[[1]][[2]], expand = 0)
tax_othercalall[[1]][i]
sapply(xx, inherits, "phylo")
all(is.na(xx[[i]]$edge.length))
chronogram <- xx[[i]]
for( i in seq(xx)){
    if(inherits(xx[[i]], "phylo")){
        print(i)
        print(xx[[i]]$edge.length)
        par(mfrow = c(1,2))
        par(mai = c(1,0,1,0))
        plot(tax_phyloall_bold[[1]][[i]], cex =0.75, main = paste("Bold Tree", i))
        ape::axisPhylo()
        par(mai = c(1,0,1,0))
        plot(xx[[i]], cex =0.75, main = paste("Bold Tree pathd8 expand = 0", i))
        ape::axisPhylo()
    }
}
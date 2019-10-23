i <- 3
tax_phyloall_boldi <- tax_phyloall_boldall[[i]]

lapply(tax_phyloall_boldall, bold_is_phylo)

lapply(tax_phyloall_boldall, bold_has_brlen)
bold_is_phylo(tax_phyloall_boldall[[i]])
bold_has_brlen(tax_phyloall_boldall[[i]])
for(j in seq(tax_phyloall_boldall[[i]])){
    print(j)
    plot(tax_phyloall_boldall[[i]][[j]], cex =0.75, main = paste("Bold Tree", j))
    ape::axisPhylo()
}
for(i in seq(tax_phyloall_boldall)){
    xx <- use_othercals4(taxa[i], tax_phyloall_boldall[[i]], tax_othercalall[[i]], expand = 0)
    xx <- crossval_pathd8_exp1_3
    sapply(xx, inherits, "phylo")
    print(taxa[i])
    for(j in seq(xx)){
        # print(j)
        # print(xx[[j]]$edge.length)
        if(inherits(tax_phyloall_boldall[[i]][[j]], "phylo")){
            par(mfrow = c(1,2))
            par(mai = c(1,0,1,0))
            plot(tax_phyloall_boldall[[i]][[j]], cex =0.75, main = paste(taxa[i], "Bold Tree", j))
            ape::axisPhylo()
        } else {
            next
        }
        par(mai = c(1,0,1,0))
        if(inherits(xx[[j]], "phylo")){
            plot(xx[[j]], cex =0.75, main = paste(taxa[i], "Bold Tree pathd8 summ", j))
            if(is.null(xx[[j]]$problem)){
                ape::axisPhylo()
            } else {
                mtext("Tree has no branch lengths or are relative to 1. PATHd8 issues...", side = 1)
            }
        } else {
            plot(tax_phyloall_boldall[[1]][[j]], plot = FALSE)
        }
    }
}
xx <- use_othercals4(taxa[i], tax_phyloall_boldall[[i]], tax_othercalall[[i]], expand = 0)
use_calibrations_pathd8(tax_phyloall_boldall[[i]][[2]],
    calibrations = tax_othercalall[[i]][[2]], expand = 0)
tax_othercalall[[i]][j]
sapply(xx, inherits, "phylo")
all(is.na(xx[[i]]$edge.length))
chronogram <- xx[[i]]
for(j in seq(xx)){
    if(inherits(xx[[j]], "phylo")){
        print(j)
        print(xx[[j]]$edge.length)
        par(mfrow = c(1,2))
        par(mai = c(1,0,1,0))
        plot(tax_phyloall_boldall[[i]][[j]], cex =0.75, main = paste("Bold Tree", j))
        ape::axisPhylo()
        par(mai = c(1,0,1,0))
        plot(xx[[j]], cex =0.75, main = paste("Bold Tree pathd8 expand = 0", j))
        ape::axisPhylo()
    }
}
str(crossval_pathd8_exp1$Fringillidae[1])
sapply(crossval_pathd8_exp1$Fringillidae, inherits, "phylo")
mm <- make_bold_otol_tree(tax_phyloallall[[3]][[13]])
plot(mm, cex = 0.5)
ape::axisPhylo()
plot(tax_phyloallall[[3]][[13]])
tax_phyloall_bold3 <- get_bold_trees(taxa[3], tax_phyloallall[[3]])
crossval_pathd8_exp1_3 <- use_othercals4(taxa[3], tax_phyloall_bold3, tax_othercalall[[3]], expand = 0)
sapply(crossval_pathd8_exp1_3, inherits, "phylo")
for(j in seq(crossval_pathd8_exp1_3)){
    if(inherits(tax_phyloall_bold3[[j]], "phylo")){
        par(mfrow = c(1,2))
        par(mai = c(1,0,1,0))
        plot(tax_phyloall_bold3[[j]], cex =0.75, main = paste(taxa[3], "Bold Tree", j))
        ape::axisPhylo()
    } else {
        next
    }
    par(mai = c(1,0,1,0))
    if(inherits(crossval_pathd8_exp1_3[[j]], "phylo")){
        plot(crossval_pathd8_exp1_3[[j]], cex =0.75, main = paste(taxa[3], "Bold Tree pathd8 summ", j))
        if(is.null(crossval_pathd8_exp1_3[[j]]$problem)){
            ape::axisPhylo()
        } else {
            mtext("Tree has no branch lengths or are relative to 1. PATHd8 issues...", side = 1)
        }
    } else {
        plot(tax_phyloall_bold3[[j]], plot = FALSE)
    }
}
make_lttplot_data1(taxa[3], crossval_pathd8_exp1_3, tax_summaryall[[3]], tax_phyloallall[[3]],
  dating_method = "PATHd8", filename = "lttplot_crossval_pathd8_exp1")

make_bold_otol_tree(input = tax_phyloallall[[3]][4], chronogram = TRUE)
tax_phyloall_boldall[[3]] <- get_bold_trees(taxon = taxa[3], phyloall = tax_phyloallall[[3]])
crossval_pathd8_exp1 <- vector(mode = "list", length = length(tax_phyloall_boldall))
crossval_pathd8_exp1[[3]] <- use_othercals4(taxa[3], tax_phyloall_boldall[[3]], tax_othercalall[[3]])
crossval_pathd8_summ1 <- vector(mode = "list", length = length(tax_phyloall_boldall))
crossval_pathd8_summ1[[3]] <- use_othercals4(taxa[3], tax_phyloall_boldall[[3]], tax_othercalall[[3]], expand = 0)

i=13
use_calibrations_pathd8(tax_phyloall_boldall[[3]][[i]], calibrations = tax_othercalall[[3]][[i]], expand = 0.1)
sapply(crossval_pathd8_exp1[[3]], inherits, "phylo")
names(tax_phyloallall[[3]])[bold_has_brlen(crossval_pathd8_exp1[[3]])]

sapply(crossval_pathd8_summ1[[3]], inherits, "phylo")
names(tax_phyloallall[[3]])[bold_has_brlen(crossval_pathd8_summ1[[3]])]

for(i in seq(sim_otol_eachall[[1]])){
  plot(sim_otol_eachall[[1]][[i]])
  axisPhylo()
  mtext()
}

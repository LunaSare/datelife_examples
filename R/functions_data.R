# phyloall <- tax_phyloallall[[1]]
# get calibrations form all other chronograms not belonging to the same study
get_othercals <- function(phyloall){
    dd <- duplicated(names(phyloall))
    res <- lapply(seq(phyloall), function(i){
        dd <- names(phyloall) %in% names(phyloall)[i]
        get_all_calibrations(phyloall[!dd])
    })
    res
}
use_othercals1 <- function(trees, othercals){
    res <- lapply(seq(trees), function(i){
        xx <- suppressMessages(suppressWarnings(use_all_calibrations(phy = trees[[i]],
            all_calibrations = othercals[[i]])))
        return(xx$phy)
    })
    class(res) <- "multiPhylo"
    res
}
use_othercals2 <- function(trees, othercals){
    res <- lapply(seq(trees), function(i){
        xx <- suppressMessages(suppressWarnings(use_all_calibrations(phy = trees[[i]],
            all_calibrations = othercals[[i]], expand = 0)))
        return(xx$phy)
    })
    class(res) <- "multiPhylo"
    res
}
# yy <- use_othercals2(tax_phyloallall[[1]], tax_othercalall[[1]])
# i=5
# yy2 <- yy[!is.na(yy)]
# sapply(yy2, ape::Ntip)
# use_all_calibrations(phy = tax_phyloallall[[1]][[i]], all_calibrations = tax_othercalall[[1]][[i]], expand = 0)
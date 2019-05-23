# phyloall <- tax_phyloallall[[1]]
# get calibrations form all other chronograms not belonging to the same study
get_othercals <- function(phyloall){
    # dd <- duplicated(names(phyloall))
    res <- lapply(seq(phyloall), function(i){
        dd <- names(phyloall) %in% names(phyloall)[i]
        get_all_calibrations(phyloall[!dd])
    })
    res
}
use_othercals1 <- function(trees, othercals){
    res <- lapply(seq(trees), function(i){
      phy <- trees[[i]]
      phy$edge.length <- NULL
        xx <- suppressMessages(suppressWarnings(use_all_calibrations(phy,
            all_calibrations = othercals[[i]])))
        return(xx$phy)
    })
    class(res) <- "multiPhylo"
    res
}
use_othercals2 <- function(trees, othercals){
    res <- lapply(seq(trees), function(i){
      phy <- trees[[i]]
      phy$edge.length <- NULL
        xx <- suppressMessages(suppressWarnings(use_all_calibrations(phy,
            all_calibrations = othercals[[i]], expand = 0)))
        return(xx$phy)
    })
    class(res) <- "multiPhylo"
    res
}
# trees <- tax_phyloallall[[1]]
# othercals <- tax_othercalall[[1]]
# use_calibrations_bladj(phy, othercals[[i]])
use_othercals3 <- function(trees, othercals, ...){
    res <- lapply(seq(trees), function(i){
      phy <- trees[[i]]
      phy$edge.length <- NULL
      print(i)
        xx <- suppressMessages(suppressWarnings(use_calibrations_bladj(phy,
            calibrations = othercals[[i]], ...)))
        return(xx)
    })
    class(res) <- "multiPhylo"
    res
}

#returns bold tree for all topologies
get_bold_trees <- function(taxon, phyloall, chronogram = TRUE){
  # namesi <- unique(names(phyloall))
  # ddi <- which(!duplicated(names(phyloall)))
  # res <- lapply(ddi, function(i) {
  #   tryCatch(make_bold_otol_tree(input = phyloall[[i]]),
  #     error = function(e) NA)})
  print(taxon)
  res <- lapply(phyloall, function(x) {
    tryCatch(make_bold_otol_tree(input = x, chronogram = chronogram),
      error = function(e) NA)})
  names(res) <- names(phyloall)
  res
}
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
# trees <- tax_phyloall_boldi
use_othercals4 <- function(taxon, trees, othercals, expand = 0.1){
    print(taxon)
    bb <- bold_has_brlen(trees)
    res <- lapply(seq(trees), function(i){
      cat(i, " - ", bb[i], "\n")
      if(!bb[i]){ # pathd8 does not work with trees with no branch lengths
        return(NA)
      }
      xx <- suppressMessages(suppressWarnings(use_calibrations_pathd8(trees[[i]],
          calibrations = othercals[[i]], expand = expand)))
      return(xx)
    })
    # class(res) <- "multiPhylo"
    res
}

    # i <- 4
    # for(i in seq(length(taxa))){
    #   pdf(file = paste0("docs/treefromtax_1_", taxa[i], ".pdf"), height = 10)
    #   plot.phylo(tax_treefromtaxall[[4]]$phy, cex =0.75, plot = FALSE)
    #   dev.off()
    #   tree <- ape::multi2di(tax_treefromtaxall[[5]]$phy)
    #   pdf(file = paste0("docs/treefromtax_2_", taxa[i], ".pdf"), height = 10)
    #   plot.phylo(tree, cex =0.75)
    #   dev.off()
    # }
# phy <- tax_treefromtaxall[[4]]$phy
# for(i in seq(taxa)){
#   print(multi2di_test(tax_treefromtaxall[[i]]$phy))
# }
multi2di_test <- function(phy, random = TRUE){
    degree <- tabulate(phy$edge[, 1])
    target <- which(degree > 2)
    if (!length(target)) return(phy)
    n <- length(phy$tip.label)
    nb.edge <- dim(phy$edge)[1]
    nextnode <- n + phy$Nnode + 1L
    new.edge <- edge2delete <- NULL
    wbl <- FALSE
    if (!is.null(phy$edge.length)) {
        wbl <- TRUE
        new.edge.length <- NULL
    }
    for (node in target) {
        ind <- which(phy$edge[, 1] == node)
        N <- length(ind)
        desc <- phy$edge[ind, 2]
        if (random) {
          ## if we shuffle the descendants, we need to eventually
          ## reorder the corresponding branch lenghts (see below)
          ## so we store the result of sample()
            tmp <- sample(length(desc))
            desc <- desc[tmp]
            res <- rtree(N)$edge
        } else {
            res <- matrix(0L, 2*N - 2, 2)
            res[, 1] <- N + rep(1:(N - 1), each = 2)
            res[, 2] <- N + rep(2:N, each = 2)
            res[seq(1, by = 2, length.out = N - 1), 2] <- 1:(N - 1)
            res[length(res)] <- N
        }
       if (wbl) {
            ## keep the branch lengths coming from `node'
            el <- numeric(dim(res)[1]) # initialized with 0's
            el[res[, 2] <= N] <-
              if (random) phy$edge.length[ind][tmp] else phy$edge.length[ind]
        }
        ## now substitute the nodes in `res'
        ## `node' stays at the "root" of these new
        ## edges whereas their "tips" are `desc'
        Nodes <- c(node, nextnode:(nextnode + N - 3L))
        res[, 1] <- Nodes[res[, 1] - N]
        tmp <- res[, 2] > N
        res[tmp, 2] <- Nodes[res[tmp, 2] - N]
        res[!tmp, 2] <- desc[res[!tmp, 2]]
        new.edge <- rbind(new.edge, res)
        edge2delete <- c(edge2delete, ind)
        if (wbl) new.edge.length <- c(new.edge.length, el)
        nextnode <- nextnode + N - 2L
        phy$Nnode <- phy$Nnode + N - 2L
    }
    phy$edge <- rbind(phy$edge[-edge2delete, ], new.edge)
    phy <- reorder(phy, "cladewise", FALSE, n, 1L)
    newNb <- integer(phy$Nnode)
    newNb[1] <- n + 1L
    sndcol <- phy$edge[, 2] > n
    if(length(n + 2:phy$Nnode) != length(newNb[phy$edge[sndcol, 2] - n])){
      return(FALSE)
    } else {
      return(TRUE)
    }
}

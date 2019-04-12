---
title: "DateLife Workflows"
author: "Luna L. Sanchez Reyes"
date: "2019-03-01"
output: rmarkdown::html_vignette
geometry: "left=3cm,right=3cm,top=2.5cm,bottom=4cm"
vignette: >
  %\VignetteIndexEntry{DateLife Example}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---


\raggedright

# Taxon Hominidae

## I. Query data
There are 7 species in the Open Tree of Life Taxonomy for the taxon Hominidae.
Information on time of divergence is available for
all
of these species across 8 published and peer-reviewed chronograms from the following studies:

**1. Bininda-Emonds, Olaf R. P., Marcel Cardillo, Kate E. Jones, Ross D. E. MacPhee, Robin M. D. Beck, Richard Grenyer, Samantha A. Price, Rutger A. Vos, John L. Gittleman, Andy Purvis. 2007. The delayed rise of present-day mammals. Nature 446 (7135): 507-512**

**2. Hedges, S. Blair, Julie Marin, Michael Suleski, Madeline Paymer, Sudhir Kumar. 2015. Tree of life reveals clock-like speciation and diversification. Molecular Biology and Evolution 32 (4): 835-845**

**3. Springer, Mark S., Robert W. Meredith, John Gatesy, Christopher A. Emerling, Jong Park, Daniel L. Rabosky, Tanja Stadler, Cynthia Steiner, Oliver A. Ryder, Jan E. Janečka, Colleen A. Fisher, William J. Murphy. 2012. Macroevolutionary dynamics and historical biogeography of primate diversification inferred from a species supermatrix. PLoS ONE 7 (11): e49521.**

All source chronograms are fully ultrametric.
The proportion of Hominidae queried species found across source chronograms is as follows:

|   |Trees                           |Tips |Resolved |
|:--|:-------------------------------|:----|:--------|
|1  |Open Tree of Life Subtree       |6    |83%      |
|2  |Dated Open Tree of Life Subtree |6    |150%     |
|3  |Median Summary Chronogram       |7    |86%      |
|4  |SDM Summary Chronogram          |7    |86%      |


![Hominidae Species Dated Open Tree of Life Induced Subtree. This chronogram was obtained with `get_dated_otol_induced_subtree()` function.](plots/Hominidae_datedotol.pdf)


![Hominidae lineage through time (LTT) plots from source chronograms, summary median chronogram and dated Open Tree of Life chronogram.](plots/Hominidae_LTTplot_phyloall.pdf)


\newpage


## II. Summarize results.
### II.A. Diagnosing clustering issues.

We identified some issues with chronograms coming from SDM and Median summary matrices.
First, clustering algorithms implemented to go from a summary distance matrix to
a tree return trees that are too old (generally with UPGMA algorithms) or non-ultrametric
(generally with Neighbour Joining algorithms). In most studied cases, UPGMA returns
fully ultrametric trees but with very old ages (we had to multiply the matrix by
0.25 to get ages approximate to source chronograms ages, however this is a number
chosen at random, it was just the number that worked well. NJ returned reasonable
ages, but trees are way non ultrametric, as you can see in Fig. 3
and Fig. 4.

This taxon's SDM matrix has NO negative values.This taxon's Median matrix has NO negative values.


![Hominidae lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or with maximum ages that are just off (too old or too young). So we developped an alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Hominidae_LTTplot_Median.pdf)



![Hominidae lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or with maximum ages that are just off (too old or too young). So we developped an alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Hominidae_LTTplot_SDM.pdf)

### II.B. Age distributions form Median and SDM summary trees.

Comparison of summary chronograms reconstructed with min and max ages.


![Hominidae lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with `datelife` algorithm.](plots/Hominidae_LTTplot_summtrees_Median.pdf)



![Hominidae lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with `datelife` algorithm.](plots/Hominidae_LTTplot_summtrees_SDM.pdf)


\newpage


## III. Create new data


As an example, we're gonna date the Open Tree Synthetic tree (mainly because the taxonomic tree is usually less well resolved.)


Now, let's say you like the Open Tree of Life Taxonomy and you want to stick to that tree. Dates from available studies were tested over the Open Tree of Life Synthetic tree of Hominidae and a tree with 6 tips, 83 % resolved nodes and a MRCA of 9 was constructed.
We also tried  each source chronogram independently, with the Dated OToL and with each other, as a form of cross validation in Table 2. This is not working perfectly yet, but we are developping new ways to use all calibrations efficiently.

\newpage
\begin{table}[t]

\caption{\label{tab:unnamed-chunk-6}Was it successful to use each source chronogram independently as calibration (CalibN) against the Dated Open Tree of Life (dOToL) and each other (ChronoN)?}
\fontsize{7}{9}\selectfont
\begin{tabular}{llllllllll}
\toprule
  & dOToL & Chrono1 & Chrono2 & Chrono3 & Chrono4 & Chrono5 & Chrono6 & Chrono7 & Chrono8\\
\midrule
Calibrations1 & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
Calibrations2 & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
Calibrations3 & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
Calibrations4 & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
Calibrations5 & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
\addlinespace
Calibrations6 & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
Calibrations7 & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
Calibrations8 & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
\bottomrule
\end{tabular}
\end{table}
\newpage
## III. Simulate data
An alternative to generate a dated tree from a set of taxa is to take the available information and simulate into it the missing data.
We will take the median and sdm summary chronograms to date the Synthetic tree of Life:

```
#> Error in paste0("\n![", figcap_lttplot_sdm, "](plots/", taxon, "_LTTplot_sdm.pdf)\n"): object 'figcap_lttplot_sdm' not found
#> Error in cat(lttplot): object 'lttplot' not found
```

\newpage

## Appendix


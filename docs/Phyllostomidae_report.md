---
title: "DateLife Workflows"
author: "Luna L. Sanchez Reyes"
date: "2019-04-16"
output: rmarkdown::html_vignette
header-includes:
- \usepackage{booktabs}
- \usepackage{makecell}
- \usepackage{multirow}
- \usepackage{longtable}
geometry: "left=3cm,right=3cm,top=2.5cm,bottom=4cm"
vignette: >
  %\VignetteIndexEntry{DateLife Example}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}

---


\raggedright

# Taxon Phyllostomidae

## I. Query data
There are 223 species in the Open Tree of Life Taxonomy for the taxon Phyllostomidae.
Information on time of divergence is available for
170
of these species across 7 published and peer-reviewed chronograms.
Original study citations as well as proportion of Phyllostomidae species found across those source
chronograms is shown in Table 1.

All source chronograms are fully ultrametric.

```
#> Error in gsub("\\\\", "\\\\textbackslash", x): object 'Col1' not found
```


![Phyllostomidae Species Dated Open Tree of Life Induced Subtree. This chronogram was obtained with `get_dated_otol_induced_subtree()` function.](plots/Phyllostomidae_datedotol.pdf)


![Phyllostomidae lineage through time (LTT) plots from source chronograms, summary median chronogram and dated Open Tree of Life chronogram.](plots/Phyllostomidae_LTTplot_phyloall.pdf)


\newpage


## II. Summarize results.
### II.A. Diagnosing clustering issues.

We identified some issues with chronograms coming from SDM and Median summary matrices.
First, clustering algorithms used to go from a summary distance matrix to
a tree return trees that are too old (generally with UPGMA algorithms) or non-ultrametric
(generally with Neighbour Joining algorithms). In most studied cases, UPGMA returns
fully ultrametric trees but with very old ages (we had to multiply the matrix by
0.25 to get ages approximate to source chronograms ages, however this is a number
chosen at random, it was just the number that worked well). NJ returned reasonable
ages, but trees are way non ultrametric, as you can see in Fig. 3
and Fig. 4.

This taxon's SDM matrix has NO negative values.This taxon's Median matrix has NO negative values.


![Phyllostomidae lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or with maximum ages that are just off (too old or too young). So we developped an alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Phyllostomidae_LTTplot_Median.pdf)



![Phyllostomidae lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or with maximum ages that are just off (too old or too young). So we developped an alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Phyllostomidae_LTTplot_SDM.pdf)

### II.B. Age distributions form Median and SDM summary trees.

Comparison of summary chronograms reconstructed with min and max ages.


![Phyllostomidae lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with `datelife` algorithm.](plots/Phyllostomidae_LTTplot_summtrees_Median.pdf)



![Phyllostomidae lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with `datelife` algorithm.](plots/Phyllostomidae_LTTplot_summtrees_SDM.pdf)


\newpage


## III. Create new data


As an example, we're gonna date the Open Tree Synthetic tree (mainly because the taxonomic tree is usually less well resolved.)


Now, let's say you like the Open Tree of Life Taxonomy and you want to stick to that tree. Dates from available studies were tested over the Open Tree of Life Synthetic tree of Phyllostomidae and a tree was constructed, but all branch lengths are NA.
We also tried  each source chronogram independently, with the Dated OToL and with each other, as a form of cross validation in Table 2. This is not working perfectly yet, but we are developping new ways to use all calibrations efficiently.

\newpage
\begin{table}[t]

\caption{\label{tab:unnamed-chunk-5}Was it successful to use each source chronogram independently as calibration (CalibN) against the Dated Open Tree of Life (dOToL) and each other (ChronoN)?}
\fontsize{9}{11}\selectfont
\begin{tabular}{lllllllll}
\toprule
  & dOToL & Chrono1 & Chrono2 & Chrono3 & Chrono4 & Chrono5 & Chrono6 & Chrono7\\
\midrule
Calibrations1 & TRUE & TRUE & FALSE & FALSE & FALSE & TRUE & TRUE & TRUE\\
Calibrations2 & TRUE & TRUE & FALSE & FALSE & FALSE & TRUE & TRUE & TRUE\\
Calibrations3 & TRUE & TRUE & FALSE & FALSE & FALSE & TRUE & TRUE & TRUE\\
Calibrations4 & TRUE & TRUE & FALSE & FALSE & FALSE & TRUE & TRUE & TRUE\\
Calibrations5 & TRUE & TRUE & FALSE & FALSE & FALSE & TRUE & TRUE & TRUE\\
\addlinespace
Calibrations6 & TRUE & TRUE & FALSE & FALSE & FALSE & TRUE & TRUE & TRUE\\
Calibrations7 & TRUE & TRUE & FALSE & FALSE & FALSE & TRUE & TRUE & TRUE\\
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
The following species were completely absent from the chronogram data base:  *Anoura aequatoris**, **Anoura cadenai**, **Anoura carishina**, **Anoura fistulata**, **Anoura luismanueli**, **Anoura peruana**, **Artibeus aequatorialis**, **Artibeus bogotensis**, **Artibeus cf. jamaicensis**, **Artibeus cf. obscurus**, **Carollia brevicauda PS1**, **Carollia brevicauda PS2**, **Carollia monohernandezi**, **Chiroderma vizottoi**, **Diphylla ecuadata**, **Dryadonycteris capixaba**, **Glyphonycteris behnii**, **Hsunycteris cadenai**, **Hsunycteris pattoni**, **Lonchophylla concava**, **Lonchophylla fornicata**, **Lonchophylla orcesi**, **Lonchophylla orienticollina**, **Lonchophylla peracchii**, **Lophostoma kalkoae**, **Lophostoma yasuni**, **Micronycteris sanborni**, **Micronycteris yatesi**, **Mimon koepckeae**, **Neonycteris pusilla**, **Phylloderma stenops PS1**, **Phylloderma stenops PS2**, **Phyllonycteris major**, **Platyrhinus dorsalis**, **Platyrrhinus guianensis**, **Platyrrhinus helleri PS1**, **Platyrrhinus helleri PS2**, **Platyrrhinus helleri PS3**, **Sturnira angeli**, **Sturnira bakeri**, **Sturnira burtonlimi**, **Sturnira koopmanhilli**, **Sturnira mistratensis**, **Sturnira sorianoi**, **Trachops cirrhosus PS1**, **Trachops cirrhosus PS2**, **Trachops cirrhosus PS3**, **Uroderma bakeri**, **Uroderma convexum**, **Uroderma davisi**, **Urodmna magnirostrum**, **Vampyrodes caracdoli**, **Xeronycteris vieirai*

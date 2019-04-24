---
title: "DateLife Workflows"
author: "Luna L. Sanchez Reyes"
date: "2019-04-23"
output: rmarkdown::html_vignette
header-includes:
- \usepackage{booktabs}
- \usepackage{makecell}
- \usepackage{multirow}
- \usepackage{longtable}
- \usepackage{caption}
- \usepackage{array}
- \usepackage{wrapfig}
- \usepackage{float}
- \usepackage{colortbl}
- \usepackage{pdflscape}
- \usepackage{tabu}
- \usepackage{threeparttable}
- \usepackage{threeparttablex}
- \usepackage[normalem]{ulem}
- \usepackage{xcolor}
geometry: "left=2.5cm,right=2.5cm,top=2cm,bottom=2cm"
vignette: >
  %\VignetteIndexEntry{DateLife Example}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}

---


\raggedright

# Taxon Phyllostomidae

## I. Query source data
There are 223 species in the Open Tree of Life Taxonomy for the taxon Phyllostomidae.
Information on time of divergence is available for
170
of these species across 7 published and peer-reviewed chronograms.
Original study citations as well as proportion of Phyllostomidae species found across those source
chronograms is shown in Table 1.

All source chronograms are fully ultrametric.

\begin{longtable}{>{\raggedright\arraybackslash}p{0.4cm}>{\raggedright\arraybackslash}p{11cm}>{\raggedright\arraybackslash}p{1.5cm}>{\raggedright\arraybackslash}p{1.8cm}}
\caption{\label{tab:unnamed-chunk-2}Phyllostomidae source chronogram studies information.}\\
\toprule
\multicolumn{1}{>{\centering\arraybackslash}p{0.4cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{   }}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{11cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Citation}}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{1.5cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Source N}}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{1.8cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Taxon N}}\endgroup}\\
\midrule
\multicolumn{1}{r}{\em{\textbf{1.}}} & \bgroup\fontsize{8}{10}\selectfont Bininda-Emonds, Olaf R. P., Marcel Cardillo, Kate E. Jones, Ross D. E. MacPhee, Robin M. D. Beck, Richard Grenyer, Samantha A. Price, Rutger A. Vos, John L. Gittleman, Andy Purvis. 2007. The delayed rise of present-day mammals. Nature 446 (7135): 507-512\egroup{} & \multicolumn{1}{c}{3} & \multicolumn{1}{c}{138/223}\\
\multicolumn{1}{r}{\em{\textbf{2.}}} & \bgroup\fontsize{8}{10}\selectfont Dumont E.R., Davalos L.M., Goldberg A., Santana S.E., Rex K., \& Voigt C.C. 2012. Morphological innovation, diversification and invasion of a new adaptive zone. Proceedings of the Royal Society B: Biological Sciences, 279: 1797-1805.\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{141/223}\\
\multicolumn{1}{r}{\em{\textbf{3.}}} & \bgroup\fontsize{8}{10}\selectfont Hedges, S. Blair, Julie Marin, Michael Suleski, Madeline Paymer, Sudhir Kumar. 2015. Tree of life reveals clock-like speciation and diversification. Molecular Biology and Evolution 32 (4): 835-845\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{141/223}\\
\multicolumn{1}{r}{\em{\textbf{4.}}} & \bgroup\fontsize{8}{10}\selectfont Lack J.B., \& Van den bussche R.A. 2010. Identifying the Confounding Factors in Resolving Phylogenetic Relationships in Vespertilionidae. Journal of Mammalogy, .\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{46/223}\\
\multicolumn{1}{r}{\em{\textbf{5.}}} & \bgroup\fontsize{8}{10}\selectfont Shi, Jeff J., Daniel L. Rabosky. 2015. Speciation dynamics during the global radiation of extant bats. Evolution 69 (6): 1528-1545\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{157/223}\\
\bottomrule
\multicolumn{4}{l}{{\textbf{\textit{Source N}}}: Number of source chronograms reported in study.}\\
\multicolumn{4}{l}{{\textbf{\textit{Taxon N}}}: Number of queried taxa found in source chronograms.}\\
\end{longtable}

Source chronograms maximum age range from 25.19 to
36.3 million years ago (MYA).
As a means for comparison, lineage through time plots of all source chronograms
available in data base are shown in Fig. 1



![Lineage through time (LTT) plots of source chronograms available in data base
  for species in the Phyllostomidae. Numbers correspond to original studies in Table 1. Arrows indicate maximum age of chronograms.](plots/Phyllostomidae_LTTplot_phyloall.pdf)

![Test of make_lttplot_summ2 function](plots/Phyllostomidae_make_lttplot_summ2_test.pdf)


\newpage


## II. Summarize results.

LTT plots are a nice way to visually compare several trees. But what if you want
to summarize all that information into a single chronogram?

The first step is to identify the degree of species overlap among your source chornograms: if each
source chronogram has a unique sample of species, it will not be possible to combine
them into a single summary chronogram. To identify the set of trees or _grove_ with the most source
chronograms that have at least two overlapping taxa, we followed Ané et al. 2016.
In this case, not all source chronograms found for the  Phyllostomidae  have at least two overlapping species. The largest grove has  2  chronograms (out of  7  total source chronograms).
Now that we have identified a suitable grove 
we can go on to summarize it by translating the source chronograms into patristic distance matrices and
then averaging them into a single summary matrix; yes, this first step is _that_
straightforward. We can average the source matrices by simply using the mean or
median distances, or we can use more complicated approaches that involve transforming
the original distance matrices --such as the super distance matrix (SDM) approach of Criscuolo et al. 2006-- by minimizing
the distances across source matrices.

Once with a summary matrix, a distance-based clustering
algorithm can be used to reconstruct the tree. Algorithms such as neighbour joining (NJ) and
unweighted pair group method with arithmetic mean (UPGMA) are
fast and work well when there are no missing values in the matrices. However, summary
matrices coming from source chronograms usually have several NAs and missing rows.
<!--This data set for example has NUMBER cells with missing data.-->
When this happens, even available variants of NJ and UPGMA algorithms that are designed to deal with missing data do
not work well, as shown in the next section. Other methods designed to deal with missing data are BIONJ\*,
MVR\*, and the triangle method, but we have not tried them yet.


###   II.A. Diagnosing clustering issues.

Clustering algorithms used to go from a summary distance matrix to
a tree return trees that are too old (generally with UPGMA algorithms) or non-ultrametric
(generally with NJ algorithms). In most studied cases, UPGMA returns
fully ultrametric trees but with very old ages (we had to multiply the matrix by
0.25 to get ages approximate to source chronograms ages, however this number is not justified,
it is just the number that approximates ages to source maximum ages the most). NJ returned reasonable
ages, but trees are way non ultrametric, as you can see in Fig. S1
and Fig. 2.

This taxon's SDM matrix has NO negative values.This taxon's Median matrix has NO negative values.


![Phyllostomidae lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or
  with maximum ages that are just off (too old or too young). So we developped an
  alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Phyllostomidae_LTTplot_Median.pdf)



###   II.B. Age distributions from Median and SDM summary trees.

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

\caption{\label{tab:unnamed-chunk-6}Was it successful to use each source chronogram independently as calibration (CalibN) against the Dated Open Tree of Life (dOToL) and each other (ChronoN)?}
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

![Phyllostomidae Species Dated Open Tree of Life Induced Subtree. This chronogram was obtained with `get_dated_otol_induced_subtree()` function.](plots/Phyllostomidae_datedotol.pdf)



![Phyllostomidae lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with `datelife` algorithm.](plots/Phyllostomidae_LTTplot_SDM.pdf)

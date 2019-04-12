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

# Taxon Spheniscidae

## I. Query data
There are 25 species in the Open Tree of Life Taxonomy for the taxon Spheniscidae.
Information on time of divergence is available for
19
of these species across 13 published and peer-reviewed chronograms from the following studies:

**1. Jarvis, E. D., S. Mirarab, A. J. Aberer, B. Li, P. Houde, C. Li, S. Y. W. Ho, B. C. Faircloth, B. Nabholz, J. T. Howard, A. Suh, C. C. Weber, R. R. da Fonseca, J. Li, F. Zhang, H. Li, L. Zhou, N. Narula, L. Liu, G. Ganapathy, B. Boussau, M. S. Bayzid, V. Zavidovych, S. Subramanian, T. Gabaldon, S. Capella-Gutierrez, J. Huerta-Cepas, B. Rekepalli, K. Munch, M. Schierup, B. Lindow, W. C. Warren, D. Ray, R. E. Green, M. W. Bruford, X. Zhan, A. Dixon, S. Li, N. Li, Y. Huang, E. P. Derryberry, M. F. Bertelsen, F. H. Sheldon, R. T. Brumfield, C. V. Mello, P. V. Lovell, M. Wirthlin, M. P. C. Schneider, F. Prosdocimi, J. A. Samaniego, A. M. V. Velazquez, A. Alfaro-Nunez, P. F. Campos, B. Petersen, T. Sicheritz-Ponten, A. Pas, T. Bailey, P. Scofield, M. Bunce, D. M. Lambert, Q. Zhou, P. Perelman, A. C. Driskell, B. Shapiro, Z. Xiong, Y. Zeng, S. Liu, Z. Li, B. Liu, K. Wu, J. Xiao, X. Yinqi, Q. Zheng, Y. Zhang, H. Yang, J. Wang, L. Smeds, F. E. Rheindt, M. Braun, J. Fjeldsa, L. Orlando, F. K. Barker, K. A. Jonsson, W. Johnson, K.-P. Koepfli, S. O'Brien, D. Haussler, O. A. Ryder, C. Rahbek, E. Willerslev, G. R. Graves, T. C. Glenn, J. McCormack, D. Burt, H. Ellegren, P. Alstrom, S. V. Edwards, A. Stamatakis, D. P. Mindell, J. Cracraft, E. L. Braun, T. Warnow, W. Jun, M. T. P. Gilbert, G. Zhang. 2014. Whole-genome analyses resolve early branches in the tree of life of modern birds. Science 346 (6215): 1320-1331.**

**2. Hedges, S. Blair, Julie Marin, Michael Suleski, Madeline Paymer, Sudhir Kumar. 2015. Tree of life reveals clock-like speciation and diversification. Molecular Biology and Evolution 32 (4): 835-845**

**3. García–R, Juan C., Gillian C. Gibb, Steve A. Trewick. 2014. Eocene diversification of crown group rails (Aves: Gruiformes: Rallidae). PLoS ONE 9 (10): e109635**

**4. Claramunt, Santiago, Joel Cracraft. 2015. A new time tree reveals Earth historys imprint on the evolution of modern birds. Science Advances 1 (11): e1501005-e1501005**

**5. Gavryushkina, Alexandra, Tracy A. Heath, Daniel T. Ksepka, Tanja Stadler, David Welch, Alexei J. Drummond. 2016. Bayesian Total-Evidence Dating Reveals the Recent Crown Radiation of Penguins. Systematic Biology, p. syw060**

**6. Jetz, W., G. H. Thomas, J. B. Joy, K. Hartmann, A. O. Mooers. 2012. The global diversity of birds in space and time. Nature 491 (7424): 444-448**

**7. Johnson, Jeff A., Joseph W. Brown, Jérôme Fuchs, David P. Mindell, 2016, 'Multi-locus phylogenetic inference among New World Vultures (Aves: Cathartidae)', Molecular Phylogenetics and Evolution, vol. 105, pp. 193-199**

**8. Gibb, Gillian C., Martyn Kennedy, David Penny. 2013. Beyond phylogeny: pelecaniform and ciconiiform birds, and long-term niche stability. Molecular Phylogentics and Evolution 68 (2): 229-238.**

**9. Subramanian, S., G. Beans-Picon, S. K. Swaminathan, C. D. Millar, D. M. Lambert. 2013. Evidence for a recent origin of penguins. Biology Letters 9 (6): 20130748-20130748.**

All source chronograms are fully ultrametric.
The proportion of Spheniscidae queried species found across source chronograms is as follows:

|   |Trees                           |Tips |Resolved |
|:--|:-------------------------------|:----|:--------|
|1  |Open Tree of Life Subtree       |25   |96%      |
|2  |Dated Open Tree of Life Subtree |25   |72%      |
|3  |Median Summary Chronogram       |19   |95%      |
|4  |SDM Summary Chronogram          |19   |95%      |


![Spheniscidae Species Dated Open Tree of Life Induced Subtree. This chronogram was obtained with `get_dated_otol_induced_subtree()` function.](plots/Spheniscidae_datedotol.pdf)


![Spheniscidae lineage through time (LTT) plots from source chronograms, summary median chronogram and dated Open Tree of Life chronogram.](plots/Spheniscidae_LTTplot_phyloall.pdf)


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

This taxon's SDM matrix has some negative values in the following taxa: *Eudyptes chrysocome*, *Eudyptes filholi*. This taxon's Median matrix has NO negative values.


![Spheniscidae lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or with maximum ages that are just off (too old or too young). So we developped an alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Spheniscidae_LTTplot_Median.pdf)



![Spheniscidae lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with different methods (NJ and UPGMA). As you can note, dashed lines and solid lines from trees coming out from both types of clustering algorithms implemented are mostly overlapping. This means that removing negative values does not change results from clustering algorithms much. Clustering algorithms used often are returning non-ultrametric trees or with maximum ages that are just off (too old or too young). So we developped an alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Spheniscidae_LTTplot_SDM.pdf)

### II.B. Age distributions form Median and SDM summary trees.

Comparison of summary chronograms reconstructed with min and max ages.


![Spheniscidae lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with `datelife` algorithm.](plots/Spheniscidae_LTTplot_summtrees_Median.pdf)



![Spheniscidae lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with `datelife` algorithm.](plots/Spheniscidae_LTTplot_summtrees_SDM.pdf)


\newpage


## III. Create new data


As an example, we're gonna date the Open Tree Synthetic tree (mainly because the taxonomic tree is usually less well resolved.)


Now, let's say you like the Open Tree of Life Taxonomy and you want to stick to that tree. Dates from available studies were tested over the Open Tree of Life Synthetic tree of Spheniscidae and a tree was constructed, but all branch lengths are NA.
We also tried  each source chronogram independently, with the Dated OToL and with each other, as a form of cross validation in Table 2. This is not working perfectly yet, but we are developping new ways to use all calibrations efficiently.

\newpage
\begin{table}[t]

\caption{\label{tab:unnamed-chunk-6}Was it successful to use each source chronogram independently as calibration (CalibN) against the Dated Open Tree of Life (dOToL) and each other (ChronoN)?}
\fontsize{7}{9}\selectfont
\begin{tabular}{lllllllllllllll}
\toprule
  & dOToL & Chr1 & Chr2 & Chr3 & Chr4 & Chr5 & Chr6 & Chr7 & Chr8 & Chr9 & Chr10 & Chr11 & Chr12 & Chr13\\
\midrule
Calib1 & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes\\
Calib2 & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes\\
Calib3 & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes\\
Calib4 & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes\\
Calib5 & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes\\
\addlinespace
Calib6 & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes\\
Calib7 & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes\\
Calib8 & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes\\
Calib9 & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes\\
Calib10 & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes\\
\addlinespace
Calib11 & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes\\
Calib12 & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes\\
Calib13 & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes & yes\\
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
The following species were completely absent from the chronogram data base:  *Aptenodytes australis**, **Catadyptes chrysolophus**, **Eudyptes atratus**, **Eudyptula chathamensis**, **Megadyptes waitaha**, **Pygoscelis ellsworthi*

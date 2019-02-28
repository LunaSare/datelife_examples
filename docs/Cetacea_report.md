---
title: "DateLife Workflows"
author: "Luna L. Sanchez Reyes"
date: "2019-02-28"
output: rmarkdown::html_vignette
geometry: "left=3cm,right=3cm,top=2.5cm,bottom=4cm"
vignette: >
  %\VignetteIndexEntry{DateLife Example}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---


\raggedright

# Taxon Cetacea

## I. Query data
There are 198 species in the Open Tree of Life Taxonomy for the taxon Cetacea.
Information on time of divergence is available for
89
of these species across 6 published and peer-reviewed chronograms from the following studies:

**1. Toljagi&#263; O., Voje K.L., Matschiner M., Liow L., & Hansen T.F. 2017. Millions of Years Behind: Slow Adaptation of Ruminants to Grasslands. Systematic Biology, .**

**2. Bininda-Emonds, Olaf R. P., Marcel Cardillo, Kate E. Jones, Ross D. E. MacPhee, Robin M. D. Beck, Richard Grenyer, Samantha A. Price, Rutger A. Vos, John L. Gittleman, Andy Purvis. 2007. The delayed rise of present-day mammals. Nature 446 (7135): 507-512**

**3. Hedges, S. Blair, Julie Marin, Michael Suleski, Madeline Paymer, Sudhir Kumar. 2015. Tree of life reveals clock-like speciation and diversification. Molecular Biology and Evolution 32 (4): 835-845**

**4. Steeman, M., Hebsgaard M., Fordyce R., Ho S., Rabosky D., Nielsen R., Rahbek C., Glenner H., Sørensen M., & Willerslev E. 2009. Radiation of Extant Cetaceans Driven by Restructuring of the Oceans. Systematic Biology 58 (6): 573-585.**

All source chronograms are fully ultrametric.
The proportion of Cetacea queried species found across source chronograms is as follows:

|   |Trees                           |Tips |Resolved |
|:--|:-------------------------------|:----|:--------|
|1  |Open Tree of Life Subtree       |198  |99%      |
|2  |Dated Open Tree of Life Subtree |198  |60%      |
|3  |Median Summary Chronogram       |89   |99%      |
|4  |SDM Summary Chronogram          |89   |99%      |


![Cetacea Species Dated Open Tree of Life Induced Subtree. This chronogram was obtained with `get_dated_otol_induced_subtree()` function.](plots/Cetacea_datedotol.pdf)


![Cetacea lineage through time (LTT) plots from source chronograms, summary median chronogram and dated Open Tree of Life chronogram.](plots/Cetacea_LTTplot_phyloall.pdf)


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

This taxon's SDM matrix has some negative values in the following taxa: *Eubalaena japonica*, *Eubalaena glacialis*. This taxon's Median matrix has NO negative values.


![Cetacea lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or with maximum ages that are just off. So we developped an alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Cetacea_LTTplot_Median.pdf)



![Cetacea lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with different methods (NJ and UPGMA). As you can note, dashed lines and solid lines from trees coming out from both types of clustering algorithms implemented are mostly overlapping. This means that removing negative values does not change results from clustering algorithms much. Clustering algorithms used often are returning non-ultrametric trees or with maximum ages that are just off. So we developped an alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Cetacea_LTTplot_sdm.pdf)


\newpage


## III. Create new data


As an example, we're gonna date the Open Tree Synthetic tree (mainly because the taxonomic tree is usually less well resolved.)


Now, let's say you like the Open Tree of Life Taxonomy and you want to stick to that tree. Dates from available studies were tested over the Open Tree of Life Synthetic tree of Cetacea and a tree was constructed, but all branch lengths are NA.
We also tried  each source chronogram independently, with the Dated OToL and with each other, as a form of cross validation in Table 2. this is not working perfectly yet, but we are developping new ways to use all calibrations efficiently.

\newpage
\begin{table}[t]

\caption{\label{tab:unnamed-chunk-6}Was it successful to use each source chronogram independently as calibration (CalibN) against the Dated Open Tree of Life (dOToL) and each other (ChronoN)?}
\fontsize{9}{11}\selectfont
\begin{tabular}{llllllll}
\toprule
  & dOToL & Chrono1 & Chrono2 & Chrono3 & Chrono4 & Chrono5 & Chrono6\\
\midrule
Calibrations1 & TRUE & TRUE & FALSE & TRUE & FALSE & TRUE & TRUE\\
Calibrations2 & TRUE & TRUE & FALSE & TRUE & FALSE & TRUE & TRUE\\
Calibrations3 & TRUE & TRUE & FALSE & TRUE & FALSE & TRUE & TRUE\\
Calibrations4 & TRUE & TRUE & FALSE & TRUE & FALSE & TRUE & TRUE\\
Calibrations5 & TRUE & TRUE & FALSE & TRUE & FALSE & TRUE & TRUE\\
\addlinespace
Calibrations6 & TRUE & TRUE & FALSE & TRUE & FALSE & TRUE & TRUE\\
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
The following species were completely absent from the chronogram data base:  *Amphiptera pacifica**, **Balaena agamachschik**, **Balaena mangidach**, **Balaenoptera andrejewi**, **Balaenoptera caerulescens**, **Balaenoptera emargenata**, **Balaenoptera grimmi**, **Balaenoptera maculata**, **Balaenoptera nigra**, **Balaenoptera punctulata**, **Catodon polycyphus**, **Catodon polyscyphus**, **Catodon svineval**, **Cephalorhyncus commersonii**, **Cephalorhyncus heavisidii**, **Clymenia gadamu**, **Delphinapterus senedetta**, **Delphinorhynchus maculatus**, **Delphinorhynchus pernettyi**, **Delphinorhynchus santonicus**, **Delphinus abusalam**, **Delphinus anarnacus**, **Delphinus attenuatus**, **Delphinus bertini**, **Delphinus bonnaterrei**, **Delphinus boryi**, **Delphinus caerulescens**, **Delphinus carbonarius**, **Delphinus coronatus**, **Delphinus cymodice**, **Delphinus cymodoce**, **Delphinus epiodon**, **Delphinus eurynome**, **Delphinus fabricii**, **Delphinus feres**, **Delphinus gadamu**, **Delphinus hamatus**, **Delphinus harlani**, **Delphinus leucocephalus**, **Delphinus livittatus**, **Delphinus maculatus**, **Delphinus maculiventer**, **Delphinus minimus**, **Delphinus nesarnac**, **Delphinus niger**, **Delphinus pernettyensis**, **Delphinus pernetyi**, **Delphinus perniger**, **Delphinus rappii**, **Delphinus rhinoceros**, **Delphinus salam**, **Delphinus siculus**, **Delphinus symodice**, **Delphinus walkeri**, **Epiodon rafinesque**, **Epiodon urganantus**, **Eudelphinus tasmaniensis**, **Globicephala macrorhyncus**, **Globicephalus fuscus**, **Globicephalus uneidens**, **Globiocephalus chinensis**, **Inia araguaiaensis**, **Inia boliviensis**, **Lagenodelphis australis**, **Lagenodelphis obliquidens**, **Lagenoelphis hosei**, **Lagenorhynchus bombifrons**, **Lagenorhynchus nilssonii**, **Lagenorhynchus posidonia**, **Lagenorhynchus superciliosus**, **Lagenorhyncus acutus**, **Lagenorhyncus albirostris**, **Lagenorhyncus australis**, **Lagenorhyncus cruciger**, **Lagenorhyncus obliquidens**, **Lagenorhyncus obscurus**, **Mesoplodon hotaula**, **Mesoplodon lazardii**, **Monodon spurius**, **Neophocaena asiaeorientalis**, **Phocaena posidonia**, **Physeter gibbosus**, **Physeter katadon**, **Physeter krefftii**, **Physeter polycephus**, **Physeter polycystus**, **Physeter pterodon**, **Platanista indi**, **Prodelphinus malayanus**, **Sotalia gadamu**, **Sotalia maculiventer**, **Sotalia perniger**, **Sotalia santonicus**, **Sousa gadamu**, **Sousa plumbea**, **Sousa sahulensis**, **Steno fuscus**, **Steno gadamu**, **Steno malayanus**, **Steno perniger**, **Tursio catalania**, **Tursio cymodoce**, **Tursio eurynome**, **Tursiops australis**, **Tursiops catalania**, **Tursiops cymodice**, **Tursiops dawsoni**, **Tursiops fergusoni**, **Tursiops nesarnack*
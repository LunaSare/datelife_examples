---
title: "DateLife Workflows"
author: "Luna L. Sanchez Reyes"
date: "2019-04-29"
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

# Taxon Cetacea

## I. Query source data
There are 198 species in the Open Tree of Life Taxonomy for the taxon Cetacea.
Information on time of divergence is available for
89
of these species across 6 published and peer-reviewed chronograms.
Original study citations as well as proportion of Cetacea species found across those source
chronograms is shown in Table 1.

All source chronograms are fully ultrametric.

\begin{longtable}{>{\raggedright\arraybackslash}p{0.4cm}>{\raggedright\arraybackslash}p{11cm}>{\raggedright\arraybackslash}p{1.5cm}>{\raggedright\arraybackslash}p{1.8cm}}
\caption{\label{tab:unnamed-chunk-2}Cetacea source chronogram studies information.}\\
\toprule
\multicolumn{1}{>{\centering\arraybackslash}p{0.4cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{   }}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{11cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Citation}}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{1.5cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Source N}}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{1.8cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Taxon N}}\endgroup}\\
\midrule
\multicolumn{1}{r}{\em{\textbf{1.}}} & \bgroup\fontsize{8}{10}\selectfont Bininda-Emonds, Olaf R. P., Marcel Cardillo, Kate E. Jones, Ross D. E. MacPhee, Robin M. D. Beck, Richard Grenyer, Samantha A. Price, Rutger A. Vos, John L. Gittleman, Andy Purvis. 2007. The delayed rise of present-day mammals. Nature 446 (7135): 507-512\egroup{} & \multicolumn{1}{c}{3} & \multicolumn{1}{c}{78/198}\\
\multicolumn{1}{r}{\em{\textbf{2.}}} & \bgroup\fontsize{8}{10}\selectfont Hedges, S. Blair, Julie Marin, Michael Suleski, Madeline Paymer, Sudhir Kumar. 2015. Tree of life reveals clock-like speciation and diversification. Molecular Biology and Evolution 32 (4): 835-845\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{79/198}\\
\multicolumn{1}{r}{\em{\textbf{3.}}} & \bgroup\fontsize{8}{10}\selectfont Steeman, M., Hebsgaard M., Fordyce R., Ho S., Rabosky D., Nielsen R., Rahbek C., Glenner H., Sørensen M., \& Willerslev E. 2009. Radiation of Extant Cetaceans Driven by Restructuring of the Oceans. Systematic Biology 58 (6): 573-585.\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{86/198}\\
\multicolumn{1}{r}{\em{\textbf{4.}}} & \bgroup\fontsize{8}{10}\selectfont Toljagi\&\#263; O., Voje K.L., Matschiner M., Liow L., \& Hansen T.F. 2017. Millions of Years Behind: Slow Adaptation of Ruminants to Grasslands. Systematic Biology, .\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{32/198}\\
\bottomrule
\multicolumn{4}{l}{{\textbf{\textit{Source N}}}: Number of source chronograms reported in study.}\\
\multicolumn{4}{l}{{\textbf{\textit{Taxon N}}}: Number of queried taxa found in source chronograms.}\\
\end{longtable}

Source chronograms maximum age range from 33.5 to
55.5 million years ago (MYA).
As a means for comparison, lineage through time plots of all source chronograms
available in data base are shown in Fig. 1

## II. Summarize results.

LTT plots are a nice way to visually compare several trees. But what if you want
to summarize information from all source chronograms into a single summary chronogram?


![Lineage through time (LTT) plots of source chronograms available in data base
  for species in the Cetacea. Numbers correspond to original studies in Table 1. Arrows indicate maximum age of each chronogram.](plots/Cetacea_LTTplot_phyloall.pdf)

The first step is to identify the degree of species overlap among your source chornograms: if each
source chronogram has a unique sample of species, it will not be possible to combine
them into a single summary chronogram. To identify the set of trees or _grove_ with the most source
chronograms that have at least two overlapping taxa, we followed Ané et al. 2016.
In this case, not all source chronograms found for the  Cetacea  have at least two overlapping species. The largest grove has  2  chronograms (out of  6  total source chronograms).
Now that we have identified a suitable grove 
we can go on to summarize it by translating the source chronograms into patristic distance matrices and
then averaging them into a single summary matrix; yes, this first step is _that_
straightforward. We can average the source matrices by simply using the mean or
median distances, or we can use methods that involve transforming
the original distance matrices --such as the super distance matrix (SDM) approach of Criscuolo et al. 2006-- by minimizing
the distances across source matrices.

Because our summary matrix is basically a distance matrix, a distance-based clustering
algorithm could be used to reconstruct the tree. Algorithms such as neighbour joining (NJ) and
unweighted pair group method with arithmetic mean (UPGMA) are
fast and work well when there are no missing values in the matrices. However, summary
matrices coming from source chronograms usually have several NAs and missing rows.
<!--This data set for example has NUMBER cells with missing data.-->
When this happens, clustering algorithms that have been developed to deal with missing values
<!--
NJS: ape::njs
UPGMA: daisy + upgma
BIONJ: ape::bionjs(X)
Minimum Variance Reduction: ape::mvrs(X, V)
Triangle Method, Tree reconstruction based on the triangle method: ape::triangMtds(X)
-->
do not work well, as shown in the following section. This is probbaly because these
methods are usually applied to distance matrices that represent evolutionary distance
in terms of sunstitution rate nad not absolute time, as is the case in here.


###   II.A. Detecting clustering issues.

We tested several clustering algorithms on summary distance matrices coming from median and SDM.
UPGMA returns ultrametric trees that are considerably older than source chronograms.
Even scaling the distance matrix down by a factor of 0.5 would not produce trees
with ages that are coherent with the source chronograms.
NJ returned trees with reasonable ages, but trees are way non ultrametric, as you can see in Fig. S1
and Fig. 2.


![Lineage Through Time plots of Cetacea summary
chronograms from median (upper) and SDM (lower) summary matrices obtained with various clustering algorithms.](plots/Cetacea_make_lttplot_summ3_test_median.pdf)

This taxon's SDM matrix has some negative values in the following taxa: *Eubalaena japonica*, *Eubalaena glacialis*. This taxon's Median matrix has NO negative values.


![Cetacea lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or
  with maximum ages that are just off (too old or too young). So we developped an
  alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Cetacea_LTTplot_Median.pdf)



###   II.B. Age distributions from Median and SDM summary trees.

Comparison of summary chronograms reconstructed with min and max ages.


![Cetacea lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with `datelife` algorithm.](plots/Cetacea_LTTplot_summtrees_Median.pdf)



![Cetacea lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with `datelife` algorithm.](plots/Cetacea_LTTplot_summtrees_SDM.pdf)


\newpage


## III. Create new data


As an example, we're gonna date the Open Tree Synthetic tree (mainly because the taxonomic tree is usually less well resolved.)


Now, let's say you like the Open Tree of Life Taxonomy and you want to stick to that tree. Dates from available studies were tested over the Open Tree of Life Synthetic tree of Cetacea and a tree was constructed, but all branch lengths are NA.
We also tried  each source chronogram independently, with the Dated OToL and with each other, as a form of cross validation in Table 2. This is not working perfectly yet, but we are developping new ways to use all calibrations efficiently.

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


\newpage

## Appendix
The following species were completely absent from the chronogram data base:  *Amphiptera pacifica**, **Balaena agamachschik**, **Balaena mangidach**, **Balaenoptera andrejewi**, **Balaenoptera caerulescens**, **Balaenoptera emargenata**, **Balaenoptera grimmi**, **Balaenoptera maculata**, **Balaenoptera nigra**, **Balaenoptera punctulata**, **Catodon polycyphus**, **Catodon polyscyphus**, **Catodon svineval**, **Cephalorhyncus commersonii**, **Cephalorhyncus heavisidii**, **Clymenia gadamu**, **Delphinapterus senedetta**, **Delphinorhynchus maculatus**, **Delphinorhynchus pernettyi**, **Delphinorhynchus santonicus**, **Delphinus abusalam**, **Delphinus anarnacus**, **Delphinus attenuatus**, **Delphinus bertini**, **Delphinus bonnaterrei**, **Delphinus boryi**, **Delphinus caerulescens**, **Delphinus carbonarius**, **Delphinus coronatus**, **Delphinus cymodice**, **Delphinus cymodoce**, **Delphinus epiodon**, **Delphinus eurynome**, **Delphinus fabricii**, **Delphinus feres**, **Delphinus gadamu**, **Delphinus hamatus**, **Delphinus harlani**, **Delphinus leucocephalus**, **Delphinus livittatus**, **Delphinus maculatus**, **Delphinus maculiventer**, **Delphinus minimus**, **Delphinus nesarnac**, **Delphinus niger**, **Delphinus pernettyensis**, **Delphinus pernetyi**, **Delphinus perniger**, **Delphinus rappii**, **Delphinus rhinoceros**, **Delphinus salam**, **Delphinus siculus**, **Delphinus symodice**, **Delphinus walkeri**, **Epiodon rafinesque**, **Epiodon urganantus**, **Eudelphinus tasmaniensis**, **Globicephala macrorhyncus**, **Globicephalus fuscus**, **Globicephalus uneidens**, **Globiocephalus chinensis**, **Inia araguaiaensis**, **Inia boliviensis**, **Lagenodelphis australis**, **Lagenodelphis obliquidens**, **Lagenoelphis hosei**, **Lagenorhynchus bombifrons**, **Lagenorhynchus nilssonii**, **Lagenorhynchus posidonia**, **Lagenorhynchus superciliosus**, **Lagenorhyncus acutus**, **Lagenorhyncus albirostris**, **Lagenorhyncus australis**, **Lagenorhyncus cruciger**, **Lagenorhyncus obliquidens**, **Lagenorhyncus obscurus**, **Mesoplodon hotaula**, **Mesoplodon lazardii**, **Monodon spurius**, **Neophocaena asiaeorientalis**, **Phocaena posidonia**, **Physeter gibbosus**, **Physeter katadon**, **Physeter krefftii**, **Physeter polycephus**, **Physeter polycystus**, **Physeter pterodon**, **Platanista indi**, **Prodelphinus malayanus**, **Sotalia gadamu**, **Sotalia maculiventer**, **Sotalia perniger**, **Sotalia santonicus**, **Sousa gadamu**, **Sousa plumbea**, **Sousa sahulensis**, **Steno fuscus**, **Steno gadamu**, **Steno malayanus**, **Steno perniger**, **Tursio catalania**, **Tursio cymodoce**, **Tursio eurynome**, **Tursiops australis**, **Tursiops catalania**, **Tursiops cymodice**, **Tursiops dawsoni**, **Tursiops fergusoni**, **Tursiops nesarnack*

![Cetacea Species Dated Open Tree of Life Induced Subtree. This chronogram was obtained with `get_dated_otol_induced_subtree()` function.](plots/Cetacea_datedotol.pdf)



![Cetacea lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with `datelife` algorithm.](plots/Cetacea_LTTplot_sdm.pdf)

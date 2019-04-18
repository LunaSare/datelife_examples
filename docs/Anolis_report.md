---
title: "DateLife Workflows"
author: "Luna L. Sanchez Reyes"
date: "2019-04-17"
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

# Taxon Anolis

## I. Query source data
There are 458 species in the Open Tree of Life Taxonomy for the taxon Anolis.
Information on time of divergence is available for
302
of these species across 6 published and peer-reviewed chronograms.
Original study citations as well as proportion of Anolis species found across those source
chronograms is shown in Table 1.

All source chronograms are fully ultrametric.

\begin{longtable}{>{\raggedright\arraybackslash}p{0.4cm}>{\raggedright\arraybackslash}p{11cm}>{\raggedright\arraybackslash}p{1.5cm}>{\raggedright\arraybackslash}p{1.8cm}}
\caption{\label{tab:unnamed-chunk-2}Anolis source chronogram studies information.}\\
\toprule
\multicolumn{1}{>{\centering\arraybackslash}p{0.4cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{   }}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{11cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Citation}}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{1.5cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Source N}}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{1.8cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Taxon N}}\endgroup}\\
\midrule
\multicolumn{1}{r}{\em{\textbf{1.}}} & \bgroup\fontsize{8}{10}\selectfont Hedges, S. Blair, Julie Marin, Michael Suleski, Madeline Paymer, Sudhir Kumar. 2015. Tree of life reveals clock-like speciation and diversification. Molecular Biology and Evolution 32 (4): 835-845\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{202/458}\\
\multicolumn{1}{r}{\em{\textbf{2.}}} & \bgroup\fontsize{8}{10}\selectfont Mahler, D. L., T. Ingram, L. J. Revell, J. B. Losos. 2013. Exceptional Convergence on the Macroevolutionary Landscape in Island Lizard Radiations. Science 341 (6143): 292-295.\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{205/458}\\
\multicolumn{1}{r}{\em{\textbf{3.}}} & \bgroup\fontsize{8}{10}\selectfont Pyron, R. Alexander, Frank T. Burbrink. 2013. Early origin of viviparity and multiple reversions to oviparity in squamate reptiles. Ecology Letters 17 (1): 13-21\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{289/458}\\
\multicolumn{1}{r}{\em{\textbf{4.}}} & \bgroup\fontsize{8}{10}\selectfont Steven Poe, Adrián Nieto-montes de oca, Omar Torres-carvajal, Kevin De Queiroz, Julián A. Velasco, Brad Truett, Levi N. Gray, Mason J. Ryan, Gunther Köhler, Fernando Ayala-varela, Ian Latella, 2017, 'A Phylogenetic, Biogeographic, and Taxonomic study of all Extant Species of Anolis (Squamata; Iguanidae)', Systematic Biology, vol. 66, no. 5, pp. 663-697\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{203/458}\\
\multicolumn{1}{r}{\em{\textbf{5.}}} & \bgroup\fontsize{8}{10}\selectfont Wright, April M., Kathleen M. Lyons, Matthew C. Brandley, David M. Hillis. 2015. Which came first: The lizard or the egg? Robustness in phylogenetic reconstruction of ancestral states. Journal of Experimental Zoology Part B: Molecular and Developmental Evolution 324 (6): 504-516\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{192/458}\\
\multicolumn{1}{r}{\em{\textbf{6.}}} & \bgroup\fontsize{8}{10}\selectfont Yuchi Zheng, John J. Wiens, 2016, 'Combining phylogenomic and supermatrix approaches, and a time-calibrated phylogeny for squamate reptiles (lizards and snakes) based on 52 genes and 4162 species', Molecular Phylogenetics and Evolution, vol. 94, pp. 537-547\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{98/458}\\
\bottomrule
\multicolumn{4}{l}{{\textbf{\textit{Source N}}}: Number of source chronograms reported in study.}\\
\multicolumn{4}{l}{{\textbf{\textit{Taxon N}}}: Number of queried taxa found in source chronograms.}\\
\end{longtable}

Source chronograms maximum age range from 47.843 to
72.578 million years ago (MYA).
As a means for comparison, lineage through time plots of all source chronograms
available are shown in Fig. 1



![Anolis lineage through time (LTT) plots from source chronograms, summary median chronogram and dated Open Tree of Life chronogram.](plots/Anolis_LTTplot_phyloall.pdf)


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

This taxon's SDM matrix has some negative values in the following taxa: *Anolis porcus*, *Anolis guamuhaya*, *Chamaeleolis chameleontides*, *Chamaeleolis chameleontides*. This taxon's Median matrix has NO negative values.


![Anolis lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or with maximum ages that are just off (too old or too young). So we developped an alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Anolis_LTTplot_Median.pdf)



![Anolis lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with different methods (NJ and UPGMA). As you can note, dashed lines and solid lines from trees coming out from both types of clustering algorithms implemented are mostly overlapping. This means that removing negative values does not change results from clustering algorithms much. Clustering algorithms used often are returning non-ultrametric trees or with maximum ages that are just off (too old or too young). So we developped an alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Anolis_LTTplot_SDM.pdf)

### II.B. Age distributions form Median and SDM summary trees.

Comparison of summary chronograms reconstructed with min and max ages.


![Anolis lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with `datelife` algorithm.](plots/Anolis_LTTplot_summtrees_Median.pdf)



![Anolis lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with `datelife` algorithm.](plots/Anolis_LTTplot_summtrees_SDM.pdf)


\newpage


## III. Create new data


As an example, we're gonna date the Open Tree Synthetic tree (mainly because the taxonomic tree is usually less well resolved.)


Now, let's say you like the Open Tree of Life Taxonomy and you want to stick to that tree. Dates from available studies were tested over the Open Tree of Life Synthetic tree of Anolis and a tree was constructed, but all branch lengths are NA.
We also tried  each source chronogram independently, with the Dated OToL and with each other, as a form of cross validation in Table 2. This is not working perfectly yet, but we are developping new ways to use all calibrations efficiently.

\newpage
\begin{table}[t]

\caption{\label{tab:unnamed-chunk-5}Was it successful to use each source chronogram independently as calibration (CalibN) against the Dated Open Tree of Life (dOToL) and each other (ChronoN)?}
\fontsize{9}{11}\selectfont
\begin{tabular}{llllllll}
\toprule
  & dOToL & Chrono1 & Chrono2 & Chrono3 & Chrono4 & Chrono5 & Chrono6\\
\midrule
Calibrations1 & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
Calibrations2 & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
Calibrations3 & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
Calibrations4 & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
Calibrations5 & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
\addlinespace
Calibrations6 & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
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
The following species were completely absent from the chronogram data base:  *Anolis alocomyos**, **Anolis altavelensis**, **Anolis anfiloquioi**, **Anolis anisolepis**, **Anolis attenuatus**, **Anolis bellipeniculus**, **Anolis birama**, **Anolis breedlovei**, **Anolis caquetae**, **Anolis carlliebi**, **Anolis carlostoddi**, **Anolis cf. alocomyos GK-2015**, **Anolis cf. humilis JJK-2013**, **Anolis cf. polylepis**, **Anolis charlesmyersi**, **Anolis chlorocyaneus**, **Anolis chrysops**, **Anolis concolor**, **Anolis cuscoensis**, **Anolis damulus**, **Anolis delafuentei**, **Anolis deltae**, **Anolis desiradei**, **Anolis dissimilis**, **Anolis eewi**, **Anolis fairchildi**, **Anolis forbesorum**, **Anolis fugitivus**, **Anolis gibbiceps**, **Anolis haguei**, **Anolis ibague**, **Anolis immaculogularis**, **Anolis impetigosus**, **Anolis incredulus**, **Anolis juangundlachi**, **Anolis kreutzi**, **Anolis laevis**, **Anolis lamari**, **Anolis landestoyi**, **Anolis leditzigorum**, **Anolis lemniscatus**, **Anolis limon**, **Anolis menta**, **Anolis microlepis**, **Anolis mirus**, **Anolis morazani**, **Anolis muralla**, **Anolis nasofrontalis**, **Anolis nietoi**, **Anolis nigrolineatus**, **Anolis osa**, **Anolis paravertebralis**, **Anolis philopunctatus**, **Anolis phyllorhinus**, **Anolis pigmaequestris**, **Anolis pijolense**, **Anolis pinchoti**, **Anolis propinquus**, **Anolis pseudotigrinus**, **Anolis purpurescens**, **Anolis radulinus**, **Anolis rhombifer**, **Anolis rimarum**, **Anolis rivalis**, **Anolis roosevelti**, **Anolis ruibali**, **Anolis ruizi**, **Anolis rupinae**, **Anolis sacamecatensis**, **Anolis santamartae**, **Anolis scapularis**, **Anolis schiedei**, **Anolis schmidti**, **Anolis sierramaestrae**, **Anolis simmonsi**, **Anolis solitarius**, **Anolis spectrum**, **Anolis squamulatus**, **Anolis stevepoei**, **Anolis tenorioensis**, **Anolis terueli**, **Anolis tetarii**, **Anolis toldo**, **Anolis umbrivagus**, **Anolis utowanae**, **Anolis vaupesianus**, **Anolis vescus**, **Anolis vicarius**, **Anolis villai**, **Anolis wampuensis**, **Anolis wattsii**, **Anolis wermuthi**, **Anolis williamsii**, **Anolis zapotecorum**, **Ctenonotus cybotes**, **Ctenonotus ferreus**, **Ctenonotus pulchellus**, **Norops alvarezdeltoroi**, **Norops anisolepis**, **Norops antonii**, **Norops baccatus**, **Norops birama**, **Norops bocourtii**, **Norops bouvierii**, **Norops breedlovei**, **Norops chrysolepis**, **Norops cobanensis**, **Norops concolor**, **Norops conspersus**, **Norops cumingii**, **Norops cuprinus**, **Norops cymbops**, **Norops damulus**, **Norops delafuentei**, **Norops dollfusianus**, **Norops exsul**, **Norops forbesi**, **Norops fungosus**, **Norops gibbiceps**, **Norops granuliceps**, **Norops haguei**, **Norops hobartsmithi**, **Norops ibague**, **Norops imias**, **Norops johnmeyeri**, **Norops lemniscatus**, **Norops lineatus**, **Norops lynchi**, **Norops macrolepis**, **Norops macrophallus**, **Norops maculiventris**, **Norops mariarum**, **Norops matudai**, **Norops microlepis**, **Norops milleri**, **Norops notopholis**, **Norops opalinus**, **Norops parvicirculatus**, **Norops pentaprion**, **Norops petersii**, **Norops pinchoti**, **Norops pygmaeus**, **Norops rhombifer**, **Norops rivalis**, **Norops salvini**, **Norops scapularis**, **Norops schiedei**, **Norops schmidti**, **Norops simmonsi**, **Norops sulcifrons**, **Norops tolimensis**, **Norops utowanae**, **Norops vicarius**, **Norops villai**, **Norops vittigerus**, **Norops vociferans*

![Anolis Species Dated Open Tree of Life Induced Subtree. This chronogram was obtained with `get_dated_otol_induced_subtree()` function.](plots/Anolis_datedotol.pdf)

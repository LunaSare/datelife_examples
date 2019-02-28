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

# Taxon Anolis

## I. Query data
There are 458 species in the Open Tree of Life Taxonomy for the taxon Anolis.
Information on time of divergence is available for
302
of these species across 6 published and peer-reviewed chronograms from the following studies:

**1. Yuchi Zheng, John J. Wiens, 2016, 'Combining phylogenomic and supermatrix approaches, and a time-calibrated phylogeny for squamate reptiles (lizards and snakes) based on 52 genes and 4162 species', Molecular Phylogenetics and Evolution, vol. 94, pp. 537-547**

**2. Pyron, R. Alexander, Frank T. Burbrink. 2013. Early origin of viviparity and multiple reversions to oviparity in squamate reptiles. Ecology Letters 17 (1): 13-21**

**3. Steven Poe, Adrián Nieto-montes de oca, Omar Torres-carvajal, Kevin De Queiroz, Julián A. Velasco, Brad Truett, Levi N. Gray, Mason J. Ryan, Gunther Köhler, Fernando Ayala-varela, Ian Latella, 2017, 'A Phylogenetic, Biogeographic, and Taxonomic study of all Extant Species of Anolis (Squamata; Iguanidae)', Systematic Biology, vol. 66, no. 5, pp. 663-697**

**4. Wright, April M., Kathleen M. Lyons, Matthew C. Brandley, David M. Hillis. 2015. Which came first: The lizard or the egg? Robustness in phylogenetic reconstruction of ancestral states. Journal of Experimental Zoology Part B: Molecular and Developmental Evolution 324 (6): 504-516**

**5. Hedges, S. Blair, Julie Marin, Michael Suleski, Madeline Paymer, Sudhir Kumar. 2015. Tree of life reveals clock-like speciation and diversification. Molecular Biology and Evolution 32 (4): 835-845**

**6. Mahler, D. L., T. Ingram, L. J. Revell, J. B. Losos. 2013. Exceptional Convergence on the Macroevolutionary Landscape in Island Lizard Radiations. Science 341 (6143): 292-295.**

All source chronograms are fully ultrametric.
The proportion of Anolis queried species found across source chronograms is as follows:

|   |Trees                           |Tips |Resolved |
|:--|:-------------------------------|:----|:--------|
|1  |Open Tree of Life Subtree       |458  |100%     |
|2  |Dated Open Tree of Life Subtree |458  |44%      |
|3  |Median Summary Chronogram       |302  |100%     |
|4  |SDM Summary Chronogram          |302  |100%     |


![Anolis Species Dated Open Tree of Life Induced Subtree. This chronogram was obtained with `get_dated_otol_induced_subtree()` function.](plots/Anolis_datedotol.pdf)


![Anolis lineage through time (LTT) plots from source chronograms, summary median chronogram and dated Open Tree of Life chronogram.](plots/Anolis_LTTplot_phyloall.pdf)


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

This taxon's SDM matrix has some negative values in the following taxa: *Anolis porcus*, *Anolis guamuhaya*, *Chamaeleolis chameleontides*, *Chamaeleolis chameleontides*. This taxon's Median matrix has NO negative values.


![Anolis lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or with maximum ages that are just off. So we developped an alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Anolis_LTTplot_Median.pdf)



![Anolis lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with different methods (NJ and UPGMA). As you can note, dashed lines and solid lines from trees coming out from both types of clustering algorithms implemented are mostly overlapping. This means that removing negative values does not change results from clustering algorithms much. Clustering algorithms used often are returning non-ultrametric trees or with maximum ages that are just off. So we developped an alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Anolis_LTTplot_sdm.pdf)


\newpage


## III. Create new data


As an example, we're gonna date the Open Tree Synthetic tree (mainly because the taxonomic tree is usually less well resolved.)


Now, let's say you like the Open Tree of Life Taxonomy and you want to stick to that tree. Dates from available studies were tested over the Open Tree of Life Synthetic tree of Anolis and a tree was constructed, but all branch lengths are NA.
We also tried  each source chronogram independently, with the Dated OToL and with each other, as a form of cross validation in Table 2. this is not working perfectly yet, but we are developping new ways to use all calibrations efficiently.

\newpage
\begin{table}[t]

\caption{\label{tab:unnamed-chunk-6}Was it successful to use each source chronogram independently as calibration (CalibN) against the Dated Open Tree of Life (dOToL) and each other (ChronoN)?}
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

---
title: "DateLife Workflows"
author: "Luna L. Sanchez Reyes"
date: "2019-04-30"
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

# Taxon Primates

## I. Query source data
There are 526 species in the Open Tree of Life Taxonomy for the taxon Primates.
Information on time of divergence is available for
355
of these species across 8 published and peer-reviewed chronograms.
Original study citations as well as proportion of Primates species found across those source
chronograms is shown in Table 1.

All source chronograms are fully ultrametric.

\begin{longtable}{>{\raggedright\arraybackslash}p{0.4cm}>{\raggedright\arraybackslash}p{11cm}>{\raggedright\arraybackslash}p{1.5cm}>{\raggedright\arraybackslash}p{1.8cm}}
\caption{\label{tab:unnamed-chunk-2}Primates source chronogram studies information.}\\
\toprule
\multicolumn{1}{>{\centering\arraybackslash}p{0.4cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{   }}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{11cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Citation}}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{1.5cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Source N}}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{1.8cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Taxon N}}\endgroup}\\
\midrule
\multicolumn{1}{r}{\em{\textbf{1.}}} & \bgroup\fontsize{8}{10}\selectfont Bininda-Emonds, Olaf R. P., Marcel Cardillo, Kate E. Jones, Ross D. E. MacPhee, Robin M. D. Beck, Richard Grenyer, Samantha A. Price, Rutger A. Vos, John L. Gittleman, Andy Purvis. 2007. The delayed rise of present-day mammals. Nature 446 (7135): 507-512\egroup{} & \multicolumn{1}{c}{3} & \multicolumn{1}{c}{215/526}\\
\multicolumn{1}{r}{\em{\textbf{2.}}} & \bgroup\fontsize{8}{10}\selectfont Hedges, S. Blair, Julie Marin, Michael Suleski, Madeline Paymer, Sudhir Kumar. 2015. Tree of life reveals clock-like speciation and diversification. Molecular Biology and Evolution 32 (4): 835-845\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{294/526}\\
\multicolumn{1}{r}{\em{\textbf{3.}}} & \bgroup\fontsize{8}{10}\selectfont Springer, Mark S., Robert W. Meredith, John Gatesy, Christopher A. Emerling, Jong Park, Daniel L. Rabosky, Tanja Stadler, Cynthia Steiner, Oliver A. Ryder, Jan E. Janečka, Colleen A. Fisher, William J. Murphy. 2012. Macroevolutionary dynamics and historical biogeography of primate diversification inferred from a species supermatrix. PLoS ONE 7 (11): e49521.\egroup{} & \multicolumn{1}{c}{4} & \multicolumn{1}{c}{330/526}\\
\bottomrule
\multicolumn{4}{l}{{\textbf{\textit{Source N}}}: Number of source chronograms reported in study.}\\
\multicolumn{4}{l}{{\textbf{\textit{Taxon N}}}: Number of queried taxa found in source chronograms.}\\
\end{longtable}

Source chronograms maximum age range from 62.766 to
90.4 million years ago (MYA).
As a means for comparison, lineage through time plots of all source chronograms
available in data base are shown in Fig. 1

## II. Summarize results.

LTT plots are a nice way to visually compare several trees. But what if you want
to summarize information from all source chronograms into a single summary chronogram?


![Lineage through time (LTT) plots of source chronograms available in data base
  for species in the Primates. Numbers correspond to original studies in Table 1. Arrows indicate maximum age of each chronogram.](plots/Primates_LTTplot_phyloall.pdf)

The first step is to identify the degree of species overlap among your source chornograms: if each
source chronogram has a unique sample of species, it will not be possible to combine
them into a single summary chronogram. To identify the set of trees or _grove_ with the most source
chronograms that have at least two overlapping taxa, we followed Ané et al. 2016.
In this case, not all source chronograms found for the  Primates  have at least two overlapping species. The largest grove has  2  chronograms (out of  8  total source chronograms).
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


![Lineage Through Time plots of Primates summary
chronograms from median (upper) and SDM (lower) summary matrices obtained with various clustering algorithms.](plots/Primates_lttplot_cluster_median.pdf)




###   II.B. Age distributions from Median and SDM summary trees.

Comparison of summary chronograms reconstructed with min and max ages.


```
#> Error in figcap_lttplot_summ[[i]] <- paste(taxon, "lineage through time (LTT) plots from source chronograms and", : object 'figcap_lttplot_summ' not found
#> Error in paste0("\n![", figcap_lttplot_summ[[2]], "](plots/", taxon, "_LTTplot_summtrees_Median.pdf)\n"): object 'figcap_lttplot_summ' not found
#> Error in cat(lttplot_median): object 'lttplot_median' not found
```



```
#> Error in paste0("\n![", figcap_lttplot_summ[[1]], "](plots/", taxon, "_LTTplot_summtrees_SDM.pdf)\n"): object 'figcap_lttplot_summ' not found
#> Error in cat(lttplot_sdm): object 'lttplot_sdm' not found
```


\newpage


## III. Create new data


As an example, we're gonna date the Open Tree Synthetic tree (mainly because the taxonomic tree is usually less well resolved.)


Now, let's say you like the Open Tree of Life Taxonomy and you want to stick to that tree. Dates from available studies were tested over the Open Tree of Life Synthetic tree of Primates and a tree was constructed, but all branch lengths are NA.
We also tried  each source chronogram independently, with the Dated OToL and with each other, as a form of cross validation in Table 2. This is not working perfectly yet, but we are developping new ways to use all calibrations efficiently.

\newpage
\begin{table}[t]

\caption{\label{tab:unnamed-chunk-5}Was it successful to use each source chronogram independently as calibration (CalibN) against the Dated Open Tree of Life (dOToL) and each other (ChronoN)?}
\fontsize{7}{9}\selectfont
\begin{tabular}{llllllllll}
\toprule
  & dOToL & Chrono1 & Chrono2 & Chrono3 & Chrono4 & Chrono5 & Chrono6 & Chrono7 & Chrono8\\
\midrule
Calibrations1 & TRUE & FALSE & FALSE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
Calibrations2 & TRUE & FALSE & FALSE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
Calibrations3 & TRUE & FALSE & FALSE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
Calibrations4 & TRUE & FALSE & FALSE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
Calibrations5 & TRUE & FALSE & FALSE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
\addlinespace
Calibrations6 & TRUE & FALSE & FALSE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
Calibrations7 & TRUE & FALSE & FALSE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
Calibrations8 & TRUE & FALSE & FALSE & TRUE & TRUE & TRUE & TRUE & TRUE & TRUE\\
\bottomrule
\end{tabular}
\end{table}
\newpage
## III. Simulate data
An alternative to generate a dated tree from a set of taxa is to take the available information and simulate into it the missing data.
We will take the median and sdm summary chronograms to date the Synthetic tree of Life:


\newpage

## Appendix
The following species were completely absent from the chronogram data base:  *Alouatta arctoidea**, **Alouatta discolor**, **Alouatta stramineus**, **Alouatta ululata**, **Aotus azarae**, **Aotus jorgehernandezi**, **Aotus zonalis**, **Avahi mooreorum**, **Avahi ramanantsoavani**, **Cacajao rubicundus**, **Callicebus aureipalatii**, **Callicebus baptista**, **Callicebus barbarabrownae**, **Callicebus caquetenesis**, **Callicebus caquetensis**, **Callicebus discolor**, **Callicebus lucifer**, **Callicebus medemi**, **Callicebus melanochir**, **Callicebus miltoni**, **Callicebus ornatus**, **Callicebus pallescens**, **Callicebus regulus**, **Callicebus stephennashi**, **Callicebus toppinii**, **Callicebus urubambensis**, **Callicebus vieirai**, **Callithrix cf. emiliae**, **Callithrix chrysoleuca**, **Carlito syrichta**, **Cebus aequatorialis**, **Cebus brunneus**, **Cebus cesarae**, **Cebus cuscinus**, **Cebus imitator**, **Cebus leucocephalus**, **Cebus malitiosus**, **Cebus polykomos**, **Cebus unicolor**, **Cebus versicolor**, **Cebus yuracus**, **Cephalopachus bancanus**, **Cercocebus lunulatus**, **Cercocebus sanjei**, **Cercopithecus denti**, **Cercopithecus doggetti**, **Cercopithecus kandti**, **Cercopithecus lomamiensis**, **Cercopithecus lowei**, **Cheirogaleus andysabini**, **Cheirogaleus lavasoensis**, **Cheirogaleus minusculus**, **Cheirogaleus thomasi**, **Cheracebus lugens**, **Cheracebus purinus**, **Cheracebus torquatus**, **Chiropotes utahickae**, **Chlorocebus djamdjamensis**, **Daubentonia robusta**, **Euoticus matschiei**, **Galagoides cocos**, **Galagoides orinus**, **Galagoides rondoensis**, **Galagoides thomasi**, **Hylobates entelloides**, **Hylobates funereus**, **Lemur indri**, **Lemur tardigradus**, **Lemur volans**, **Lepilemur grewcockorum**, **Lepilemur hollandorum**, **Lepilemur jamesorum**, **Lepilemur mitsinjoensis**, **Lepilemur scottorum**, **Lepilemur tymerlachsoni**, **Lophocebus johnstoni**, **Lophocebus opdenboschi**, **Lophocebus osmani**, **Lophocebus ugandae**, **Macaca balantak**, **Macaca leucogenys**, **Macaca speciosa**, **Mico acariensis**, **Mico intermedius**, **Mico leucippe**, **Mico marcai**, **Mico nigriceps**, **Microcebus lokobensis**, **Microcebus marohita**, **Microcebus myonixus**, **Microcebus tanosi**, **Nomascus annamensis**, **Nycticebus bancanus**, **Nycticebus borneanus**, **Nycticebus kayan**, **Papio japonicus**, **Papio kindae**, **Phaner electromontis**, **Phaner parienti**, **Piliocolobus bouvieri**, **Piliocolobus epieni**, **Piliocolobus oustaleti**, **Piliocolobus parmentieri**, **Piliocolobus semlikiensis**, **Piliocolobus temminckii**, **Piliocolobus waldronae**, **Pithecia cazuzai**, **Pithecia chrysocephala**, **Pithecia hirsuta**, **Pithecia inusta**, **Pithecia isabela**, **Pithecia milleri**, **Pithecia mittermeieri**, **Pithecia napensis**, **Pithecia pissinattii**, **Pithecia rylandsi**, **Pithecia vanzolinii**, **Plecturocebus bernhardi**, **Plecturocebus brunneus**, **Plecturocebus caligatus**, **Plecturocebus cinerascens**, **Plecturocebus cupreus**, **Plecturocebus donacophilus**, **Plecturocebus hoffmannsi**, **Plecturocebus miltoni**, **Plecturocebus moloch**, **Presbytis bicolor**, **Presbytis canicrus**, **Presbytis mitrata**, **Presbytis natunae**, **Presbytis sabana**, **Presbytis senex**, **Presbytis siamensis**, **Presbytis siberu**, **Presbytis sumatrana**, **Propithecus candidus**, **Pseudopotto martini**, **Pygathrix cinerea 1 RL-2012**, **Pygathrix cinerea 2 RL-2012**, **Rhinopithecus bieti 1 RL-2012**, **Rhinopithecus bieti 2 RL-2012**, **Saguinus cruzlimai**, **Saguinus illigeri**, **Saguinus lagonotus**, **Saguinus leucogenys**, **Saguinus nigrifrons**, **Saguinus pileatus**, **Saguinus ursulus**, **Saguinus weddelli**, **Saimiri cassiquiarensis**, **Saimiri macrodon**, **Sapajus apella**, **Sapajus cay**, **Sapajus flavius**, **Sapajus libidinosus**, **Sapajus nigritus**, **Sapajus xanthosternos**, **Sciurocheirus cameronensis**, **Sciurocheirus makandensis**, **Semnopithecus ajax**, **Semnopithecus hypoleucos**, **Semnopithecus schistaceus**, **Tarsius banacanus**, **Tarsius fuscus**, **Tarsius pelengensis**, **Tarsius tarsius**, **Tarsius tumpara**, **Trachypithecus ebenus**, **Trachypithecus mauritius**, **Trachypithecus selangorensis**, **Trachypithecus shortridgei*

![Primates Species Dated Open Tree of Life Induced Subtree. This chronogram was obtained with `get_dated_otol_induced_subtree()` function.](plots/Primates_datedotol.pdf)


This taxon's SDM matrix has NO negative values.This taxon's Median matrix has NO negative values.


![Primates lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or
  with maximum ages that are just off (too old or too young). So we developped an
  alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Primates_LTTplot_Median.pdf)


![Primates lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or
  with maximum ages that are just off (too old or too young). So we developped an
  alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Primates_LTTplot_sdm.pdf)

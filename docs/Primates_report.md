---
title: "DateLife Workflows"
author: "Luna L. Sanchez Reyes"
date: "2019-05-14"
output: rmarkdown::html_vignette
bibliography: library_red.bib
csl: systematic-biology.csl
link-citations: yes
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

## 1. Query source chronograms
There are 526 species in the Open Tree of Life Taxonomy for the taxon Primates.
Information on time of divergence is available for
355
of these species across 8 published and peer-reviewed chronograms.
Original study citations as well as number of Primates species found across those source
chronograms is shown in Table 1. All source chronograms are fully ultrametric and their maximum
ages range from 62.766 to
90.4 million years ago (MYA).
As a means for comparison, lineage through time plots of all source chronograms
available in data base are shown in Fig. 1


## 2. Summarize results from query

LTT plots are a nice way to visually compare several trees. But what if you want
to summarize information from all source chronograms into a single summary chronogram?

The first step is to identify the degree of species overlap among your source chornograms: if each
source chronogram has a unique sample of species, it will not be possible to combine
them into a single summary chronogram. To identify the set of trees or _grove_ with the most source
chronograms that have at least two overlapping taxa, we followed Ané et al. 2016.
In this case, not all source chronograms found for the  Primates  have at least two overlapping species. The largest grove has  2  chronograms (out of  8  total source chronograms).

Now that we have identified a grove 
we can go on to summarize it by translating the source chronograms into patristic distance matrices and
then averaging them into a single summary matrix; yes, this first step is _that_
straightforward. We can average the source matrices by simply using the mean or
median distances, or we can use methods that involve transforming
the original distance matrices --such as the super distance matrix (SDM) approach of Criscuolo et al. 2006-- by minimizing
the distances across source matrices. As a result of such transformation, an SDM
summary matrix can contain negative values. But, the SDM summary matrix of this taxon has no negative values.

Because our summary matrix is basically a distance matrix, a distance-based clustering
algorithm could be used to reconstruct the tree. Algorithms such as neighbour joining (NJ) and
unweighted pair group method with arithmetic mean (UPGMA) are
fast and work very well when there are no missing values in the matrices. However, summary
matrices coming from source chronograms usually have several NAs and missing rows.
<!--This data set for example has NUMBER cells with missing data.-->
When this happens, variants of traditional clustering algorithms have been developed to deal with missing values.
<!--
NJS: ape::njs
UPGMA: daisy + upgma
BIONJ: ape::bionjs(X)
Minimum Variance Reduction: ape::mvrs(X, V)
Triangle Method, Tree reconstruction based on the triangle method: ape::triangMtds(X)
-->
However, even these methods do not work well with our summary matrices, as shown in the following section.
We should note that these clustering methods are usually applied to distance matrices representing substitution rates
and not absolute time.

###   2.1. Clustering a summary matrix

NJ, UPGMA, BIONJ, minimum variance reduction (MVR) and the triangle method (TM)
algorithms were used to cluster median and SDM summary distance matrices.
None of these clustering algorithms returned trees matching source chronograms
(Fig. 2, Appendix Fig. 5).
UPGMA is the only algorithm that returns ultrametric trees, but they are considerably
older than expected from ages observed in source chronograms.
The other methods returned trees with ages that coincide with those observed in
source chronograms. However, they resulting chronograms are not ultrametric.
To overcome the issues presented by clustering algorithms, we used all data avilable in the summary
matrix as calibrations over a consensus tree to obtain a summary chornogram.


###   2.2. Calibrating a consensus tree with data from a summary matrix

Even if the branch lengths coming form the clustered chronograms are not adequate,
the topology can still be used as a backbone tree that can be dated using data from
the summary matrix as secondry calibrations.
A summary of divergence times available for each node can be obtained from the summary matrix,
simply by getting the nodes from the backbone tree that correspond to each pair of
taxa in the matrix. Finally, this summary of node divergence times can be used with
the consensus tree as input in any dating software that does not require data.
The branch length aduster (BLADJ) algorithm [@Webb2000] is really fast and does
not make any evolutionary assumptions on age distribution. Other software such as
MrBayes and r8s can be used instead of BLADJ by running them without data.
In here, we show summary chronograms obtained using minimum, mean and maximum distances
from the summary of node divergence times of the backbone tree as fixed ages in
BLADJ (Fig. 3).
Summary chronograms from both types of summary matrices are quite similar. As expected,
SDM chronograms using minimum, mean and maximum distances do not vary much in their
maximum age, because ages are transformed to minimize the variance. In contrast,
the median chronograms obtained with minimum, mean and maximum distances have wider variation
in their maximum ages, as can be observed in the distance between the green arrows
in Fig. 3. This variation simply represents variation in source data.


## 3. Generate new chronograms

Another way to leverage information from the source chronograms is to use their node
ages as secondary calibration points to date any tree topology (with or without
branch lengths) given that at least two taxa from source chronograms are in
the tips of that topology.
In this data set we have 2251 calibrations in total (that basically
corresponds to the sum of the number of nodes from each source chronogram).
Once we have a target tree topology, we can map the calibrations to the target tree.
Some nodes will have several calibrations and some others might have none. Also,
some node ages can be conflicting, with descendant nodes being older than parent nodes.
We performed a series of cross validation analyses with different dating methods, by
dating the topologies of each source chronogram using information from all other
source chronograms as calibration points.

### 3.1. Calibrate a tree without branch length data
To date a tree in the absence of data on relative evolutionary rates (molecular
or morphological) we follow the same methodology as the one used to obtain summary
chronograms. First, we obtained the nodes that correspond to each pair of taxa in the data
set of total calibrations to construct a summary of node calibrations for the backbone
tree. Then, we used mean ages as secondary calibrations for the backbone tree with
the software BLADJ. In general, the time of divergence information from other source
chronograms allows to recover the divergence times from the original study. In some cases,
it is evident that information from a particular study really affects the summary
of divergence times. In some other cases, the root of the tree is not calibrated.
Since BLADJ has no underlying model of evolution, there is no way for the algorithm
to calculate this age. To fix this, we simply added a unit of the mean difference across
ranked ages from secondary calibrations (Fig. 4).

### 3.2. Calibrate a tree with data
If you have a tree with branch lengths proportional to relative substitution rates,
you can use the source chronogram node ages as secondary calibrations with various
algorithms for phylogenetic dating to obtain a tree with branch lengths proportional
to absolute time.
To exemplify this, we are getting data from the Barcode of Life Database (BOLD) to obtain
branch lengths as relative DNA substitution rates for a tree topology of our choosing.
We are using the software PATHd8 for tree dating without a molecular clock model.
To deal with conflicting calibrations, we can either expand them to make them agree,
or we can summarize them. Results from both approaches are shown in the two following sections.

### 3.2.1. Expanding calibrations


### 3.2.2. Summarizing calibrations


### 4. Example with subspecies tree
As an example, we're gonna date the subspecies tree of the group (coming from otol).


Now, let's say you like the Open Tree of Life Taxonomy and you want to stick to
that tree. Dates from available studies were tested over the Open Tree of Life
Synthetic tree of Primates and a tree was constructed, but all branch lengths are NA.
We also tried  each source chronogram independently, with the Dated OToL and with
each other, as a form of cross validation in Table 2. This is not working
perfectly yet, but we are developping new ways to use all calibrations efficiently.


## 5. Simulate data/ Add missing taxa
An alternative to generate a dated tree from a set of taxa is to take the available information and simulate into it the missing data.
We will take the median and sdm summary chronograms to date the Synthetic tree of Life:


\newpage

# Tables and Figures


\begin{longtable}{>{\raggedright\arraybackslash}p{0.4cm}>{\raggedright\arraybackslash}p{11cm}>{\raggedright\arraybackslash}p{1.5cm}>{\raggedright\arraybackslash}p{1.8cm}}
\caption{\label{tab:unnamed-chunk-4}Primates source chronogram studies information.}\\
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

\newpage

<!--```{r echo = FALSE}
table_cap <- "Was it successful to use each source chronogram independently as calibration (CalibN) against the Dated Open Tree of Life (dOToL) and each other (ChronoN)?"
table2 <- cbind(tax_eachcal_datedotol, do.call(cbind, tax_crossval))
dimnames(table2) <- list(paste0("Calibrations", seq(tax_crossval)), c("dOToL", paste0("Chrono", seq(tax_crossval))))
if(ncol(table2) < 7) fs <- 10
if(ncol(table2) == 7 | ncol(table2) == 8) fs <- 9
if(ncol(table2) >= 9) fs <- 7
if(ncol(table2) > 10) {
  table2ori <- table2
  table2[table2 == TRUE] <- "yes" # "&#x2611;"  # :tick:
  table2[table2 == "FALSE"] <- "no"  # "&#x2612;"
  dimnames(table2) <- list(paste0("Calib", seq(tax_crossval)),
                           c("dOToL", paste0("Chr", seq(tax_crossval))))
}
tt <- knitr::kable(table2, caption = table_cap, row.names = TRUE, format = "latex", booktabs = TRUE)
kableExtra::kable_styling(kable_input = tt, position = "left", font_size = fs)
```

\newpage

-->


![Lineage through time (LTT) plots of source chronograms available in data base
  for species in the Primates. Numbers correspond to original studies in Table 1. Arrows indicate maximum age of each chronogram.](plots/Primates_LTTplot_phyloall.pdf)

\newpage


![Lineage Through Time plots of Primates median summary
chronograms obtained with different clustering algorithms. Not all algorithms worked
with this summary matrix and we are only showing here the ones that worked.
Chronograms obtained from the SDM summary matrix are very similar to the ones from
the median summary matrix with all clustering algorithms (Appendix Fig. 5).](plots/Primates_lttplot_cluster_median.pdf)

\newpage


![Primates lineage through time (LTT) plots from
    source chronograms (gray), median (green) and SDM (blue) summary chronograms
    obtained by calibrating a consensus tree tropology with distance data
    from respective summary matrices and then adjusting branch lengths with BLADJ.](plots/Primates_LTTplot_summary_chronograms.pdf)

\newpage



![Primates lineage through time (LTT) plots from
    source chronograms used as secondary calibrations (gray), source chronograms
    used as topology (purple) and chronograms resulting from calibrating the latter
    with the former, using BLADJ (green).](plots/Primates_LTTplot_crossval_bladj.pdf)
\newpage


\newpage

# Appendix
The following species were completely absent from the chronogram data base:  *Alouatta arctoidea**, **Alouatta discolor**, **Alouatta stramineus**, **Alouatta ululata**, **Aotus azarae**, **Aotus jorgehernandezi**, **Aotus zonalis**, **Avahi mooreorum**, **Avahi ramanantsoavani**, **Cacajao rubicundus**, **Callicebus aureipalatii**, **Callicebus baptista**, **Callicebus barbarabrownae**, **Callicebus caquetenesis**, **Callicebus caquetensis**, **Callicebus discolor**, **Callicebus lucifer**, **Callicebus medemi**, **Callicebus melanochir**, **Callicebus miltoni**, **Callicebus ornatus**, **Callicebus pallescens**, **Callicebus regulus**, **Callicebus stephennashi**, **Callicebus toppinii**, **Callicebus urubambensis**, **Callicebus vieirai**, **Callithrix cf. emiliae**, **Callithrix chrysoleuca**, **Carlito syrichta**, **Cebus aequatorialis**, **Cebus brunneus**, **Cebus cesarae**, **Cebus cuscinus**, **Cebus imitator**, **Cebus leucocephalus**, **Cebus malitiosus**, **Cebus polykomos**, **Cebus unicolor**, **Cebus versicolor**, **Cebus yuracus**, **Cephalopachus bancanus**, **Cercocebus lunulatus**, **Cercocebus sanjei**, **Cercopithecus denti**, **Cercopithecus doggetti**, **Cercopithecus kandti**, **Cercopithecus lomamiensis**, **Cercopithecus lowei**, **Cheirogaleus andysabini**, **Cheirogaleus lavasoensis**, **Cheirogaleus minusculus**, **Cheirogaleus thomasi**, **Cheracebus lugens**, **Cheracebus purinus**, **Cheracebus torquatus**, **Chiropotes utahickae**, **Chlorocebus djamdjamensis**, **Daubentonia robusta**, **Euoticus matschiei**, **Galagoides cocos**, **Galagoides orinus**, **Galagoides rondoensis**, **Galagoides thomasi**, **Hylobates entelloides**, **Hylobates funereus**, **Lemur indri**, **Lemur tardigradus**, **Lemur volans**, **Lepilemur grewcockorum**, **Lepilemur hollandorum**, **Lepilemur jamesorum**, **Lepilemur mitsinjoensis**, **Lepilemur scottorum**, **Lepilemur tymerlachsoni**, **Lophocebus johnstoni**, **Lophocebus opdenboschi**, **Lophocebus osmani**, **Lophocebus ugandae**, **Macaca balantak**, **Macaca leucogenys**, **Macaca speciosa**, **Mico acariensis**, **Mico intermedius**, **Mico leucippe**, **Mico marcai**, **Mico nigriceps**, **Microcebus lokobensis**, **Microcebus marohita**, **Microcebus myonixus**, **Microcebus tanosi**, **Nomascus annamensis**, **Nycticebus bancanus**, **Nycticebus borneanus**, **Nycticebus kayan**, **Papio japonicus**, **Papio kindae**, **Phaner electromontis**, **Phaner parienti**, **Piliocolobus bouvieri**, **Piliocolobus epieni**, **Piliocolobus oustaleti**, **Piliocolobus parmentieri**, **Piliocolobus semlikiensis**, **Piliocolobus temminckii**, **Piliocolobus waldronae**, **Pithecia cazuzai**, **Pithecia chrysocephala**, **Pithecia hirsuta**, **Pithecia inusta**, **Pithecia isabela**, **Pithecia milleri**, **Pithecia mittermeieri**, **Pithecia napensis**, **Pithecia pissinattii**, **Pithecia rylandsi**, **Pithecia vanzolinii**, **Plecturocebus bernhardi**, **Plecturocebus brunneus**, **Plecturocebus caligatus**, **Plecturocebus cinerascens**, **Plecturocebus cupreus**, **Plecturocebus donacophilus**, **Plecturocebus hoffmannsi**, **Plecturocebus miltoni**, **Plecturocebus moloch**, **Presbytis bicolor**, **Presbytis canicrus**, **Presbytis mitrata**, **Presbytis natunae**, **Presbytis sabana**, **Presbytis senex**, **Presbytis siamensis**, **Presbytis siberu**, **Presbytis sumatrana**, **Propithecus candidus**, **Pseudopotto martini**, **Pygathrix cinerea 1 RL-2012**, **Pygathrix cinerea 2 RL-2012**, **Rhinopithecus bieti 1 RL-2012**, **Rhinopithecus bieti 2 RL-2012**, **Saguinus cruzlimai**, **Saguinus illigeri**, **Saguinus lagonotus**, **Saguinus leucogenys**, **Saguinus nigrifrons**, **Saguinus pileatus**, **Saguinus ursulus**, **Saguinus weddelli**, **Saimiri cassiquiarensis**, **Saimiri macrodon**, **Sapajus apella**, **Sapajus cay**, **Sapajus flavius**, **Sapajus libidinosus**, **Sapajus nigritus**, **Sapajus xanthosternos**, **Sciurocheirus cameronensis**, **Sciurocheirus makandensis**, **Semnopithecus ajax**, **Semnopithecus hypoleucos**, **Semnopithecus schistaceus**, **Tarsius banacanus**, **Tarsius fuscus**, **Tarsius pelengensis**, **Tarsius tarsius**, **Tarsius tumpara**, **Trachypithecus ebenus**, **Trachypithecus mauritius**, **Trachypithecus selangorensis**, **Trachypithecus shortridgei*


![Lineage Through Time plots of Primates SDM summary
chronograms obtained with different clustering algorithms. Not all algorithms worked
with the SDM summary matrix and we are only showing here the ones that worked.
Chronograms obtained from the median summary matrix are very similar to the ones shown
here with all algorithms (mainFig. 2).](plots/Primates_lttplot_cluster_median.pdf)


Dated induced subtree could not be obtained for the Primates.


This taxon's SDM matrix has NO negative values.This taxon's Median matrix has NO negative values.

![Primates lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or
  with maximum ages that are just off (too old or too young). So we developped an
  alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Primates_LTTplot_Median.pdf)


![Primates lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or
  with maximum ages that are just off (too old or too young). So we developped an
  alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Primates_LTTplot_sdm.pdf)


![Primates lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with `datelife` algorithm.](plots/Primates_LTTplot_summtrees_Median.pdf)

![Primates lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with `datelife` algorithm.](plots/Primates_LTTplot_summtrees_SDM.pdf)

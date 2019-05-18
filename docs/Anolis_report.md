---
title: "DateLife Workflows"
author: "Luna L. Sanchez Reyes"
date: "2019-05-16"
output: bookdown::pdf_document2
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

# Taxon Anolis

## 1. Query source chronograms
There are 458 subspecies in the Open Tree of Life Taxonomy for the taxon Anolis.
Information on time of divergence is available for
302
of these species across 6 published and peer-reviewed chronograms.
Original study citations as well as number of Anolis species found across those source
chronograms is shown in Table 1. All source chronograms are fully ultrametric and their maximum
ages range from 47.843 to
72.578 million years ago (MYA).
As a means for comparison, lineage through time plots of all source chronograms
available in data base are shown in figure \ref{fig:lttplot_phyloall}.


## 2. Summarize results from query

LTT plots are a nice way to visually compare several trees. But what if you want
to summarize information from all source chronograms into a single summary chronogram?

The first step is to identify the degree of species overlap among your source chronograms: if each
source chronogram has a unique sample of species, it will not be possible to combine
them into a single summary chronogram. To identify the set of trees or _grove_ with the most source
chronograms that have at least two overlapping taxa, we followed Ané et al. 2016.
In this case, not all source chronograms found for the  Anolis  have at least two overlapping species. The largest grove has  2  chronograms (out of  6  total source chronograms).

Now that we have identified a grove 
we can go on to summarize it by translating the source chronograms into patristic distance matrices and
then averaging them into a single summary matrix; yes, this first step is _that_
straightforward. We can average the source matrices by simply using the mean or
median distances, or we can use methods that involve transforming
the original distance matrices --such as the super distance matrix (SDM) approach of Criscuolo et al. 2006-- by minimizing
the distances across source matrices. As a result of such transformation, an SDM
summary matrix can contain negative values. In this case, the SDM summary matrix has some negative values in the following taxa: *Anolis porcus*, *Anolis guamuhaya*, *Chamaeleolis chameleontides*, *Chamaeleolis chameleontides*. 

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
(Fig. \ref{fig:lttplot_cluster_median}, Appendix Fig. \ref{fig:lttplot_cluster_sdm}).
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
In this data set we have 1183 calibrations in total (that basically
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
algorithms for phylogenetic dating to get branch lengths proportional to absolute time.
To exemplify this, we got DNA markers from the Barcode of Life Database (BOLD)
to estimate branch lengths as relative DNA substitution rates on a tree topology of our choosing.
In this example we retrieved data from the cytochrome C oxidase subunit I (COI) marker, that is of
widespread use in barcoding, providing DNA data for a very wide number of organisms.
<!-- source_chronogram_bold_tree <- make_bold_otol_tree(input = source_chronogram_topology,
marker = "COI", otol_version = "v3", chronogram = TRUE)
source_chronogram_bold_tree_notc <- make_bold_otol_tree(input = source_chronogram_topology,
marker = "COI", otol_version = "v3", chronogram = FALSE)
-->
A tree with branch lengths could be constructed for 6 source chronograms (out of 6) available for the Anolis. To date these
        trees we are using the software PATHd8 for tree dating without a molecular
        clock model, using calibrations from all other source chronograms. Sometimes,
        calibrations conflict between them. To deal with conflicting calibrations, we can either
        expand them to make them agree, or we can congruify them to the topology
        of the tree to be dated.
        Results from both approaches are shown in the following two sections.

### 3.2.1. Expanding calibrations

### 3.2.2. Summarizing calibrations (congruifying calibrations)




<!--
## 4. Simulate data/ Add missing taxa
Finally, if data can be added to An alternative to generate a dated tree from a set of taxa is to take the available
information and simulate into it the missing data.
We will take the median and sdm summary chronograms to date the Synthetic tree of Life:

-->

\newpage

## 4. Example with subspecies tree
As an example, we're gonna date the subspecies tree of the group using all approaches
for generating new data.


Now, let's say you like the Open Tree of Life Taxonomy and you want to stick to
that tree. Dates from available studies were tested over the Open Tree of Life
Synthetic tree of Anolis and a tree was constructed, but all branch lengths are NA.
We also tried  each source chronogram independently, with the Dated OToL and with
each other, as a form of cross validation in Table 2. This is not working
perfectly yet, but we are developping new ways to use all calibrations efficiently.

\newpage

# Tables and Figures


\begin{longtable}{>{\raggedright\arraybackslash}p{0.4cm}>{\raggedright\arraybackslash}p{11cm}>{\raggedright\arraybackslash}p{1.5cm}>{\raggedright\arraybackslash}p{1.8cm}}
\caption{\label{tab:unnamed-chunk-6}Anolis source chronogram studies information.}\\
\toprule
\multicolumn{1}{>{\centering\arraybackslash}p{0.4cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{   }}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{11cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Citation}}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{1.5cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Source N}}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{1.8cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Taxon N}}\endgroup}\\
\midrule
\multicolumn{1}{r}{\em{\textbf{1.}}} & \bgroup\fontsize{8}{10}\selectfont Hedges, S. Blair, Julie Marin, Michael Suleski, Madeline Paymer, Sudhir Kumar. 2015. Tree of life reveals clock-like speciation and diversification. Molecular Biology and Evolution 32 (4): 835-845\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{192/458}\\
\multicolumn{1}{r}{\em{\textbf{2.}}} & \bgroup\fontsize{8}{10}\selectfont Mahler, D. L., T. Ingram, L. J. Revell, J. B. Losos. 2013. Exceptional Convergence on the Macroevolutionary Landscape in Island Lizard Radiations. Science 341 (6143): 292-295.\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{98/458}\\
\multicolumn{1}{r}{\em{\textbf{3.}}} & \bgroup\fontsize{8}{10}\selectfont Pyron, R. Alexander, Frank T. Burbrink. 2013. Early origin of viviparity and multiple reversions to oviparity in squamate reptiles. Ecology Letters 17 (1): 13-21\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{205/458}\\
\multicolumn{1}{r}{\em{\textbf{4.}}} & \bgroup\fontsize{8}{10}\selectfont Steven Poe, Adrián Nieto-montes de oca, Omar Torres-carvajal, Kevin De Queiroz, Julián A. Velasco, Brad Truett, Levi N. Gray, Mason J. Ryan, Gunther Köhler, Fernando Ayala-varela, Ian Latella, 2017, 'A Phylogenetic, Biogeographic, and Taxonomic study of all Extant Species of Anolis (Squamata; Iguanidae)', Systematic Biology, vol. 66, no. 5, pp. 663-697\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{289/458}\\
\multicolumn{1}{r}{\em{\textbf{5.}}} & \bgroup\fontsize{8}{10}\selectfont Wright, April M., Kathleen M. Lyons, Matthew C. Brandley, David M. Hillis. 2015. Which came first: The lizard or the egg? Robustness in phylogenetic reconstruction of ancestral states. Journal of Experimental Zoology Part B: Molecular and Developmental Evolution 324 (6): 504-516\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{203/458}\\
\multicolumn{1}{r}{\em{\textbf{6.}}} & \bgroup\fontsize{8}{10}\selectfont Yuchi Zheng, John J. Wiens, 2016, 'Combining phylogenomic and supermatrix approaches, and a time-calibrated phylogeny for squamate reptiles (lizards and snakes) based on 52 genes and 4162 species', Molecular Phylogenetics and Evolution, vol. 94, pp. 537-547\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{202/458}\\
\bottomrule
\multicolumn{4}{l}{{\textbf{\textit{Source N}}}: Number of source chronograms reported in study.}\\
\multicolumn{4}{l}{{\textbf{\textit{Taxon N}}}: Number of queried taxa found in source chronograms.}\\
\end{longtable}

<!--
\newpage

\begin{table}[t]

\caption{\label{tab:unnamed-chunk-7}Was it successful to use each source chronogram independently as calibration (CalibN) against the Dated Open Tree of Life (dOToL) and each other (ChronoN)?}
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
-->
\newpage


\begin{figure}[h!]
	\includegraphics{plots/Anolis_LTTplot_phyloall.pdf}
	\caption{Lineage through time (LTT) plots of source chronograms available in data base
  for species in the Anolis. Numbers correspond to original studies in Table 1. Arrows indicate maximum age of each chronogram.}
	\label{fig:lttplot_phyloall}
\end{figure}

\newpage


\begin{figure}[h!]
	\includegraphics{plots/Anolis_lttplot_cluster_median.pdf}
	\caption{Lineage Through Time plots of Anolis median summary
chronograms obtained with different clustering algorithms. Not all algorithms worked
with this summary matrix and we are only showing here the ones that worked.
Chronograms obtained from the SDM summary matrix are very similar to the ones from
the median summary matrix with all clustering algorithms (Appendix Fig. \ref{fig:lttplot_cluster_sdm}).}
	\label{fig:lttplot_cluster_median}
\end{figure}

\newpage


\begin{figure}[h!]
	\includegraphics{plots/Anolis_LTTplot_summary_chronograms.pdf}
	\caption{Anolis lineage through time (LTT) plots from
    source chronograms (gray), median (green) and SDM (blue) summary chronograms
    obtained by calibrating a consensus tree tropology with distance data
    from respective summary matrices and then adjusting branch lengths with BLADJ.}
	\label{fig:lttplot_summchrono}
\end{figure}

\newpage


\begin{figure}[h!]
	\includegraphics{plots/Anolis_LTTplot_crossval_bladj.pdf}
	\caption{Anolis lineage through time (LTT) plots from
    source chronograms used as secondary calibrations (gray), source chronograms
    used as topology (purple) and chronograms resulting from calibrating the latter
    with the former, using BLADJ (green).}
	\label{fig:lttplot_crossval_bladj}
\end{figure}
\break
\newpage

# Appendix
The following species were not found in the chronogram database:  *Anolis alocomyos**, **Anolis altavelensis**, **Anolis anfiloquioi**, **Anolis anisolepis**, **Anolis attenuatus**, **Anolis bellipeniculus**, **Anolis birama**, **Anolis breedlovei**, **Anolis caquetae**, **Anolis carlliebi**, **Anolis carlostoddi**, **Anolis cf. alocomyos GK-2015**, **Anolis cf. humilis JJK-2013**, **Anolis cf. polylepis**, **Anolis charlesmyersi**, **Anolis chlorocyaneus**, **Anolis chrysops**, **Anolis concolor**, **Anolis cuscoensis**, **Anolis damulus**, **Anolis delafuentei**, **Anolis deltae**, **Anolis desiradei**, **Anolis dissimilis**, **Anolis eewi**, **Anolis fairchildi**, **Anolis forbesorum**, **Anolis fugitivus**, **Anolis gibbiceps**, **Anolis haguei**, **Anolis ibague**, **Anolis immaculogularis**, **Anolis impetigosus**, **Anolis incredulus**, **Anolis juangundlachi**, **Anolis kreutzi**, **Anolis laevis**, **Anolis lamari**, **Anolis landestoyi**, **Anolis leditzigorum**, **Anolis lemniscatus**, **Anolis limon**, **Anolis menta**, **Anolis microlepis**, **Anolis mirus**, **Anolis morazani**, **Anolis muralla**, **Anolis nasofrontalis**, **Anolis nietoi**, **Anolis nigrolineatus**, **Anolis osa**, **Anolis paravertebralis**, **Anolis philopunctatus**, **Anolis phyllorhinus**, **Anolis pigmaequestris**, **Anolis pijolense**, **Anolis pinchoti**, **Anolis propinquus**, **Anolis pseudotigrinus**, **Anolis purpurescens**, **Anolis radulinus**, **Anolis rhombifer**, **Anolis rimarum**, **Anolis rivalis**, **Anolis roosevelti**, **Anolis ruibali**, **Anolis ruizi**, **Anolis rupinae**, **Anolis sacamecatensis**, **Anolis santamartae**, **Anolis scapularis**, **Anolis schiedei**, **Anolis schmidti**, **Anolis sierramaestrae**, **Anolis simmonsi**, **Anolis solitarius**, **Anolis spectrum**, **Anolis squamulatus**, **Anolis stevepoei**, **Anolis tenorioensis**, **Anolis terueli**, **Anolis tetarii**, **Anolis toldo**, **Anolis umbrivagus**, **Anolis utowanae**, **Anolis vaupesianus**, **Anolis vescus**, **Anolis vicarius**, **Anolis villai**, **Anolis wampuensis**, **Anolis wattsii**, **Anolis wermuthi**, **Anolis williamsii**, **Anolis zapotecorum**, **Ctenonotus cybotes**, **Ctenonotus ferreus**, **Ctenonotus pulchellus**, **Norops alvarezdeltoroi**, **Norops anisolepis**, **Norops antonii**, **Norops baccatus**, **Norops birama**, **Norops bocourtii**, **Norops bouvierii**, **Norops breedlovei**, **Norops chrysolepis**, **Norops cobanensis**, **Norops concolor**, **Norops conspersus**, **Norops cumingii**, **Norops cuprinus**, **Norops cymbops**, **Norops damulus**, **Norops delafuentei**, **Norops dollfusianus**, **Norops exsul**, **Norops forbesi**, **Norops fungosus**, **Norops gibbiceps**, **Norops granuliceps**, **Norops haguei**, **Norops hobartsmithi**, **Norops ibague**, **Norops imias**, **Norops johnmeyeri**, **Norops lemniscatus**, **Norops lineatus**, **Norops lynchi**, **Norops macrolepis**, **Norops macrophallus**, **Norops maculiventris**, **Norops mariarum**, **Norops matudai**, **Norops microlepis**, **Norops milleri**, **Norops notopholis**, **Norops opalinus**, **Norops parvicirculatus**, **Norops pentaprion**, **Norops petersii**, **Norops pinchoti**, **Norops pygmaeus**, **Norops rhombifer**, **Norops rivalis**, **Norops salvini**, **Norops scapularis**, **Norops schiedei**, **Norops schmidti**, **Norops simmonsi**, **Norops sulcifrons**, **Norops tolimensis**, **Norops utowanae**, **Norops vicarius**, **Norops villai**, **Norops vittigerus**, **Norops vociferans*


\begin{figure}[h!]
	\includegraphics{plots/Anolis_lttplot_cluster_sdm.pdf}
	\caption{Lineage Through Time plots of Anolis SDM summary
chronograms obtained with different clustering algorithms. Not all algorithms worked
with the SDM summary matrix and we are only showing here the ones that worked.
Chronograms obtained from the median summary matrix are very similar to the ones shown
here with all algorithms (main figure \ref{fig:lttplot_cluster_median}).}
	\label{fig:lttplot_cluster-sdm}
\end{figure}


Dated induced subtree could not be obtained for the Anolis.


This taxon's SDM matrix has some negative values in the following taxa: *Anolis porcus*, *Anolis guamuhaya*, *Chamaeleolis chameleontides*, *Chamaeleolis chameleontides*. This taxon's Median matrix has NO negative values.

![Anolis lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or
  with maximum ages that are just off (too old or too young). So we developped an
  alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Anolis_LTTplot_Median.pdf)


![Anolis lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with different methods (NJ and UPGMA). As you can note, dashed lines and solid lines from trees coming out from both types of clustering algorithms implemented are mostly overlapping. This means that removing negative values does not change results from clustering algorithms much. Clustering algorithms used often are returning non-ultrametric trees or
  with maximum ages that are just off (too old or too young). So we developped an
  alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Anolis_LTTplot_sdm.pdf)


![Anolis lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with `datelife` algorithm.](plots/Anolis_LTTplot_summtrees_Median.pdf)

![Anolis lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with `datelife` algorithm.](plots/Anolis_LTTplot_summtrees_SDM.pdf)

---
title: "DateLife Workflows"
author: "Luna L. Sanchez Reyes"
date: "2019-06-18"
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

# Taxon Primates

## 1. Query source chronograms
There are 391 species in the taxon Primates, following the NCBI taxonomy database.
Information on time of divergence is available for
331
of these species across 8 published and peer-reviewed chronograms.
Original study citations as well as number of Primates species found across those source
chronograms is shown in `Table` \ref{tab:source_chr}. All source chronograms are fully ultrametric and their maximum
ages range from 62.766 to
90.4 million years ago (MYA).
As a means for comparison, lineage through time plots of all source chronograms
available in data base are shown in `Figure` \ref{fig:lttplot_phyloall}.

## 2. Summarize results from query

LTT plots are a nice way to visually compare several trees. But what if you want
to summarize information from all source chronograms into a single summary chronogram?

The first step is to identify the degree of species overlap among your source chronograms: if each
source chronogram has a unique sample of species, it will not be possible to combine
them into a single summary chronogram. To identify the set of trees or _grove_ with the most source
chronograms that have at least two overlapping taxa, we followed Ané et al. 2016.
In the case of the  Primates  all source chronograms have at least two overlapping species.

Now that we know that the best grove has all source chronograms 
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
BLADJ (`Figure` \ref{fig:lttplot_summchrono}).
Summary chronograms from both types of summary matrices are quite similar. As expected,
SDM chronograms using minimum, mean and maximum distances do not vary much in their
maximum age, because ages are transformed to minimize the variance. In contrast,
the median chronograms obtained with minimum, mean and maximum distances have wider variation
in their maximum ages, as can be observed in the distance between the green arrows
in `Figure` \ref{fig:lttplot_summchrono}. This variation simply represents variation in source data.

## 3. Generate new chronograms

Another way to take advantage of the information available in source chronograms
is to use their node
ages as secondary calibration points to date any tree topology (with or without
branch lengths) given that at least two taxa from source chronograms are in
the tips of the topology of interest.
In this data set we have 2149 calibrations in total (that basically
corresponds to the sum of the number of nodes from each source chronogram).
Once we have chosen or generated a target tree topology, we can map the calibrations to the target tree.
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
tree. Then, we apply minimum, mean or maximum node ages as secondary calibrations
over the backbone tree using the software BLADJ.
In general, the time of divergence information from other source
chronograms allows to recover the divergence times from the original study (`Figure`
  \ref{fig:lttplot_crossval_bladj}). In some cases,
it is evident that information from a particular study really affects the summary
of divergence times. In some other cases, the root of the tree is not calibrated.
Since BLADJ has no underlying model of evolution, there is no way for the algorithm
to calculate this age. To fix this, we simply added a unit of the mean difference
across ranked ages from secondary calibrations.

### 3.2. Calibrate a tree with data
If you have a tree with branch lengths proportional to relative substitution rates,
you can use the source chronogram node ages as secondary calibrations with
other algorithms for phylogenetic dating to get branch lengths proportional to
absolute time such as PATHd8, treePL and MrBayes.
To exemplify this, we got DNA markers from the Barcode of Life Database (BOLD)
to estimate branch lengths as relative DNA substitution rates on a backbone tree topology.
For this example, we retrieved data from the cytochrome C oxidase subunit I (COI) marker, that is of
widespread use in barcoding, providing DNA data for a wide number of organisms.
<!-- source_chronogram_bold_tree <- make_bold_otol_tree(input = source_chronogram_topology,
marker = "COI", otol_version = "v3", chronogram = TRUE)
source_chronogram_bold_tree_notc <- make_bold_otol_tree(input = source_chronogram_topology,
marker = "COI", otol_version = "v3", chronogram = FALSE)
-->
A tree with branch lengths could be constructed for 8 source chronograms (out of 8) available for the Primates. To date these
        trees we use the software PATHd8 for tree dating without a molecular
        clock model, using calibrations from all other source chronograms. Sometimes,
        calibrations conflict between them. To deal with conflicting calibrations,
        we can either expand them to make them agree, or we can congruify them to
        the topology of the tree to be dated. 



\newpage

# Tables and Figures


\begin{longtable}{>{\raggedright\arraybackslash}p{0.4cm}>{\raggedright\arraybackslash}p{11cm}>{\raggedright\arraybackslash}p{1.5cm}>{\raggedright\arraybackslash}p{1.8cm}}
\caption{\label{tab:source_chr}Primates source chronogram original studies information.}\\
\toprule
\multicolumn{1}{>{\centering\arraybackslash}p{0.4cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{   }}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{11cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Citation}}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{1.5cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Source N}}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{1.8cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Taxon N}}\endgroup}\\
\midrule
\multicolumn{1}{r}{\em{\textbf{1.}}} & \bgroup\fontsize{8}{10}\selectfont Bininda-Emonds, Olaf R. P., Marcel Cardillo, Kate E. Jones, Ross D. E. MacPhee, Robin M. D. Beck, Richard Grenyer, Samantha A. Price, Rutger A. Vos, John L. Gittleman, Andy Purvis. 2007. The delayed rise of present-day mammals. Nature 446 (7135): 507-512\egroup{} & \multicolumn{1}{c}{3} & \multicolumn{1}{c}{201/391}\\
\multicolumn{1}{r}{\em{\textbf{2.}}} & \bgroup\fontsize{8}{10}\selectfont Hedges, S. Blair, Julie Marin, Michael Suleski, Madeline Paymer, Sudhir Kumar. 2015. Tree of life reveals clock-like speciation and diversification. Molecular Biology and Evolution 32 (4): 835-845\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{290/391}\\
\multicolumn{1}{r}{\em{\textbf{3.}}} & \bgroup\fontsize{8}{10}\selectfont Springer, Mark S., Robert W. Meredith, John Gatesy, Christopher A. Emerling, Jong Park, Daniel L. Rabosky, Tanja Stadler, Cynthia Steiner, Oliver A. Ryder, Jan E. Janečka, Colleen A. Fisher, William J. Murphy. 2012. Macroevolutionary dynamics and historical biogeography of primate diversification inferred from a species supermatrix. PLoS ONE 7 (11): e49521.\egroup{} & \multicolumn{1}{c}{4} & \multicolumn{1}{c}{316/391}\\
\bottomrule
\multicolumn{4}{l}{{\textbf{\textit{Source N}}}: Number of source chronograms reported in study.}\\
\multicolumn{4}{l}{{\textbf{\textit{Taxon N}}}: Number of queried taxa found in source chronograms.}\\
\end{longtable}
\newpage


\begin{figure}[!h]
\includegraphics{plots/Primates_LTTplot_phyloall.pdf}
\caption{Lineage through time (LTT) plots of source chronograms
  available in database for species in the Primates. Numbers correspond to original
  studies in Table \ref{tab:source_chr}. Arrows indicate maximum age of each chronogram.}
\label{fig:lttplot_phyloall}
\end{figure}

\newpage


\begin{figure}[!h]
\includegraphics{plots/Primates_lttplot_cluster_median.pdf}
\caption{Lineage Through Time plots of Primates median summary
chronograms obtained with different clustering algorithms. Not all algorithms worked
with this summary matrix and we are only showing here the ones that worked.
Chronograms obtained from the SDM summary matrix are very similar to the ones from
the median summary matrix with all clustering algorithms (Appendix Fig. \ref{fig:lttplot_cluster_sdm}).}
\label{fig:lttplot_cluster_median}
\end{figure}

\newpage


\begin{figure}[!h]
\includegraphics{plots/Primates_LTTplot_summary_chronograms2.pdf}
\caption{Primates lineage through time (LTT) plots of summary chronograms
    obtained by calibrating a consensus tree tropology with distance data
    from median (upper) and SDM (lower) summary matrices and then adjusting branch
    lengths with BLADJ. Source chronograms are shown in gray for comparison.}
\label{fig:lttplot_summchrono}
\end{figure}

\newpage


\begin{figure}[!h]
\includegraphics{plots/Primates_LTTplot_crossval_bladj.pdf}
\caption{Primates lineage through time (LTT) plots from
    source chronograms used as secondary calibrations (gray), source chronograms
    used as topology (purple) and chronograms resulting from calibrating the latter
    with the former, using BLADJ (green).}
\label{fig:lttplot_crossval_bladj}
\end{figure}


\newpage



\newpage



# Appendix

The following species were not found in the chronogram database:  *Alouatta stramineus**, **Aotus azarae**, **Aotus zonalis**, **Cacajao rubicundus**, **Callicebus caquetensis**, **Callicebus discolor**, **Callicebus ornatus**, **Callithrix cf. emiliae**, **Callithrix chrysoleuca**, **Carlito syrichta**, **Cercopithecus denti**, **Cercopithecus doggetti**, **Cercopithecus kandti**, **Cercopithecus lomamiensis**, **Cheirogaleus lavasoensis**, **Cheirogaleus minusculus**, **Cheracebus lugens**, **Cheracebus purinus**, **Cheracebus torquatus**, **Chiropotes utahickae**, **Chlorocebus djamdjamensis**, **Galagoides cocos**, **Galagoides orinus**, **Galagoides rondoensis**, **Galagoides thomasi**, **Lepilemur mitsinjoensis**, **Macaca balantak**, **Macaca leucogenys**, **Macaca speciosa**, **Microcebus lokobensis**, **Microcebus marohita**, **Microcebus tanosi**, **Nomascus annamensis**, **Papio kindae**, **Phaner electromontis**, **Phaner parienti**, **Plecturocebus bernhardi**, **Plecturocebus brunneus**, **Plecturocebus caligatus**, **Plecturocebus cinerascens**, **Plecturocebus cupreus**, **Plecturocebus donacophilus**, **Plecturocebus hoffmannsi**, **Plecturocebus miltoni**, **Plecturocebus moloch**, **Presbytis senex**, **Propithecus candidus**, **Pygathrix cinerea 1 RL-2012**, **Pygathrix cinerea 2 RL-2012**, **Rhinopithecus bieti 1 RL-2012**, **Rhinopithecus bieti 2 RL-2012**, **Sapajus apella**, **Sapajus cay**, **Sapajus flavius**, **Sapajus libidinosus**, **Sapajus nigritus**, **Sapajus xanthosternos**, **Semnopithecus hypoleucos**, **Tarsius fuscus**, **Trachypithecus shortridgei*
\begin{figure}[!h]
\includegraphics{plots/Primates_lttplot_cluster_sdm.pdf}
\caption{Lineage Through Time plots of Primates SDM summary
chronograms obtained with different clustering algorithms. Not all algorithms worked
with the SDM summary matrix and we are only showing here the ones that worked.
Chronograms obtained from the median summary matrix are very similar to the ones shown
here with all algorithms (main figure \ref{fig:lttplot_cluster_median}).}
\label{fig:lttplot_cluster_sdm}
\end{figure}

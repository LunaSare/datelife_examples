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

# Taxon Spheniscidae

## 1. Query source chronograms
There are 20 species in the taxon Spheniscidae, following the NCBI taxonomy database.
Information on time of divergence is available for
19
of these species across 13 published and peer-reviewed chronograms.
Original study citations as well as number of Spheniscidae species found across those source
chronograms is shown in `Table` \ref{tab:source_chr}. All source chronograms are fully ultrametric and their maximum
ages range from 12.663 to
38.961 million years ago (MYA).
As a means for comparison, lineage through time plots of all source chronograms
available in data base are shown in `Figure` \ref{fig:lttplot_phyloall}.

## 2. Summarize results from query

LTT plots are a nice way to visually compare several trees. But what if you want
to summarize information from all source chronograms into a single summary chronogram?

The first step is to identify the degree of species overlap among your source chronograms: if each
source chronogram has a unique sample of species, it will not be possible to combine
them into a single summary chronogram. To identify the set of trees or _grove_ with the most source
chronograms that have at least two overlapping taxa, we followed Ané et al. 2016.
In the case of the  Spheniscidae  all source chronograms have at least two overlapping species.

Now that we know that the best grove has all source chronograms 
we can go on to summarize it by translating the source chronograms into patristic distance matrices and
then averaging them into a single summary matrix; yes, this first step is _that_
straightforward. We can average the source matrices by simply using the mean or
median distances, or we can use methods that involve transforming
the original distance matrices --such as the super distance matrix (SDM) approach of Criscuolo et al. 2006-- by minimizing
the distances across source matrices. As a result of such transformation, an SDM
summary matrix can contain negative values. In this case, the SDM summary matrix has some negative values in the following taxa: *Eudyptes chrysocome*, *Eudyptes filholi*. 

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
In this data set we have 102 calibrations in total (that basically
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
A tree with branch lengths could be constructed for 13 source chronograms (out of 13) available for the Spheniscidae. To date these
        trees we use the software PATHd8 for tree dating without a molecular
        clock model, using calibrations from all other source chronograms. Sometimes,
        calibrations conflict between them. To deal with conflicting calibrations,
        we can either expand them to make them agree, or we can congruify them to
        the topology of the tree to be dated. Results from both approaches are shown in the following two sections.

### 3.2.1. Expanding calibrations
Here discuss `Figure` \ref{fig:lttplot_crossval_pathd8_exp1}.

### 3.2.2. Summarizing calibrations (congruifying calibrations)
Here discuss `Figure` \ref{fig:lttplot_crossval_pathd8_summ1}.
Unfortunately, dating trees from BOLD in this example with PATHd8 was not
        succesful. Using alternative software to construct a tree with branch lengths from more
        DNA markers should allow us to improve this results.



\newpage

# Tables and Figures


\begin{longtable}{>{\raggedright\arraybackslash}p{0.4cm}>{\raggedright\arraybackslash}p{11cm}>{\raggedright\arraybackslash}p{1.5cm}>{\raggedright\arraybackslash}p{1.8cm}}
\caption{\label{tab:source_chr}Spheniscidae source chronogram original studies information.}\\
\toprule
\multicolumn{1}{>{\centering\arraybackslash}p{0.4cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{   }}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{11cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Citation}}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{1.5cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Source N}}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{1.8cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Taxon N}}\endgroup}\\
\midrule
\multicolumn{1}{r}{\em{\textbf{1.}}} & \bgroup\fontsize{8}{10}\selectfont Claramunt, Santiago, Joel Cracraft. 2015. A new time tree reveals Earth historys imprint on the evolution of modern birds. Science Advances 1 (11): e1501005-e1501005\egroup{} & \multicolumn{1}{c}{2} & \multicolumn{1}{c}{2/20}\\
\multicolumn{1}{r}{\em{\textbf{2.}}} & \bgroup\fontsize{8}{10}\selectfont García–R, Juan C., Gillian C. Gibb, Steve A. Trewick. 2014. Eocene diversification of crown group rails (Aves: Gruiformes: Rallidae). PLoS ONE 9 (10): e109635\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{3/20}\\
\multicolumn{1}{r}{\em{\textbf{3.}}} & \bgroup\fontsize{8}{10}\selectfont Gavryushkina, Alexandra, Tracy A. Heath, Daniel T. Ksepka, Tanja Stadler, David Welch, Alexei J. Drummond. 2016. Bayesian Total-Evidence Dating Reveals the Recent Crown Radiation of Penguins. Systematic Biology, p. syw060\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{18/20}\\
\multicolumn{1}{r}{\em{\textbf{4.}}} & \bgroup\fontsize{8}{10}\selectfont Gibb, Gillian C., Martyn Kennedy, David Penny. 2013. Beyond phylogeny: pelecaniform and ciconiiform birds, and long-term niche stability. Molecular Phylogentics and Evolution 68 (2): 229-238.\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{3/20}\\
\multicolumn{1}{r}{\em{\textbf{5.}}} & \bgroup\fontsize{8}{10}\selectfont Hedges, S. Blair, Julie Marin, Michael Suleski, Madeline Paymer, Sudhir Kumar. 2015. Tree of life reveals clock-like speciation and diversification. Molecular Biology and Evolution 32 (4): 835-845\egroup{} & \multicolumn{1}{c}{2} & \multicolumn{1}{c}{18/20}\\
\multicolumn{1}{r}{\em{\textbf{6.}}} & \bgroup\fontsize{8}{10}\selectfont Jarvis, E. D., S. Mirarab, A. J. Aberer, B. Li, P. Houde, C. Li, S. Y. W. Ho, B. C. Faircloth, B. Nabholz, J. T. Howard, A. Suh, C. C. Weber, R. R. da Fonseca, J. Li, F. Zhang, H. Li, L. Zhou, N. Narula, L. Liu, G. Ganapathy, B. Boussau, M. S. Bayzid, V. Zavidovych, S. Subramanian, T. Gabaldon, S. Capella-Gutierrez, J. Huerta-Cepas, B. Rekepalli, K. Munch, M. Schierup, B. Lindow, W. C. Warren, D. Ray, R. E. Green, M. W. Bruford, X. Zhan, A. Dixon, S. Li, N. Li, Y. Huang, E. P. Derryberry, M. F. Bertelsen, F. H. Sheldon, R. T. Brumfield, C. V. Mello, P. V. Lovell, M. Wirthlin, M. P. C. Schneider, F. Prosdocimi, J. A. Samaniego, A. M. V. Velazquez, A. Alfaro-Nunez, P. F. Campos, B. Petersen, T. Sicheritz-Ponten, A. Pas, T. Bailey, P. Scofield, M. Bunce, D. M. Lambert, Q. Zhou, P. Perelman, A. C. Driskell, B. Shapiro, Z. Xiong, Y. Zeng, S. Liu, Z. Li, B. Liu, K. Wu, J. Xiao, X. Yinqi, Q. Zheng, Y. Zhang, H. Yang, J. Wang, L. Smeds, F. E. Rheindt, M. Braun, J. Fjeldsa, L. Orlando, F. K. Barker, K. A. Jonsson, W. Johnson, K.-P. Koepfli, S. O'Brien, D. Haussler, O. A. Ryder, C. Rahbek, E. Willerslev, G. R. Graves, T. C. Glenn, J. McCormack, D. Burt, H. Ellegren, P. Alstrom, S. V. Edwards, A. Stamatakis, D. P. Mindell, J. Cracraft, E. L. Braun, T. Warnow, W. Jun, M. T. P. Gilbert, G. Zhang. 2014. Whole-genome analyses resolve early branches in the tree of life of modern birds. Science 346 (6215): 1320-1331.\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{2/20}\\
\multicolumn{1}{r}{\em{\textbf{7.}}} & \bgroup\fontsize{8}{10}\selectfont Jetz, W., G. H. Thomas, J. B. Joy, K. Hartmann, A. O. Mooers. 2012. The global diversity of birds in space and time. Nature 491 (7424): 444-448\egroup{} & \multicolumn{1}{c}{2} & \multicolumn{1}{c}{17/20}\\
\multicolumn{1}{r}{\em{\textbf{8.}}} & \bgroup\fontsize{8}{10}\selectfont Johnson, Jeff A., Joseph W. Brown, Jérôme Fuchs, David P. Mindell, 2016, 'Multi-locus phylogenetic inference among New World Vultures (Aves: Cathartidae)', Molecular Phylogenetics and Evolution, vol. 105, pp. 193-199\egroup{} & \multicolumn{1}{c}{2} & \multicolumn{1}{c}{2/20}\\
\multicolumn{1}{r}{\em{\textbf{9.}}} & \bgroup\fontsize{8}{10}\selectfont Subramanian, S., G. Beans-Picon, S. K. Swaminathan, C. D. Millar, D. M. Lambert. 2013. Evidence for a recent origin of penguins. Biology Letters 9 (6): 20130748-20130748.\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{11/20}\\
\bottomrule
\multicolumn{4}{l}{{\textbf{\textit{Source N}}}: Number of source chronograms reported in study.}\\
\multicolumn{4}{l}{{\textbf{\textit{Taxon N}}}: Number of queried taxa found in source chronograms.}\\
\end{longtable}
\newpage


\begin{figure}[!h]
\includegraphics{plots/Spheniscidae_LTTplot_phyloall.pdf}
\caption{Lineage through time (LTT) plots of source chronograms
  available in database for species in the Spheniscidae. Numbers correspond to original
  studies in Table \ref{tab:source_chr}. Arrows indicate maximum age of each chronogram.}
\label{fig:lttplot_phyloall}
\end{figure}

\newpage


\begin{figure}[!h]
\includegraphics{plots/Spheniscidae_lttplot_cluster_median.pdf}
\caption{Lineage Through Time plots of Spheniscidae median summary
chronograms obtained with different clustering algorithms. Not all algorithms worked
with this summary matrix and we are only showing here the ones that worked.
Chronograms obtained from the SDM summary matrix are very similar to the ones from
the median summary matrix with all clustering algorithms (Appendix Fig. \ref{fig:lttplot_cluster_sdm}).}
\label{fig:lttplot_cluster_median}
\end{figure}

\newpage


\begin{figure}[!h]
\includegraphics{plots/Spheniscidae_LTTplot_summary_chronograms2.pdf}
\caption{Spheniscidae lineage through time (LTT) plots of summary chronograms
    obtained by calibrating a consensus tree tropology with distance data
    from median (upper) and SDM (lower) summary matrices and then adjusting branch
    lengths with BLADJ. Source chronograms are shown in gray for comparison.}
\label{fig:lttplot_summchrono}
\end{figure}

\newpage


\begin{figure}[!h]
\includegraphics{plots/Spheniscidae_LTTplot_crossval_bladj.pdf}
\caption{Spheniscidae lineage through time (LTT) plots from
    source chronograms used as secondary calibrations (gray), source chronograms
    used as topology (purple) and chronograms resulting from calibrating the latter
    with the former, using BLADJ (green).}
\label{fig:lttplot_crossval_bladj}
\end{figure}


\newpage


\begin{figure}[h!]
	\includegraphics{plots/Spheniscidae_LTTplot_crossval_pathd8_exp1.pdf}
	\caption{Spheniscidae lineage through time (LTT) plots from
      source chronograms used as secondary calibrations (gray), source chronograms
      used as topology (purple) and chronograms resulting from calibrating the latter
      with the former, using PATHd8 (green). Calibrations were expanded to make them agree}
	\label{fig:lttplot_crossval_pathd8_exp1}
\end{figure}
\begin{figure}[h!]
	\includegraphics{plots/Spheniscidae_LTTplot_crossval_pathd8_summ1.pdf}
	\caption{Spheniscidae lineage through time (LTT) plots from
      source chronograms used as secondary calibrations (gray), source chronograms
      used as topology (purple) and chronograms resulting from calibrating the latter
      with the former, using PATHd8 (green). Calibrations were summarized to make them agree}
	\label{fig:lttplot_crossval_pathd8_summ1}
\end{figure}

\newpage



# Appendix

The following species were not found in the chronogram database:  *Megadyptes waitaha*
\begin{figure}[!h]
\includegraphics{plots/Spheniscidae_lttplot_cluster_sdm.pdf}
\caption{Lineage Through Time plots of Spheniscidae SDM summary
chronograms obtained with different clustering algorithms. Not all algorithms worked
with the SDM summary matrix and we are only showing here the ones that worked.
Chronograms obtained from the median summary matrix are very similar to the ones shown
here with all algorithms (main figure \ref{fig:lttplot_cluster_median}).}
\label{fig:lttplot_cluster_sdm}
\end{figure}

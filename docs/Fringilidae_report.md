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

# Taxon Fringilidae

## I. Query source data
There are 475 species in the Open Tree of Life Taxonomy for the taxon Fringilidae.
Information on time of divergence is available for
286
of these species across 13 published and peer-reviewed chronograms.
Original study citations as well as proportion of Fringilidae species found across those source
chronograms is shown in Table 1.

All source chronograms are fully ultrametric.

\begin{longtable}{>{\raggedright\arraybackslash}p{0.4cm}>{\raggedright\arraybackslash}p{11cm}>{\raggedright\arraybackslash}p{1.5cm}>{\raggedright\arraybackslash}p{1.8cm}}
\caption{\label{tab:unnamed-chunk-2}Fringilidae source chronogram studies information.}\\
\toprule
\multicolumn{1}{>{\centering\arraybackslash}p{0.4cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{   }}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{11cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Citation}}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{1.5cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Source N}}\endgroup} & \multicolumn{1}{>{\centering\arraybackslash}p{1.8cm}}{\begingroup\fontsize{9}{11}\selectfont \em{\textbf{Taxon N}}\endgroup}\\
\midrule
\multicolumn{1}{r}{\em{\textbf{1.}}} & \bgroup\fontsize{8}{10}\selectfont Barker, F. K., K. J. Burns, J. Klicka, S. M. Lanyon, I. J. Lovette. 2013. Going to extremes: contrasting rates of diversification in a recent radiation of New World passerine birds. Systematic Biology 62 (2): 298-320.\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{29/475}\\
\multicolumn{1}{r}{\em{\textbf{2.}}} & \bgroup\fontsize{8}{10}\selectfont Barker, F. Keith, Kevin J. Burns, John Klicka, Scott M. Lanyon, Irby J. Lovette. 2015. New insights into New World biogeography: An integrated view from the phylogeny of blackbirds, cardinals, sparrows, tanagers, warblers, and allies. The Auk 132 (2): 333-348.\egroup{} & \multicolumn{1}{c}{2} & \multicolumn{1}{c}{102/475}\\
\multicolumn{1}{r}{\em{\textbf{3.}}} & \bgroup\fontsize{8}{10}\selectfont Burns, Kevin J., Allison J. Shultz, Pascal O. Title, Nicholas A. Mason, F. Keith Barker, John Klicka, Scott M. Lanyon, Irby J. Lovette. 2014. Phylogenetics and diversification of tanagers (Passeriformes: Thraupidae), the largest radiation of Neotropical songbirds. Molecular Phylogenetics and Evolution 75: 41-77.\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{27/475}\\
\multicolumn{1}{r}{\em{\textbf{4.}}} & \bgroup\fontsize{8}{10}\selectfont Claramunt, Santiago, Joel Cracraft. 2015. A new time tree reveals Earth historys imprint on the evolution of modern birds. Science Advances 1 (11): e1501005-e1501005\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{3/475}\\
\multicolumn{1}{r}{\em{\textbf{5.}}} & \bgroup\fontsize{8}{10}\selectfont Gibb, Gillian C., Ryan England, Gerrit Hartig, P.A. (Trish) McLenachan, Briar L. Taylor Smith, Bennet J. McComish, Alan Cooper, David Penny. 2015. New Zealand passerines help clarify the diversification of major songbird lineages during the Oligocene. Genome Biology and Evolution 7 (11): 2983-2995.\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{7/475}\\
\multicolumn{1}{r}{\em{\textbf{6.}}} & \bgroup\fontsize{8}{10}\selectfont Hedges, S. Blair, Julie Marin, Michael Suleski, Madeline Paymer, Sudhir Kumar. 2015. Tree of life reveals clock-like speciation and diversification. Molecular Biology and Evolution 32 (4): 835-845\egroup{} & \multicolumn{1}{c}{2} & \multicolumn{1}{c}{250/475}\\
\multicolumn{1}{r}{\em{\textbf{7.}}} & \bgroup\fontsize{8}{10}\selectfont Hooper, Daniel M., Trevor D. Price. 2017. Chromosomal inversion differences correlate with range overlap in passerine birds. Nature Ecology \& Evolution 1 (10): 1526-1534\egroup{} & \multicolumn{1}{c}{1} & \multicolumn{1}{c}{47/475}\\
\multicolumn{1}{r}{\em{\textbf{8.}}} & \bgroup\fontsize{8}{10}\selectfont Jetz, W., G. H. Thomas, J. B. Joy, K. Hartmann, A. O. Mooers. 2012. The global diversity of birds in space and time. Nature 491 (7424): 444-448\egroup{} & \multicolumn{1}{c}{2} & \multicolumn{1}{c}{215/475}\\
\multicolumn{1}{r}{\em{\textbf{9.}}} & \bgroup\fontsize{8}{10}\selectfont Price, Trevor D., Daniel M. Hooper, Caitlyn D. Buchanan, Ulf S. Johansson, D. Thomas Tietze, Per Alström, Urban Olsson, Mousumi Ghosh-Harihar, Farah Ishtiaq, Sandeep K. Gupta, Jochen Martens, Bettina Harr, Pratap Singh, Dhananjai Mohan. 2014. Niche filling slows the diversification of Himalayan songbirds. Nature 509: 222-225.\egroup{} & \multicolumn{1}{c}{2} & \multicolumn{1}{c}{2/475}\\
\bottomrule
\multicolumn{4}{l}{{\textbf{\textit{Source N}}}: Number of source chronograms reported in study.}\\
\multicolumn{4}{l}{{\textbf{\textit{Taxon N}}}: Number of queried taxa found in source chronograms.}\\
\end{longtable}

Source chronograms maximum age range from 16.057 to
44.296 million years ago (MYA).
As a means for comparison, lineage through time plots of all source chronograms
available in data base are shown in Fig. 1

## II. Summarize results.

LTT plots are a nice way to visually compare several trees. But what if you want
to summarize information from all source chronograms into a single summary chronogram?


![Lineage through time (LTT) plots of source chronograms available in data base
  for species in the Fringilidae. Numbers correspond to original studies in Table 1. Arrows indicate maximum age of each chronogram.](plots/Fringilidae_LTTplot_phyloall.pdf)

The first step is to identify the degree of species overlap among your source chornograms: if each
source chronogram has a unique sample of species, it will not be possible to combine
them into a single summary chronogram. To identify the set of trees or _grove_ with the most source
chronograms that have at least two overlapping taxa, we followed Ané et al. 2016.
In this case, not all source chronograms found for the  Fringilidae  have at least two overlapping species. The largest grove has  2  chronograms (out of  13  total source chronograms).
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


![Lineage Through Time plots of Fringilidae summary
chronograms from median (upper) and SDM (lower) summary matrices obtained with various clustering algorithms.](plots/Fringilidae_make_lttplot_summ3_test_median.pdf)

This taxon's SDM matrix has some negative values in the following taxa: *Carduelis uropygialis*, *Spinus crassirostris*. This taxon's Median matrix has NO negative values.


![Fringilidae lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or
  with maximum ages that are just off (too old or too young). So we developped an
  alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Fringilidae_LTTplot_Median.pdf)



###   II.B. Age distributions from Median and SDM summary trees.

Comparison of summary chronograms reconstructed with min and max ages.


![Fringilidae lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with `datelife` algorithm.](plots/Fringilidae_LTTplot_summtrees_Median.pdf)



![Fringilidae lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with `datelife` algorithm.](plots/Fringilidae_LTTplot_summtrees_SDM.pdf)


\newpage


## III. Create new data


As an example, we're gonna date the Open Tree Synthetic tree (mainly because the taxonomic tree is usually less well resolved.)


Now, let's say you like the Open Tree of Life Taxonomy and you want to stick to that tree. Dates from available studies were tested over the Open Tree of Life Synthetic tree of Fringilidae and a tree was constructed, but all branch lengths are NA.
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


\newpage

## Appendix
The following species were completely absent from the chronogram data base:  *Acanthis cabaret**, **Acanthis rostrata**, **Akialoa ellisiana**, **Akialoa lanaiensis**, **Akialoa obscura**, **Buarremon apertus**, **Bucanetes crassirostris**, **Calcarius coloratus**, **Cardinalis carneus**, **Cardinalis peninsulae**, **Carduelis ankoberensis**, **Carduelis elegans**, **Carduelis ultima**, **Carpodacus beicki**, **Carpodacus davidianus**, **Carpodacus deserticolor**, **Carpodacus dubius**, **Carpodacus formosanus**, **Carpodacus henrici**, **Carpodacus longirostris**, **Carpodacus lucifer**, **Carpodacus portenkoi**, **Carpodacus rhodopeplus**, **Carpodacus roseatus**, **Carpodacus rubicundus**, **Carpodacus stoliczkae**, **Carpodacus verreauxii**, **Carpodacus waltoni**, **Caryothraustes brasiliensis**, **Caryothraustes scapularis**, **Chaunoproctus ferreorostris**, **Chloridops kona**, **Chloris heinrichi**, **Chloris turkestanica**, **Chrysocorythus mindanensis**, **Ciridops anna**, **Coccothraustes japonicus**, **Coccothraustes migratorius**, **Corytus rhenana**, **Crithagra albifrons**, **Crithagra ankoberensis**, **Crithagra buchanani**, **Crithagra canicapilla**, **Crithagra capistrata**, **Crithagra concolor**, **Crithagra deserti**, **Crithagra donaldsoni**, **Crithagra flavigula**, **Crithagra frontalis**, **Crithagra granti**, **Crithagra hewitti**, **Crithagra hildegardae**, **Crithagra kikuyensis**, **Crithagra koliensis**, **Crithagra leucoptera**, **Crithagra marshalli**, **Crithagra menachensis**, **Crithagra montanorum**, **Crithagra mozambica**, **Crithagra reichenowi**, **Crithagra rothschildi**, **Crithagra rufobrunnea**, **Crithagra symonsi**, **Crithagra thomensis**, **Crithagra tristriata**, **Crithagra xantholaema**, **Crithagra xanthopygia**, **Cyanerpes holti**, **Cyanerpes isthmicus**, **Cyanerpes microrhynchus**, **Cyanocompsa argentina**, **Cyanocompsa rothschildii**, **Drepanis coccinea**, **Drepanis funerea**, **Drepanis pacifica**, **Dysmorodrepanis munroi**, **Emberiza buturlini**, **Emberiza ciodes**, **Emberiza ciopsis**, **Emberiza continentalis**, **Emberiza elegantula**, **Emberiza erythrogenys**, **Emberiza flemingorum**, **Emberiza fronto**, **Emberiza kuatunensis**, **Emberiza lydiae**, **Emberiza meridionalis**, **Emberiza militaris**, **Emberiza musica**, **Emberiza neobscura**, **Emberiza nivenorum**, **Emberiza omissa**, **Emberiza omoensis**, **Emberiza orientalis**, **Emberiza ornata**, **Emberiza pyrrhulinus**, **Emberiza rufibarba**, **Emberiza rufigularis**, **Emberiza sahari**, **Emberiza semenowi**, **Emberiza sloggetti**, **Emberiza sordida**, **Emberiza vincenti**, **Emberiza zaidamensis**, **Embernagra gossei**, **Eophona magnirostris**, **Eophona sowerbyi**, **Erythrospiza phaenicoptera**, **Euphonia aurantiicollis**, **Euphonia carnegiei**, **Euphonia flavifrons**, **Euphonia gnatho**, **Euphonia nitida**, **Euphonia olivacea**, **Euphonia praetermissa**, **Euphonia purpurascens**, **Euphonia rufivertex**, **Euphonia serrirostris**, **Euphonia tavarae**, **Fringilla albicollis**, **Fringilla bella**, **Fringilla brissonii**, **Fringilla nortoniensis**, **Fringilla palmae**, **Fringilla polatzeki**, **Fringilla syriaca**, **Fringillaria goslingi**, **Fringillaria poliopleura**, **Haemorhous californicus**, **Haemorhous griscomi**, **Hemignathus affinis**, **Hemignathus hanapepe**, **Hemispingus castaneicollis**, **Hemispingus macrophrys**, **Hemispingus ochraceus**, **Hemispingus urubambae**, **Hesperiphona abeillei**, **Hesperiphona cobanensis**, **Hesperiphona montana**, **Himatione fraithii**, **Leucosticte brunneonucha**, **Leucosticte wallowa**, **Leucosticte walteri**, **Linaria harterti**, **Linaria johannis**, **Linaria rufostrigata**, **Linaria yemenensis**, **Linurgus kilimensis**, **Loxia cardinalis**, **Loxia cyanea**, **Loxia dominica**, **Loxia mesamericana**, **Loxops ochraceus**, **Loxops wolstenholmei**, **Melopyrrha taylori**, **Mycerobas melanoxanthos**, **Passerina lazula**, **Passerina pallidior**, **Passerina purpurascens**, **Peucaea cohaerens**, **Peucaea ibarrorum**, **Peucaea vulcanica**, **Peucedramus micrus**, **Pheucticus aurantiacus**, **Pinicola eschatosa**, **Plectrophenax townsendi**, **Psittirostra psittacea**, **Pyrrhula cineracea**, **Pyrrhula owstoni**, **Pyrrhula rosacea**, **Pyrrhula steerei**, **Pyrrhula uchidai**, **Rhodacanthis flaviceps**, **Rhodacanthis palmeri**, **Rhodopechys alienus**, **Rhodopechys sanguineus**, **Rhynchostruthus louisae**, **Rhynchostruthus percivali**, **Rhynchostruthus socotranus**, **Serinus huillensis**, **Spinus atriceps**, **Spinus colombiana**, **Spinus dominicensis**, **Spinus longirostris**, **Spinus nigricauda**, **Spinus oleacea**, **Spinus perplexa**, **Spinus stejnegeri**, **Viridonia sagittirostris*

![Fringilidae Species Dated Open Tree of Life Induced Subtree. This chronogram was obtained with `get_dated_otol_induced_subtree()` function.](plots/Fringilidae_datedotol.pdf)



![Fringilidae lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with `datelife` algorithm.](plots/Fringilidae_LTTplot_sdm.pdf)

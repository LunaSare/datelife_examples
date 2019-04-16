---
title: "DateLife Workflows"
author: "Luna L. Sanchez Reyes"
date: "2019-04-15"
output: rmarkdown::html_vignette
geometry: "left=3cm,right=3cm,top=2.5cm,bottom=4cm"
vignette: >
  %\VignetteIndexEntry{DateLife Example}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---


\raggedright

# Taxon Fringilidae

## I. Query data
There are 475 species in the Open Tree of Life Taxonomy for the taxon Fringilidae.
Information on time of divergence is available for
286
of these species across 13 published and peer-reviewed chronograms.
Original study citations as well as proportion of Fringilidae species found across those source
chronograms is shown in Table 1.

All source chronograms are fully ultrametric.


![Fringilidae Species Dated Open Tree of Life Induced Subtree. This chronogram was obtained with `get_dated_otol_induced_subtree()` function.](plots/Fringilidae_datedotol.pdf)


![Fringilidae lineage through time (LTT) plots from source chronograms, summary median chronogram and dated Open Tree of Life chronogram.](plots/Fringilidae_LTTplot_phyloall.pdf)


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

This taxon's SDM matrix has some negative values in the following taxa: *Carduelis uropygialis*, *Spinus crassirostris*. This taxon's Median matrix has NO negative values.


![Fringilidae lineage through time (LTT) plots from source chronograms and Median summary matrix converted to phylo with different methods (NJ and UPGMA).  Clustering algorithms used often are returning non-ultrametric trees or with maximum ages that are just off (too old or too young). So we developped an alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Fringilidae_LTTplot_Median.pdf)



![Fringilidae lineage through time (LTT) plots from source chronograms and SDM summary matrix converted to phylo with different methods (NJ and UPGMA). As you can note, dashed lines and solid lines from trees coming out from both types of clustering algorithms implemented are mostly overlapping. This means that removing negative values does not change results from clustering algorithms much. Clustering algorithms used often are returning non-ultrametric trees or with maximum ages that are just off (too old or too young). So we developped an alternative algorithm in `datelife` to go from a summary matrix to a fully ultrametric tree.](plots/Fringilidae_LTTplot_SDM.pdf)

### II.B. Age distributions form Median and SDM summary trees.

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

\caption{\label{tab:unnamed-chunk-5}Was it successful to use each source chronogram independently as calibration (CalibN) against the Dated Open Tree of Life (dOToL) and each other (ChronoN)?}
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

```
#> Error in paste0("\n![", figcap_lttplot_sdm, "](plots/", taxon, "_LTTplot_sdm.pdf)\n"): object 'figcap_lttplot_sdm' not found
#> Error in cat(lttplot): object 'lttplot' not found
```

\newpage

## Appendix
The following species were completely absent from the chronogram data base:  *Acanthis cabaret**, **Acanthis rostrata**, **Akialoa ellisiana**, **Akialoa lanaiensis**, **Akialoa obscura**, **Buarremon apertus**, **Bucanetes crassirostris**, **Calcarius coloratus**, **Cardinalis carneus**, **Cardinalis peninsulae**, **Carduelis ankoberensis**, **Carduelis elegans**, **Carduelis ultima**, **Carpodacus beicki**, **Carpodacus davidianus**, **Carpodacus deserticolor**, **Carpodacus dubius**, **Carpodacus formosanus**, **Carpodacus henrici**, **Carpodacus longirostris**, **Carpodacus lucifer**, **Carpodacus portenkoi**, **Carpodacus rhodopeplus**, **Carpodacus roseatus**, **Carpodacus rubicundus**, **Carpodacus stoliczkae**, **Carpodacus verreauxii**, **Carpodacus waltoni**, **Caryothraustes brasiliensis**, **Caryothraustes scapularis**, **Chaunoproctus ferreorostris**, **Chloridops kona**, **Chloris heinrichi**, **Chloris turkestanica**, **Chrysocorythus mindanensis**, **Ciridops anna**, **Coccothraustes japonicus**, **Coccothraustes migratorius**, **Corytus rhenana**, **Crithagra albifrons**, **Crithagra ankoberensis**, **Crithagra buchanani**, **Crithagra canicapilla**, **Crithagra capistrata**, **Crithagra concolor**, **Crithagra deserti**, **Crithagra donaldsoni**, **Crithagra flavigula**, **Crithagra frontalis**, **Crithagra granti**, **Crithagra hewitti**, **Crithagra hildegardae**, **Crithagra kikuyensis**, **Crithagra koliensis**, **Crithagra leucoptera**, **Crithagra marshalli**, **Crithagra menachensis**, **Crithagra montanorum**, **Crithagra mozambica**, **Crithagra reichenowi**, **Crithagra rothschildi**, **Crithagra rufobrunnea**, **Crithagra symonsi**, **Crithagra thomensis**, **Crithagra tristriata**, **Crithagra xantholaema**, **Crithagra xanthopygia**, **Cyanerpes holti**, **Cyanerpes isthmicus**, **Cyanerpes microrhynchus**, **Cyanocompsa argentina**, **Cyanocompsa rothschildii**, **Drepanis coccinea**, **Drepanis funerea**, **Drepanis pacifica**, **Dysmorodrepanis munroi**, **Emberiza buturlini**, **Emberiza ciodes**, **Emberiza ciopsis**, **Emberiza continentalis**, **Emberiza elegantula**, **Emberiza erythrogenys**, **Emberiza flemingorum**, **Emberiza fronto**, **Emberiza kuatunensis**, **Emberiza lydiae**, **Emberiza meridionalis**, **Emberiza militaris**, **Emberiza musica**, **Emberiza neobscura**, **Emberiza nivenorum**, **Emberiza omissa**, **Emberiza omoensis**, **Emberiza orientalis**, **Emberiza ornata**, **Emberiza pyrrhulinus**, **Emberiza rufibarba**, **Emberiza rufigularis**, **Emberiza sahari**, **Emberiza semenowi**, **Emberiza sloggetti**, **Emberiza sordida**, **Emberiza vincenti**, **Emberiza zaidamensis**, **Embernagra gossei**, **Eophona magnirostris**, **Eophona sowerbyi**, **Erythrospiza phaenicoptera**, **Euphonia aurantiicollis**, **Euphonia carnegiei**, **Euphonia flavifrons**, **Euphonia gnatho**, **Euphonia nitida**, **Euphonia olivacea**, **Euphonia praetermissa**, **Euphonia purpurascens**, **Euphonia rufivertex**, **Euphonia serrirostris**, **Euphonia tavarae**, **Fringilla albicollis**, **Fringilla bella**, **Fringilla brissonii**, **Fringilla nortoniensis**, **Fringilla palmae**, **Fringilla polatzeki**, **Fringilla syriaca**, **Fringillaria goslingi**, **Fringillaria poliopleura**, **Haemorhous californicus**, **Haemorhous griscomi**, **Hemignathus affinis**, **Hemignathus hanapepe**, **Hemispingus castaneicollis**, **Hemispingus macrophrys**, **Hemispingus ochraceus**, **Hemispingus urubambae**, **Hesperiphona abeillei**, **Hesperiphona cobanensis**, **Hesperiphona montana**, **Himatione fraithii**, **Leucosticte brunneonucha**, **Leucosticte wallowa**, **Leucosticte walteri**, **Linaria harterti**, **Linaria johannis**, **Linaria rufostrigata**, **Linaria yemenensis**, **Linurgus kilimensis**, **Loxia cardinalis**, **Loxia cyanea**, **Loxia dominica**, **Loxia mesamericana**, **Loxops ochraceus**, **Loxops wolstenholmei**, **Melopyrrha taylori**, **Mycerobas melanoxanthos**, **Passerina lazula**, **Passerina pallidior**, **Passerina purpurascens**, **Peucaea cohaerens**, **Peucaea ibarrorum**, **Peucaea vulcanica**, **Peucedramus micrus**, **Pheucticus aurantiacus**, **Pinicola eschatosa**, **Plectrophenax townsendi**, **Psittirostra psittacea**, **Pyrrhula cineracea**, **Pyrrhula owstoni**, **Pyrrhula rosacea**, **Pyrrhula steerei**, **Pyrrhula uchidai**, **Rhodacanthis flaviceps**, **Rhodacanthis palmeri**, **Rhodopechys alienus**, **Rhodopechys sanguineus**, **Rhynchostruthus louisae**, **Rhynchostruthus percivali**, **Rhynchostruthus socotranus**, **Serinus huillensis**, **Spinus atriceps**, **Spinus colombiana**, **Spinus dominicensis**, **Spinus longirostris**, **Spinus nigricauda**, **Spinus oleacea**, **Spinus perplexa**, **Spinus stejnegeri**, **Viridonia sagittirostris*

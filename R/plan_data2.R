loadd(tax_phyloallall)
plan_data2 <- drake_plan(
  tax_allcalall = lapply(tax_phyloallall, get_all_calibrations),
  tax_othercalall = lapply(tax_phyloallall, get_othercals),
  # length(tax_othercalall)
  # sapply(tax_othercalall, length)
  crossval1 = mapply(use_othercals1, tax_phyloallall, tax_othercalall),
  crossval2 = mapply(use_othercals2, tax_phyloallall, tax_othercalall),
  crossval_bladjall = mapply(use_othercals3, tax_phyloallall, tax_othercalall),
  tax_phyloall_bold = mapply(get_bold_trees, taxa, tax_phyloallall),
  crossval_pathd8_exp = mapply(use_othercals4, taxa, tax_phyloall_bold, tax_othercalall),
  crossval_pathd8_summ = mapply(use_othercals4, taxa, tax_phyloall_bold, tax_othercalall,
    moreArgs = list(expand = 0))
  tax_phyloall_bold_notc = mapply(get_bold_trees, taxa, tax_phyloallall,
    rep(FALSE, length(tax_phyloallall))),
  crossval_pathd8_exp_notc = mapply(use_othercals4, taxa, tax_phyloall_bold_notc,
    tax_othercalall)
  crossval_pathd8_summ_notc = mapply(use_othercals4, taxa, tax_phyloall_bold_notc,
    tax_othercalall, moreArgs = list(expand = 0))
})

loadd(tax_drall)

plan_summ2 <- drake_plan(
    tax_summaryall = lapply(tax_drall, function(x) datelife:::summary.datelifeResult(x))
)
make(plan_summ2)

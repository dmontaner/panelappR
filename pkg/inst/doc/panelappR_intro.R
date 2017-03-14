## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()
options (width = 80)

## -----------------------------------------------------------------------------
library(panelappR)

## ---- results = 'hide'--------------------------------------------------------
pad <- paDownload()

## -----------------------------------------------------------------------------
names(pad)
head(pad$genes)

## ---- results = 'hide', warning = FALSE---------------------------------------
pad <- paAnnotate(pad)

## -----------------------------------------------------------------------------
head(pad$ensembl)

## -----------------------------------------------------------------------------
paExport.xlsx(pad, file = "panelap_data.xlsx")

## ---- results = 'hide'--------------------------------------------------------
paExport.sqlite(pad, file = "panelap_data.sqlite")

## ---- echo = FALSE, results = 'hide'------------------------------------------
unlink("panelap_data.xlsx")
unlink("panelap_data.sqlite")


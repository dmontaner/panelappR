##paExport.r
##2016-12-03 david.montaner@genomicsengland.co.uk
##Export PanelApp in several formats

##' Export PanelApp information as xlsx file
##'
##' The function saves PanelApp data into an xlsx file using the "openxlsx" library.
##'
##' @param pad PanelApp data exported using funciton paDownload.
##' @param file xls or xlsx file name (the extension has to be included).
##'
##' @return an xmlx file.
##'
##' @import openxlsx
##' @export

paExport.xlsx <- function (pad, file) {
    pad <- pad[!names (pad) %in% c ("publications", "phenotypes")]
    write.xlsx (pad, file = file, colWidths = "auto")
}

## source ("paDownload.r")
## library (jsonlite)
## library (openxlsx)
## system.time (datos <- paDownload ())
## system.time (paExport.xlsx (datos, file = "datos.xlsx"))

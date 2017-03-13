##paExport.r
##2016-12-03 david.montaner@genomicsengland.co.uk
##Export PanelApp in several formats

##' Export PanelApp information as xlsx file
##'
##' The function saves PanelApp data into an xlsx file using the "openxlsx" library.
##'
##' Tables "publications" and "phenotypes" are NOT into the xlsx format
##' because they contain end of lines and tabs which break the xlsx file.
##'
##' @param pad PanelApp data exported using function paDownload.
##' @param file xls or xlsx file name (the file extension has to be included).
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


################################################################################


##' Export PanelApp information to SQLite
##'
##' The function saves PanelApp data into a SQLite database file.
##'
##' @param pad PanelApp data exported using function paDownload.
##' @param file SQLite file (the file extension has to be included).
##' @param protect when FALSE the file is overwritten if it exists.
##' @param verbose verbose.
##'
##' @return an SQLite file.
##'
##' @import RSQLite
##' @export

paExport.sqlite <- function (pad, file, verbose = TRUE, protect = TRUE) {
    
    if (protect & file.exists (file)) {
        stop ("File ", file, " already exists.")
    } else {
        unlink (file)
    }
    
    driver.name <- dbDriver (drvName = "SQLite") #driver
    conection.object <- dbConnect (drv = driver.name, dbname = file) #connection
    
    for (ta in names (pad)) {
        if (verbose) {
            cat ("Writing table:", ta, fill = TRUE)
        }
        dbWriteTable (conection.object, name = ta, value = pad[[ta]])
    }
}

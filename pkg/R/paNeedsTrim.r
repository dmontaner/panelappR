##paNeedsTrim.r
##2016-12-05 david.montaner@genomicsengland.co.uk
##Convert text columns into a quoted ones

##' Find rows which need trimming
##'
##' The function filters the rows in the data frames downloaded from Panelapp.
##' For each data frame, it keeps just those rows which need white trimming
##' in any of their columns.
##'
##' The columns in the data frames in the out put list are all converted to text.
##' Moreover, all values in the output are wrapped withing double quotes
##' so that the white spaces are easy to spot.
##'
##' By default "needs trimming" means that whites apear at the beggining
##' and at the end of the character values. 
##' 
##' @param pad PanelApp data exported using funciton paDownload.
##'
##' @return A list of data frames with the same items as in the `pad` and filtered rows.
##' @export


## ToDo:
## internal Whites : use gsub (" +", " ", "uno    dos")

paNeedsTrim <- function (pad) {
    
    for (ta in names (pad)) {
        dat <- pad[[ta]]
        
        tabla <- sapply (dat, as.character)
        wabla <- sapply (dat, trimws)
        
        nt <- apply (tabla != wabla, 1, any, na.rm = TRUE)
        
        dat <- dat[nt, , drop = FALSE]
        
        if (nrow (dat) > 0) {
            dat <- lapply (dat, function (x) paste0 ('"', x, '"'))
            dat <- as.data.frame (dat, stringsAsFactors = FALSE)
        }
        pad[[ta]] <- dat
    }
    return (pad)
}

## source ("paDownload.r")
## library (jsonlite)
## system.time (datos <- paDownload ())
## system.time (datos2 <- paNeedsTrim (datos))
## datos2

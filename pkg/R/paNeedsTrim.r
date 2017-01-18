##paNeedsTrim.r
##2016-12-05 david.montaner@genomicsengland.co.uk
##Convert text columns into a quoted ones

##' Find data which need trimming
##'
##' The function creates a list of data frames keeping the rows which need some trimming.
##'
##' @param pad PanelApp data exported using funciton paDownload.
##'
##' @return a list of data frames
##' @export

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

##paGenPanMat.r
##2017-01-27 david.montaner@genomicsengland.co.uk
##create a gene to panel matrix

##' Gene to Panel indicator matrix
##'
##' The function creates a gene to panel indicator matrix from PanelApp
##' information downloaded using paDownload.
##'
##' @param pad PanelApp data exported using function paDownload.
##' @param logical if TRUE a logical matrix is returned.
##' If FALSE a binary matrix (0, 1) is created.
##'
##' @return A matrix. Genes arranged in rows and panels in columns.
##'
##' @import reshape
##' @export

paGenPanMat <- function (pad, logical = TRUE) {
    datos <- pad$genes[,c ("Panel_Name", "GeneSymbol")]
    datos[,"value"] <- 1L
    res <- cast (datos, GeneSymbol ~ Panel_Name, value = "value")
    res <- as.data.frame (res)    
    rownames (res) <- res[,"GeneSymbol"]
    res <- res[,-1]
    res <- as.matrix (res)    
    res[is.na (res)] <- 0
    if (logical) {
        res <- res == 1
    }
    return (res)
}

##conversions.r
##2017-04-18 david.montaner@genomicsengland.co.uk
##Some id and variable conversion

##' Convert to current panel name
##'
##' The function takes a character vector with panels or "aliases" names,
##' and returns the current name of the panel.
##'
##' Information about the conversion is stored in pad$disorders
##' 
##' @param pad PanelApp data exported using function paDownload.
##' @param ids character vector of panel names or aliases.
##'
##' @return vector with the current version of the panel name.
##' @export

paAlias2Name <- function (ids, pad) {
    conv         <- pad$disorders$Panel_Name
    names (conv) <- pad$disorders$Relevant_disorders
    res <- conv[ids]
    return (res)
}


##' Find current panel version
##'
##' The function takes a character vector with panel names
##' and returns the current (latest) version of the panel.
##'
##' Information about the conversion is stored in pad$panels$CurrentVersion.
##' The function just works with latest panel names.
##' Use `paAlias2Name` if you need to convert aliases.
##' 
##' @param pad PanelApp data exported using function paDownload.
##' @param ids character vector of panel names.
##'
##' @return vector with the current version number of the panel.
##' @export

paName2CurrentVersion <- function (ids, pad) {
    conv         <- pad$panels$CurrentVersion
    names (conv) <- pad$panels$Panel_Name
    res <- conv[ids]
    return (res)
}

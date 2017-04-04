##paAnnotate.r
##2016-12-03 david.montaner@genomicsengland.co.uk
##Export PanelApp in several formats

##' Annotate PanelApp information
##'
##' The function annotates the "ensembl" data.frame in panelapp list created using paDownload.
##'
##' Data are retrieved from Ensembl Biomart using the `biomaRt` library in Bioconductor.
##'
##' Original gene ids in PanelApp defined using Ensembl 80 version.
##' Use latestVersion = FALSE if you want to retrieve the information from Ensembl 80.
##' Otherwise current ensembl version will be used.
##'
##' @param pad PanelApp data exported using function paDownload.
##' @param append if TRUE annotation information is included in new columns of pad$ensembl.
##' If FALSE a data frame with the collected information is returned.
##' @param latestVersion if TRUE current ensembl version is used.
##' If FALSE, ensembl version 80 is used.
##' @param verbose verbose.
##'
##' @return a pad element or a data.frame
##'
##' @seealso paDownload
##' 
##' @import biomaRt
##' @export

paAnnotate <- function (pad, append = TRUE, latestVersion = TRUE, verbose = TRUE) {
    
    if (latestVersion) {
        host <- "www.ensembl.org"
    } else {
        host <- "may2015.archive.ensembl.org"
    }
    
    ## fields to retrieve from biomart
    attributes = c ("ensembl_gene_id", "hgnc_symbol", "hgnc_id", 
                    "chromosome_name", "start_position", "end_position",
                    "strand",
                    "gene_biotype")
    
    ## query ids
    ids <- unique (pad[["ensembl"]][,"EnsembleGeneIds"])
    
    ## query
    mart <- useMart ("ENSEMBL_MART_ENSEMBL", dataset="hsapiens_gene_ensembl", host = host, verbose = verbose)
    annot <- getBM (attributes = attributes, filters = "ensembl_gene_id", values = ids, mart = mart)
    
    ## rename columns
    names (annot)[names (annot) == "ensembl_gene_id"] <- "EnsembleGeneIds"
    ##names (annot)[names (annot) == "hgnc_symbol"] <- "GeneSymbol"

    
    ## checks
    if (any (duplicated (annot[,"EnsembleGeneIds"]))) {
        warning ("Duplicated Ensembl IDs")
    }
    
    if (any (is.na (annot[,"EnsembleGeneIds"]) | annot[,"EnsembleGeneIds"] == "")) {
        warning ("Missing Ensembl IDs")
    }

    nf <- setdiff (ids, annot[,"EnsembleGeneIds"])
    if (length (nf) > 0) {
        warning (paste ("Ensembl ID not found in Ensemb Biomart:", nf, "\n"))
    }
    
    ## format results
    if (append) {
        ## clean annotation columns if they are there
        to.wipe <- setdiff (colnames (annot), "EnsembleGeneIds")
        pad$ensembl <- pad$ensembl[,!colnames (pad$ensembl) %in% to.wipe]
        ##
        mer <- merge (pad$ensembl, annot, all = TRUE)
        orden <- order (mer[,"GeneSymbol"], mer[,"EnsembleGeneIds"])
        mer <- mer[orden,]
        mer <- mer[,unique (c ("GeneSymbol", "EnsembleGeneIds", colnames (mer)))]
        ## table (mer[1:2] == pad$ensembl)
        pad$ensembl <- mer
        rownames (pad$ensembl) <- NULL
        res <- pad
    } else {
        res <- annot
    }

    return (res)
}

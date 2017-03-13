##paDownload.r
##2016-12-01 david.montaner@genomicsengland.co.uk
##Download panels from PanelApp

##' Download PanelApp information
##'
##' The function downloads PanelApp latest version  information
##'
##' @param URL Catalog web services base url.
##' @param verbose verbose.
##'
##' @return a list of data.frames with the following information
##' 
##' - panels
##' - disorders
##' - genes
##' - evidences
##' - publications
##' - phenotypes
##' - ensembl
##'
##' @import utils jsonlite
##' @export

paDownload <- function (verbose = TRUE, URL = "https://panelapp.extge.co.uk/crowdsourcing/WebServices") {
    
    ## ### PANELS
    pa.url <- paste0 (URL, "/list_panels?format=json")
    panels <- fromJSON (txt = pa.url)
    panels <- panels[["result"]]
    names (panels)[names (panels) == "Name"] <- "Panel_Name"
    
    ## disorders table
    disorders <- NULL
    for (i in 1:nrow (panels)) {
        disorders <- rbind (disorders, 
                            cbind (Panel_Name = panels[i, "Panel_Name"], Relevant_disorders = c (panels[i, "Panel_Name"], unlist (panels[i, "Relevant_disorders"]))))
    }
    disorders <- as.data.frame (disorders, stringsAsFactors = FALSE)
    disorders <- disorders[!is.na (disorders$Relevant_disorders),]
    disorders <- disorders[disorders$Relevant_disorders != "",]
    disorders <- unique (disorders)
    
    ## drop Relevant_disorders
    panels <- panels[,names (panels) != "Relevant_disorders"]
    
    ## order
    orden <- order (panels[,"Panel_Name"])
    panels <- panels[orden,]
    ##
    orden <- order (disorders[,"Panel_Name"], disorders[,"Relevant_disorders"]) 
    disorders <- disorders[orden,]
    
    ## #########################################################################
    
    ## ### GENES
    base <- paste0 (URL, "/get_panel/")
    formato <- "/?format=json"
    
    genes <- NULL
    for (pa in panels[,"Panel_Name"]) {
        ##cat ("\n=====================", pa, "===================\n")
        if (verbose) print (pa)
        pa.url <- paste0 (base, pa, formato)
        pa.url <- URLencode (pa.url)
        panel <- fromJSON (txt = pa.url)
        panel <- panel[["result"]][["Genes"]]
        if (class (panel) == "data.frame") {
            panel[,"Panel_Name"] <- pa
        }
        ##print (dim (panel))
        genes <- rbind (genes, panel)
    }
    
    ## #################################
    
    ## evidences
    evidences <- NULL
    for (i in 1:nrow (genes)) {
        evi <- unlist (genes[i, "Evidences"])
        if (length (evi) > 0) {
            evidences <- rbind (evidences, 
                                cbind (Panel_Name = genes[i, "Panel_Name"],
                                       GeneSymbol = genes[i, "GeneSymbol"],
                                       Evidences = evi))
        }
    }
    evidences <- as.data.frame (evidences, stringsAsFactors = FALSE)
    evidences <- evidences[!is.na (evidences$Evidences),]
    evidences <- evidences[evidences$Evidences != "",]
    evidences <- unique (evidences)
    ## order
    orden <- order (evidences[,"Panel_Name"], evidences[,"GeneSymbol"], evidences[,"Evidences"])
    evidences <- evidences[orden,]

    ## #################################
    
    ## publications
    publications <- NULL
    for (i in 1:nrow (genes)) {
        pub <- unlist (genes[i, "Publications"])
        if (length (pub) > 0) {
            publications <- rbind (publications, 
                                   cbind (Panel_Name = genes[i, "Panel_Name"],
                                          GeneSymbol = genes[i, "GeneSymbol"],
                                          Publications = pub))
        }
    }
    publications <- as.data.frame (publications, stringsAsFactors = FALSE)
    publications <- publications[!is.na (publications$Publications),]
    publications <- publications[publications$Publications != "",]
    publications <- unique (publications)
    ## order
    orden <- order (publications[,"Panel_Name"], publications[,"GeneSymbol"], publications[,"Publications"])
    publications <- publications[orden,]
    
    ## #################################
    
    ## phenotypes
    phenotypes <- NULL
    for (i in 1:nrow (genes)) {
        phe <- unlist (genes[i, "Phenotypes"])
        if (length (phe) > 0) {
            phenotypes <- rbind (phenotypes, 
                                 cbind (Panel_Name = genes[i, "Panel_Name"],
                                        GeneSymbol = genes[i, "GeneSymbol"],
                                        Phenotypes = phe))
        }
    }
    phenotypes <- as.data.frame (phenotypes, stringsAsFactors = FALSE)
    phenotypes <- phenotypes[!is.na (phenotypes$Phenotypes),]
    phenotypes <- phenotypes[phenotypes$Phenotypes != "",]
    phenotypes <- unique (phenotypes)
    ## order
    orden <- order (phenotypes[,"Panel_Name"], phenotypes[,"GeneSymbol"], phenotypes[,"Phenotypes"])
    phenotypes <- phenotypes[orden,]
    
    ## #################################
    
    ## ensembl
    ensembl <- NULL
    for (i in 1:nrow (genes)) {
        ens <- unlist (genes[i, "EnsembleGeneIds"])
        if (length (ens) > 0) {
            ensembl <- rbind (ensembl, 
                              cbind (GeneSymbol = genes[i, "GeneSymbol"],
                                     EnsembleGeneIds = ens)
                              )
        }
    }
    ensembl <- as.data.frame (ensembl, stringsAsFactors = FALSE)
    ensembl <- ensembl[!is.na (ensembl$EnsembleGeneIds),]
    ensembl <- ensembl[ensembl$EnsembleGeneIds != "",]
    ensembl <- unique (ensembl)
    ## order
    orden <- order (ensembl[,"GeneSymbol"], ensembl[,"EnsembleGeneIds"])
    ensembl <- ensembl[orden,]
    
    ## #################################
    
    genes <- genes[, ! colnames (genes) %in% c ("Evidences", "Publications", "Phenotypes", "EnsembleGeneIds")]
    
    
    ## OUTPUT
    panels <- panels[,c ("Panel_Id", "CurrentVersion", "Number_of_Genes", "Panel_Name", "DiseaseGroup", "DiseaseSubGroup")]
    genes <- genes[,c ("Panel_Name", "GeneSymbol", "LevelOfConfidence", "Penetrance", "ModeOfInheritance", "ModeOfPathogenicity")]

    res <- list (panels       = panels,
                 disorders    = disorders,
                 genes        = genes,
                 evidences    = evidences,
                 publications = publications,
                 phenotypes   = phenotypes,
                 ensembl      = ensembl)
    
    ## clear row names
    for (ta in names (res)) {
        rownames (res[[ta]]) <- NULL
    }
    
    return (res)
}

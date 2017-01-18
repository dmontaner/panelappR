
`panelappR` is an R library to download
[PanelApp](https://panelapp.extge.co.uk)
data.



Install
================================================================================

You can install the library doing:

    library (devtools)
    install_github ("dmontaner/panelappR/pkg")



Usage
================================================================================

Load the package

    library (panelappR)


Download the data

    pad <- paDownload ())

`pad` is a list containing the following data frames:

- panels
- disorders
- genes
- evidences
- publications
- phenotypes
- ensembl

Annotate the genes using the latest Ensembl information.

    pad <- paAnnotate (pad)

This will incorporate the Ensembl information in new columns of the data.frame pad$ensembl.
Use `append = FALSE` if you want to get the information in an independent data.frame.
Use `latestVersion = FALSE` if you want to annotate using Ensembl 80,
the version in which PanelApp was firstly developed.

Export into an `xlsx` file:

	paExport.xlsx (pad, file = "panelap_data.xlsx")

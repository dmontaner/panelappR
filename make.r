#! /usr/bin/Rscript --vanilla

## make.r
## 2017-03-09 david.montaner@gmail.com
## my make file for developing R packages

date ()
rm (list = ls ())
R.version.string ##"R version 3.3.3 (2017-03-06)"
library (devtools); packageDescription ("devtools", fields = "Version") #"1.12.0"
library (knitr); packageDescription ("knitr", fields = "Version")       #"1.15.1"
library (markdown); packageDescription ("markdown", fields = "Version") #"0.7.7"
#help (package = devtools)


################################################################################


## Clean up some directories. Usually not needed.
unlink ("local", recursive = TRUE)
unlink ("check", recursive = TRUE)
##unlink ("pkg/man", recursive = TRUE)  ## BE CAREFUL HERE !!!
##unlink ("pkg/NAMESPACE")              ## BE CAREFUL HERE !!!

### Create directories
dir.create ("local") ## to install the library locally
dir.create ("check") ## to keep the output of the check command

################################################################################


### Build documentation and NAMESPACE
document (pkg = "pkg")

################################################################################


### FULL CHECK
## check (pkg = "pkg", check_dir = "check", cran = TRUE)

### First (quick) CHECK of the library
check (pkg = "pkg",
       document = TRUE,      ## document: if ‘TRUE’ (the default), will update and check documentation before running formal check.
       check_dir = "check",   ## check_dir: the directory in which the package is checked
       vignettes = FALSE,                           ## do not run vignette code ............ when BUILDING
       args = c ("--no-examples", "--no-vignettes") ## do not run vignette code and examples when CHECKING -> args: Additional arguments passed to ‘R CMD check’
       )

## ## Examples: run separately from check
## run_examples (pkg = "pkg")

### Test
test (pkg = "pkg")


################################################################################

### Vignettes
build_vignettes (pkg = "pkg")

## md format for Github
vignetas <- dir ("pkg/vignettes")
for (vg in vignetas) {
    vg.md <- sub ("Rmd$", "md", vg)
    knit (input = file.path ("pkg", "vignettes", vg))
    li <- readLines (vg.md)
    ## li <- li[-(1:which (li == "</style>"))]
    menos <- which (li == "---")[1:2]
    li <- li[-(menos[1]:menos[2]) ]
    writeLines (li, vg.md)
}

################################################################################


### Local Installation
install.packages ("pkg", lib = "local", repos = NULL, INSTALL_opts = "--html")

################################################################################


### Build the package
build (pkg = "pkg", manual = TRUE, vignettes = TRUE)
build (pkg = "pkg", manual = TRUE, vignettes = FALSE)


###EXIT
warnings ()
sessionInfo ()
q ("no")

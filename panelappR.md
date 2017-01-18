
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


```r
library (panelappR)
```


Download the data


```r
pad <- paDownload ()
```

`pad` is a list containing the following data frames:

- panels
- disorders
- genes
- evidences
- publications
- phenotypes
- ensembl



```r
lapply (pad, head)
```

```
## $panels
##                   Panel_Id CurrentVersion Number_of_Genes
## 1 553f9596bb5a1616e5ed45aa            1.1               2
## 2 55d30b0322c1fc2ff2a5bf7b            1.3              29
## 3 5790c2be8f62032bd2afefea           0.15             202
## 4 553f97abbb5a1616e5ed45f9            1.2              53
## 5 553f9595bb5a1616e5ed45a8            1.8              25
## 6 55a3876e22c1fc63fec6d0da            1.1              15
##                                           Panel_Name
## 1                                    Agranulocytosis
## 2 Amyotrophic lateral sclerosis/motor neuron disease
## 3                    Anaemias and red cell disorders
## 4                         Anophthalmia/microphthamia
## 5                      A- or hypo-gammaglobulinaemia
## 6    Arrhythmogenic Right Ventricular Cardiomyopathy
##                                 DiseaseGroup
## 1                   Haematological disorders
## 2 Neurology and neurodevelopmental disorders
## 3                   Haematological disorders
## 4                 Ophthalmological disorders
## 5                   Haematological disorders
## 6                   Cardiovascular disorders
##                      DiseaseSubGroup
## 1 Primary immunodeficiency disorders
## 2        Neurodegenerative disorders
## 3    Anaemias and red cell disorders
## 4               Ocular malformations
## 5 Primary immunodeficiency disorders
## 6                     Cardiomyopathy
## 
## $disorders
##                                           Panel_Name
## 1                                    Agranulocytosis
## 2 Amyotrophic lateral sclerosis/motor neuron disease
## 3 Amyotrophic lateral sclerosis/motor neuron disease
## 4                    Anaemias and red cell disorders
## 5                    Anaemias and red cell disorders
## 6                    Anaemias and red cell disorders
##                                                      Relevant_disorders
## 1                                                       Agranulocytosis
## 2                    Amyotrophic lateral sclerosis/motor neuron disease
## 3                 Amyotrophic lateral sclerosis or motor neuron disease
## 4                                       Anaemias and red cell disorders
## 5 Aplastic anaemia with or without paroxysmal nocturnal haemoglobinuria
## 6     Apparent aplastic anaemia or paroxysmal nocturnal haemoglobinuria
## 
## $genes
##                                           Panel_Name GeneSymbol
## 1                                    Agranulocytosis       HAX1
## 2                                    Agranulocytosis       TCN2
## 3 Amyotrophic lateral sclerosis/motor neuron disease       ALS2
## 4 Amyotrophic lateral sclerosis/motor neuron disease        ANG
## 5 Amyotrophic lateral sclerosis/motor neuron disease      DCTN1
## 6 Amyotrophic lateral sclerosis/motor neuron disease       FIG4
##   LevelOfConfidence Penetrance ModeOfInheritance ModeOfPathogenicity
## 1      HighEvidence   Complete         biallelic                <NA>
## 2      HighEvidence   Complete         biallelic                <NA>
## 3      HighEvidence   Complete         biallelic                <NA>
## 4      HighEvidence   Complete       monoallelic                <NA>
## 5      HighEvidence   Complete       monoallelic                <NA>
## 6      HighEvidence   Complete       monoallelic                <NA>
## 
## $evidences
##                                           Panel_Name GeneSymbol
## 1                                    Agranulocytosis       HAX1
## 2                                    Agranulocytosis       HAX1
## 3                                    Agranulocytosis       TCN2
## 4                                    Agranulocytosis       TCN2
## 5 Amyotrophic lateral sclerosis/motor neuron disease       ALS2
## 6 Amyotrophic lateral sclerosis/motor neuron disease       ALS2
##                                     Evidences
## 1                         Expert Review Green
## 2 Radboud University Medical Center, Nijmegen
## 3                         Expert Review Green
## 4                                  Literature
## 5                                      Expert
## 6                         Expert Review Green
## 
## $publications
##                                           Panel_Name GeneSymbol
## 1                                    Agranulocytosis       TCN2
## 2                                    Agranulocytosis       TCN2
## 3                                    Agranulocytosis       TCN2
## 4                                    Agranulocytosis       TCN2
## 5                                    Agranulocytosis       TCN2
## 6 Amyotrophic lateral sclerosis/motor neuron disease       ALS2
##     Publications
## 1       18956255
## 2       20352340
## 3        7849710
## 4        7980584
## 5 PMID: 24305960
## 6       23881933
## 
## $phenotypes
##        Panel_Name GeneSymbol
## 1 Agranulocytosis       HAX1
## 2 Agranulocytosis       TCN2
## 3 Agranulocytosis       TCN2
## 4 Agranulocytosis       TCN2
## 5 Agranulocytosis       TCN2
## 6 Agranulocytosis       TCN2
##                                                            Phenotypes
## 1       Neutropenia, severe congenital 3, autosomal recessive, 610738
## 2                                                  Agammaglobulinemia
## 3                                                     Agranulocytosis
## 4                                       A- or hypo-gammaglobulinaemia
## 5 can have a presentation similar to severe combined immunodeficiency
## 6                                        Combined B and T cell defect
## 
## $ensembl
##   GeneSymbol EnsembleGeneIds
## 1      A2ML1 ENSG00000166535
## 2       AAAS ENSG00000094914
## 3      AAGAB ENSG00000103591
## 4       AARS ENSG00000090861
## 5       AARS         LRG_359
## 6      AARS2 ENSG00000124608
```


Annotate the genes using the latest Ensembl information.


```r
pad <- paAnnotate (pad)
```

The the Ensembl information is now incorporated  in new columns of the data.frame `pad$ensembl`


```r
head (pad$ensembl)
```

```
##   GeneSymbol EnsembleGeneIds hgnc_symbol    hgnc_id chromosome_name
## 1      A2ML1 ENSG00000166535       A2ML1 HGNC:23336              12
## 2       AAAS ENSG00000094914        AAAS HGNC:13666              12
## 3      AAGAB ENSG00000103591       AAGAB HGNC:25662              15
## 4       AARS ENSG00000090861        AARS    HGNC:20              16
## 5       AARS         LRG_359        <NA>       <NA>            <NA>
## 6      AARS2 ENSG00000124608       AARS2 HGNC:21022               6
##   start_position end_position strand   gene_biotype
## 1        8822472      8887001      1 protein_coding
## 2       53307456     53324864     -1 protein_coding
## 3       67201033     67255195     -1 protein_coding
## 4       70252295     70289543     -1 protein_coding
## 5             NA           NA     NA           <NA>
## 6       44299654     44313326     -1 protein_coding
```

Use `append = FALSE` if you want to get the information in an independent data.frame.
Use `latestVersion = FALSE` if you want to annotate using Ensembl 80,
the version in which PanelApp was firstly developed.


Export into an `xlsx` file:


```r
paExport.xlsx (pad, file = "panelap_data.xlsx")
```


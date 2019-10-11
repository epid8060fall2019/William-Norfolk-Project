# Overview

This is a project/paper by Brian McKay & co-authors analyzing transmission-symptom-activity trade-offs in flu patients.

This is an example of a fully automated and reproducible analysis.

Note: More details on all files are provided in the "Supplemental Material" document. 

# Quick Instructions for reproducing all results

1. Download the zip file to your computer, unzip it.
2. Double-click "Virulence_Trade-off.Rproj", which should open in RStudio (make sure R and RStudio are installed).
3. Open the R script "Data Cleaning.R" in the "2 Data Cleaning Script" folder. Run the script by pressing the "Source" button. The script uses "Data.Rda" and produces three clean data sets used for all further analyses. The data sets are all saved in the "3 Clean Data" folder and include:
    i) "SympAct" Contains data for all the patients with a respiratory primary complaint.
    ii) "SympAct_Any_Pos.Rda" Contains data for all influenza patients regardless of diagnosis method.
    iii) "SympAct_Lab_Pos.Rda" Contains data for influenza patients diagnosed based on a PCR or rapid antigen test.
4. Open and run (source) the R scripts in the "4 Analysis Scripts" folder. The order you run these scripts does not matter. The scripts save results in the "5 Results" folder. The "Multivariate ..." script might take several minutes to run.
5. Once you ran all the previous scripts, open and run (by pressing 'knit') "Manuscript.Rm" in the "6 Manuscript" folder. This combines all the relevant results and creates the main text as a Word document.
6. Open and run (by pressing 'knit') "Supplemental Material.Rmd" in the "7 Supplemental Material" folder. This generates the supplementary material as Word document.


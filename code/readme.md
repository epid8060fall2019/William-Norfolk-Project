##How to Run the Primary Project Scripts

To run processing code or exploratory data analysis code select the desired Rmd file or files from the subfolders _analysis_code_ and/or _processing_code_. To view the results in the RStudio select _Run All Chunks_, to view as a docx output file select _knit to Word doc_. All knitted docx files can also be directly found in the specific code subfolder. 

For a detailed breakdown of the data import, cleaning, and wrangling process please reference the written commentary embedded into the Rmd file titled _WQprocessing.Rmd_ in the _processing_code_ subfolder. Commentary is also viewable via the docx output file of the same name included in the _processing code_ subfolder.

For a detailed breakdown of the exploratory data analysis please reference the written commentary embedded into the Rmd files titled _Exploratory_Data_Analysis_Location.Rmd_ and _Exploratory_Data_Analysis_Seasonal_ in the _analysis_code_ subfolder. The _Location_ script focuses on variables concerned with the specific habitat type of each sampling site measured within the study. The _Seasonal_ script focuses on variables concerned with seasonal changes in the data and explores the effects of Hurrican Irma landfall on the water quality conditions of Key Largo. Commentary is also viewable via the docx output file of the matching name to the script of interest. 


##How to Run the Citizen Science Processing Script

This script will produce quick simple figures that can be readily viewed by MarineLab program participants to visualize the data they have collected throughout the program.This script is designed in such a way that individuals that are unfamilar with the usage of Rstudio can successfully generate simple figures to view collected data with a minimal amount of reading.

This script operates using the excel sheet titled _individual_program_data_template_example_ which can be found inside this project directory under the _data_ folder and inside the _individual_program_data_ subfolder. 

To run this script you must first download this project from GitHub. Go to the main project repository found at this [link](https://github.com/epid8060fall2019/William-Norfolk-Project). Select the *green* buttom called clone or download. Download the zip. Unzip the file, and save it to your local computer (ideally in its own folder).

Next you must enter your data.

1. There is a data entry template located within the project directory inside the _data_ folder in the _individual_program_data_ subfolder. Copy the data template (please ensure the template is _copied_ and not overwritten) and delete any example data in the cells. _DO NOT_ delete/modify any variable names or add any addtional variables to the excel sheet. 

2. Enter the data from the program into the cells. _It is imperative_ that all data cells are filled. The script is designed to handel an NA entry if present, however the script will drop the entire observation if there are any NA values so it is best to ensure there are none in the data.
  -R is very picky regarding capitalization, extra spaces, and any any werid syntax. These can produce strange errors which will ruin the data visualization. Please ensure all data is entered with the same format that the example file provides (i.e. data should be 1.23.19, do not include units in entry, etc.)
  
3. Once you have entered your data, save your excel file with a unique name (i.e. VALPO_2019) inside the _individual_program_data_ folder (you can save it here directly or save to the desktop first then drag it into the folder). 

4. Next open Rstudio *(skip to setp 5 if the program has been previously run on your computer)*.
  -If the computer you are using is not setup to run this script you must first insall all the nessecary components. Details below.
  -You must first install R, which can be found at this [link](https://www.r-project.org/).Follow the _download R_ link on the website. You can select any CRAN mirror you like, just ensure it is a USA version and newer than 3.5. (This script was developed under the Duke University mirrior). Select the approproate download for your computer type: i.e. Windows or Mac.
  -Next you must install Rstudio Desktop, follow this [link](https://rstudio.com/products/rstudio/download/) to do so. Select the free version.
  -Next you must download Pandoc. Pandoc is a program that will convert our script to a Word Document, you can download the latest version of Pandoc at this [link](https://pandoc.org/installing.html).
  -Lastly you must install all nessecary packages into your Rstudio. Open Rstudio.
  -Once opened you will see a 4-paned viewing screen (it will look daunting at first do not worry). The _top left_ screen is the script screen. This is where all loaded scripts are viewed and all modifications are made (you will make very small changes here to load the new data). The _bottom left_ is called the console (this si the working part of R) you will only need to enter items into the console if the required packages are not installed. The _top right_ is the global environment, this is where all saved objects are stored for reference while working on scripts (you will not need to worry about this pane to run the script). The _bottom right_ is the file viewer, this is where you can see the files in the project you are working on (you will make minimial use of this pane during this script run).
  -If this is the first run of this script you must install all packages required.
  -Click into the console _bottom left_.
  -Type the following syntax: install.packages("readxl") then hit enter. R will automatically load the _readxl_ package. 
  -There are nine required packages to run this script and all must be loaded individually. Repeat the above syntax for the following packages: _dplyr, tidyverse, forcats, ggthemes, knitr, naniar, gridExtra, ggpubr_ you must enter install.packages("") every time and change the names within the parentheses to the package names. *Remember* capitalization is important and extra spaces count so be specific. Once installed onto a specific computer packages need not be installed again unless R is removed from the computer. 
  
5. In Rstudio select _File_, _Open Project_, and select the folder where you saved this project locally (you want to click on the Rproj file, this is the file with the blue cube icon located next to it). This will open the project file.

6. From the project directory use the file viewer _(bottom right pane)_ to navigate to the citizen science processing script. Select _code_ then _processing code_, then click on _citize_science_processing_script.Rmd_. This will open the script inside the script viewer _(top left pane)_.

7. Once inside the script the _only_ modification that must be made is a change to the relative path of the new data you created in the excel file. It is important that this is the only change made in the file. If you accidently change something there is an undo option under the edit tab that is your friend. 

8. To change the path scroll to the second code chunk in the Rmd file titled _load data_. In the file viewer this code chunk looks as below: 

_```{r load data}_
_wqdata <- readxl::read_excel("../../data/individual_program_data/individual_program_data_template_example.xlsx")_

_```_

9. To change the path first ensure your new excell file is located in the same folder as the example sheet. All excel filed should be saved in the _individual_program_data_ folder. This can be found in the project directory under _data_ and the subfolder _indvidual_program_data_. If your excell file is not in this folder the script will not work. You can simply drag and drop your new excel sheet into this folder (without using R) if it is saved locally elsewhere.

10. Update the path. In the above code chunk you must change the file name. Inside the parentheses there is the following syntax:

"../../data/individual_program_data/individual_program_data_template_example.xlsx"

You must delete _individual_program_data_template_example_ and replace this text with the name of the new excel file you created. Remember capitalization and spaces count so include them exactly as they are in your file name. _DO NOT_ delete any other parts of the path that occur infront or behind the file name you have changed. If done correctly your text inside the parentheses should look as below:

"../../data/individual_program_data/INSERT NEW FILE TEXT HERE.xlsx"

11. Once you have updated the file path you must _knit_ the file to produce a word document containing all of the important information. In the top left hand corner of the script viewer pane click the _knit button_ (there is a yarn icon next to it). You can knit directly or click the arrow to use the dropdown menu. Select knit to Word Document and wait. The script should take a minute or two to generate the output. 

12. If successful a word document will open directly onto your computer containing all of the script commentary, code chunks, and produced figures. The figures can be directly copied from this document and transferred to any viewing platform you prefer (i.e. Powerpoint). 






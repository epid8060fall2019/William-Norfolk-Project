# How to Run the Primary Project Scripts
### _Run These Scripts to Reproduce Data Analysis_

To run processing code select the Rmd file **WQprocessing.Rmd** found within the **code** folder and **processing_code** subfolder. To view the results in the RStudio select **Run All Chunks** or to view as a docx output file select **knit to Word doc**. All knitted docx files can also be directly found in the specific code subfolder. 

To run any of the various data analysis code the **WQprocessing.Rmd** script must first be run (see above). Next select the desired Rmd file or files from the **analysis_code** subfolder. To view the results in the RStudio select **Run All Chunks** or to view as a docx output file select **knit to Word doc**. All knitted docx files can also be directly found in the specific code subfolder. 

For a detailed breakdown of the data import, cleaning, and wrangling process please reference the written commentary embedded into the Rmd file titled **WQprocessing.Rmd** in the **processing_code** subfolder. Commentary is also viewable via the docx output file of the same name included in the **processing code** subfolder.

For a detailed breakdown of the exploratory data analysis please reference the written commentary embedded into the Rmd files titled **Exploratory_Data_Analysis_Location.Rmd** and **Exploratory_Data_Analysis_Seasonal** in the **analysis_code** subfolder. The _Location_ script focuses on variables concerned with the specific habitat type of each sampling site measured within the study. The _Seasonal_ script focuses on variables concerned with seasonal changes in the water quality of Key Largo. Commentary is also viewable via the docx output file of the matching name to the script of interest. 

For a detailed breakdown of the bivariate analysis please reference the written commentary embedded into the Rmd file titled **Bivariate_Analysis.Rmd** in the **analysis_code** subfolder. Commentary is also viewable via the docx output file of the matching name to the script of interest.

For a detailed breakdown of the Hurricane Irma analysis please reference the written commentary embedded into the Rmd file titled **Hurricane_Irma_Analysis.Rmd** in the **analysis_code** subfolder. Commentary is also viewable via the docx output file of the matching name to the script of interest.

For a detailed breakdown of the Citizen Science Efficacy analysis please reference the written commentary embedded into the Rmd file titled **Citizen_Science_Efficacy_Analysis** in the **analysis_code** subfolder. Commentary is also viewable via the docx output file of the matching name to the script of interest.

# How to Run the Citizen Science Processing Script with New Program Data
## _Run This Script to Produce a Quick Analysis of Program Data_ 

This script will produce quick simple figures that can be readily viewed by MarineLab program participants to visualize the data they have collected throughout the program.This script is designed in such a way that individuals that are unfamilar with the usage of Rstudio can successfully generate simple figures to view collected data with a minimal amount of reading.

This script operates using the excel sheet titled **individual_program_data_template_example** which can be found inside this project directory under the **data** folder and inside the **individual_program_data** subfolder. 

To run this script you must first download this project from GitHub. Go to the main project repository found at this [link](https://github.com/epid8060fall2019/William-Norfolk-Project). Select the **green** buttom called clone or download. Download the zip. Unzip the file, and save it to your local computer (ideally in its own folder).

### Next you must enter your data.

1. There is a data entry template located within the project directory inside the **data** folder in the **individual_program_data** subfolder. Copy the data template (please ensure the template is **copied** and not overwritten) and delete any example data in the cells. **DO NOT** delete/modify any variable names or add any addtional variables to the excel sheet. 

2a. Enter the data from the program into the cells. **It is imperative** that all data cells are filled. The script is designed to handel an NA entry if present, however the script will drop the entire observation if there are any NA values so it is best to ensure there are none in the data.

2b.R is very picky regarding capitalization, extra spaces, and any any werid syntax. These can produce strange errors which will ruin the data visualization. Please ensure all data is entered with the same format that the example file provides (i.e. data should be 1.23.19, do not include units in entry, etc.)
  
3. Once you have entered your data, save your excel file with a unique name (i.e. MYPROGRAM_2019) inside the **individual_program_data** folder (you can save it here directly or save to the desktop first then drag it into the folder). 

4a. Next open Rstudio **(skip to setp 5 if the program has been previously run on your computer)**.
_If the computer you are using is not setup to run this script you must first insall all the nessecary components._ Details below:

4b. You must first install R, which can be found at this [link](https://www.r-project.org/).Follow the **download R** link on the website. You can select any CRAN mirror you like, just ensure it is a USA version and newer than 3.5. (This script was developed under the Duke University mirrior). Select the approproate download for your computer type: i.e. Windows or Mac.

4c. Next you must install Rstudio Desktop, follow this [link](https://rstudio.com/products/rstudio/download/) to do so. Select the free version.

4d. Next you must download Pandoc. Pandoc is a program that will convert our script to a Word Document, you can download the latest version of Pandoc at this [link](https://pandoc.org/installing.html).

4e. Lastly you must install all nessecary packages into your Rstudio. **Open Rstudio**.

Once opened you will see a 4-paned viewing screen _(it will look daunting at first do not worry)_. The **top left** screen is the script screen. This is where all loaded scripts are viewed and all modifications are made _(you will make very small changes here to load the new data)_. The **bottom left** is called the console (this si the working part of R) you will only need to enter items into the console if the required packages are not installed. The **top right** is the global environment, this is where all saved objects are stored for reference while working on scripts _(you will not need to worry about this pane to run the script)_. The **bottom right** is the file viewer, this is where you can see the files in the project you are working on _(you will make minimial use of this pane during this script run)_.

If this is the first run of this script you must install all packages required.

4f. Click into the console **bottom left**.

4g. Type the following syntax: **install.packages("readxl")** then hit enter. R will automatically load the **readxl** package. 

4h. There are nine required packages to run this script and all must be loaded individually. Repeat the above syntax for the following packages: **dplyr, tidyverse, forcats, ggthemes, knitr, naniar, gridExtra, ggpubr** you must enter install.packages("") every time and change the names within the parentheses to the package names. **Remember** capitalization is important and extra spaces count so be specific. Once installed onto a specific computer packages need not be installed again unless R is removed from the computer. 
  
5. In Rstudio select **File**, **Open Project**, and select the folder where you saved this project locally (you want to click on the Rproj file, this is the file with the blue cube icon located next to it). This will open the project file.

6. From the project directory use the file viewer **(bottom right pane)** to navigate to the citizen science processing script. Select **code** then **processing code**, then click on **citizen_science_processing_script.Rmd**. This will open the script inside the script viewer **(top left pane)**.

7. Once inside the script the **only** modification that must be made is a change to the relative path of the new data you created in the excel file. It is important that this is the only change made in the file. If you accidently change something there is an undo option under the edit tab that is your friend. 

8. To change the path scroll to the second code chunk in the Rmd file titled **load data**. In the file viewer this code chunk looks as below: 

**```{r load data}**
**wqdata <- readxl::read_excel("../../data/individual_program_data/individual_program_data_template_example.xlsx")**

**```**

9. To change the path first ensure your new excell file is located in the same folder as the example sheet. All excel filed should be saved in the **individual_program_data** folder. This can be found in the project directory under **data** and the subfolder **indvidual_program_data**. If your excell file is not in this folder the script will not work. You can simply drag and drop your new excel sheet into this folder (without using R) if it is saved locally elsewhere.

10. Update the path. In the above code chunk you must change the file name. Inside the parentheses there is the following syntax:

**"../../data/individual_program_data/individual_program_data_template_example.xlsx"**

You must delete **individual_program_data_template_example** and replace this text with the name of the new excel file you created. Remember capitalization and spaces count so include them exactly as they are in your file name. **DO NOT** delete any other parts of the path that occur infront or behind the file name you have changed. If done correctly your text inside the parentheses should look as below:

**"../../data/individual_program_data/INSERT NEW FILE TEXT HERE.xlsx"**

11. Once you have updated the file path you must **knit** the file to produce a word document containing all of the important information. In the top left hand corner of the script viewer pane click the **knit button** (there is a yarn icon next to it). You can knit directly or click the arrow to use the dropdown menu. Select knit to Word Document and wait. The script should take a minute or two to generate the output. 

12. If successful a word document will open directly onto your computer containing all of the script commentary, code chunks, and produced figures. The figures can be directly copied from this document and transferred to any viewing platform you prefer (i.e. Powerpoint). 






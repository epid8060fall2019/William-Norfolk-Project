# Data Storage

This folder contains all of the raw, stored, and generated data files/templates needed to run all of the analysis of this project. This folder is subdivided into three subfolders: raw_data, processed_data, and indivdiual_program_data.

## Raw Data

The ```raw_data``` subfolder contains the raw water quality data used to produce the primary analysis of this project and manuscript. This folder contains two xlsx filed ```RAW_WQ_Data.xlsx``` and ```RAW_WQ_Data_TimeModified.xlsx```. ```RAW_WQ_Data.xlsx``` contains the full raw data directly from the MarineLab water quality data base. ```RAW_WQ_Data_TimeModified.xlsx``` contains the raw data from this database with modifications of the date and time variables to disable excel autoformatting which inhibits proper data upload. 

## Processed Data

The ```processed_data``` subfolder contains a single rds file titled ```processeddata.rds```. This rds file is produced by running the ```WQprocessing_script.Rmd``` located inside the ```code``` folder and ```processing_code``` subfolder. The processed rds file is the clean data upload source that is required to run all subsequent analysis scripts found in the ```analysis_code``` subfolder.

## Individual Program Data

The ```individual_program_data``` folder contains a template xlsx file titled ```individual_program_data_template_example```. This excel template serves as the data entry shell needed to to run the ```citizen_science_processing_script``` located in the ```code``` folder and ```processing_code``` subfolder. This excel template is a structure data entry format designed to integrate directly with the subsequent processing script to produce a quick analysis of individual program sampling data at the conclusion of field collection. New data should be entered into the template and saved to the ```individual_program_data``` subfolder (this folder). After saving, the new data can be directly analyzed simply by modifying the data path with the new name. A detailed description of data entry/script usage for this task can be found in the ReadMe file in the ```code``` folder. 
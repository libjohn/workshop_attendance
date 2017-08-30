## README

These scripts transform springshare libcal registration data.

There are two goals: transform and automate attendance file movement.

1. Transform the Springshare-registration data to produce a paper form which attendees can use to sign-in when present in a workshop
    - libcal --> Rstudio --> msWord Attendance File
2. Transform the Springshare-registration data into a format which Joel requested for deposit in Google Drive.  Script will upload transformed data frame to Google Drive as a Google Sheet
    - libcal --> RStudio --> GoogleDrive

## Assumptions:

- You have already downloaded the 1-3 registration files from Springshare and have not changed the filenames
- Your Springshare data files are located inside a "data" subdirectory of the R project directory
    - project directory is identified with `getwd()`.  If not, `setwd()`
- There are no more than three files inside the data directory
    - one attendees file, one waitlist file, one cancellations file
    - the attendees file is mandatory
    - you can put each file-set in a subdirectory of the data directory.  Subdir is identified at the command line in the console (see below)
- No user data will be uploaded to GitLab or GitHub
- User data on your personal machine is your responsibility
- User data in the GoogleSheet is protected by the Google Drive permissions that you have set
- The following R library-packages are used and must be installed in your R System
    - process_files_to_df.Rmd
        - tidyverse
        - readr
        - lubridate
        - stringr
    - write_roster.Rmd
        - tidyverse
        - knitr
    - write_to_gs.Rmd
        - googlesheets
        - tidyverse
    - make_add_email_to_DVS_Annouce_list.Rmd
        - tidyverse
        - knitr

## Quick Start

1. Get libcal files, transform and write to Google Drive

    - First, download your data from LibCal; place data inside the `data` directory of your RStudio Project 
    
        - You can also make subdirectories inside the data directory but will need to modify line 10 of the script
        
    - Open RStudio with Console as your active quadrant
    - At the console, run the script: `csv-to-df_write-to-gs.r`
    - This converts your data to a Google Sheet in your Google Drive space.  See [At Google Drive](#upload-your-data-as-a-google-sheet) section for next steps.
    
### Next Development Step for "Quck Start".  Add the [Email Parsing](#add-email-addresses-to-dvs-announce) to the `csv-to-df_write-to-gs.r` script.  Will probably use `write_csv` -- or some-such similar command -- to generate a .csv outfile.


## Long Version

**Note:** you can run either the "Long version" commands **or** the "Quick Start".  

### Make a "data" subdirectory

1. Fork this repository
1. [In RStudio,] From the Files pane > New Folder > data
1. Download your Springshare registration data to your newly created data directory


### Produce an attendance roster

At the console:

1. `rm(list = ls(all = TRUE))`  # remove any environment variables before starting
1. `rmarkdown::render("process_files_to_df.Rmd", params = list(dat_dir = "data"))`  # identify the data subdirectory here.  e.g. data_dir = "data/my_workshop101"
1. `rmarkdown::render("write_roster.Rmd", output_file = "roster.docx")`

&nbsp;

- The output will be an MS Word File found in the root project directory (`getwd()`)
- Windows (and maybe Mac) will nee to install [Pandoc](http://pandoc.org/installing.html) for this procedure to work
- Print by opening the roster.docx file in Word
- You many want to adjust the Layout orientation within Word by setting the orientation to Landscape

### Upload your data as a Google Sheet

1. login to Google Drive (for initial upload, you may be prompted in the web-browser, at Google Drive, to authorize/allow the upload process.)

At the console:

1. `rm(list = ls(all = TRUE))`  # remove any environment variables before starting
1. `rmarkdown::render("process_files_to_df.Rmd", params = list(dat_dir = "data"))`  # identify the data subdirectory here.  e.g. data_dir = "data/my_workshop101"
1. `rmarkdown::render("write_to_gs.Rmd")`

At Google Drive:
1. Manually move the processed and uploaded registration file from your MyDrive space to Joel's predefined location
    - My Drive > Data and Visualization Services > Workshops > Spring 2017 > Assessment
1. The [codebook](https://docs.google.com/document/d/1MzJVkMQhAespElJ-JPT8PotqGPmZesk7FbvVTNv5Fo8/edit) defines where you will manually mark attendance, waitlist, and walk-ins.  You can use the paper Roster to help you complete this section.  

Note: The process of uploading the files can take several minutes.  The length of time seems to be related to the length of the list and whether this is the first upload session of your day.  In my experience, the more files I uploaded, the quicker the upload transaction (Hmm, that's a suspect experience.  It might just be the larger the number of rows, the longer the upload transaction.  More testing required).  

Note:  In this iteration I added a column **list_type** which helps identify if the attendee came from the registered or waitlisted column.  In the future I plan to remove this column because it's not in Joel's codebook.  **Therefore**, you must **manually delete** the *list_type* **column** after you have successfully marked the attendance in the GoogleSheet.

### Add email addresses to DVS Announce

-  Joel maintains a Google Doc for this

    - Google Drive > Data and Visualization Services > workshops > Spring 2017 > Assessment

-  All you need to do is generate a list of email addresses, 1 per line, of those who ask to be added to the list

1. `rm(list = ls(all = TRUE))`  # remove any environment variables before starting
1. `rmarkdown::render("process_files_to_df.Rmd", params = list(dat_dir = "data"))`  # identify the data subdirectory here.  e.g. data_dir = "data/my_workshop101"
1. `rmarkdown::render("make_add_email_to_DVS_Annouce_list.Rmd", output_file = "email_list.html")`
1. Open the resulting HTML file, *email_list.html*.  Copy the addresses into your clipboard buffer
1. Open the Google Doc, paste the clipboard buffer into that file.  Paste without formatting.


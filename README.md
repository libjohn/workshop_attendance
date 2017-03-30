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

## Quick Start

### Make a "data" subdirectory

1. Fork this repository
1. From the Files pane > New Folder > data
1. Download your Springshare registration data to your newly created data directory


### Produce an attendance roster

At the console:

1. `rm(list = ls(all = TRUE))`  # remove any environment variables before starting
1. `rmarkdown::render("process_files_to_df.Rmd", params = list(dat_dir = "data"))`  # identify the data subdirectory here.  e.g. data_dir = "data/my_workshop101"
1. `rmarkdown::render("write_roster.Rmd", output_file = "roster.docx")`

&nbsp;

- The output will be an MS Word File found in the root project directory (`getwd()`)
- Windows (and maybe Mac) will nee to install [Pandoc](http://pandoc.org/installing.html) for this procedure to work

### Upload your data as a google sheet

1. login to Google Drive (for initial upload, you may be prompted in the web-browser, at Google Drive, to authorize/allow the upload process.)

At the console:

1. `rm(list = ls(all = TRUE))`  # remove any environment variables before starting
1. `rmarkdown::render("process_files_to_df.Rmd", params = list(dat_dir = "data"))`  # identify the data subdirectory here.  e.g. data_dir = "data/my_workshop101"
1. `rmarkdown::render("write_to_gs.Rmd")`

At Google Drive:
1. Manually move the processed and uploaded registration file from your MyDrive space to Joel's predefined location
    - My Drive > Data and Visualization Services > Workshops > Spring 2017 > Assessment
1. The [codebook](https://docs.google.com/document/d/1MzJVkMQhAespElJ-JPT8PotqGPmZesk7FbvVTNv5Fo8/edit) defines where you will manually mark attendance, waitlist, and walk-ins.  You can use the paper Roster to help you complete this section.  

Note:  In this iteration I added a column **list_type** which helps identify if the attendee came from the registered or waitlisted column.  In the future I plan to remove this column because it's not in Joel's codebook.  **Therefore**, you must **manually delete** the *list_type* **column** after you have successfully marked the attendance in the GoogleSheet.

### Add email addresses to DVS Annouce

-  Joel maintains a Google Doc for this

    - Google Drive > Data and Visualization Services > workshops > Spring 2017 > Assessment

-  All you need to do is generate a list of email addresses, 1 per line, of those who ask to be added to the list

1. `rm(list = ls(all = TRUE))`  # remove any environment variables before starting
1. `rmarkdown::render("process_files_to_df.Rmd", params = list(dat_dir = "data"))`  # identify the data subdirectory here.  e.g. data_dir = "data/my_workshop101"
1. `rmarkdown::render("make_add_email_to_DVS_Annouce_list.Rmd", output_file = "email_list.html")`
1. Open the resulting HTML file, *email_list.html*.  Copy the addresses into your clipboard buffer
1. Open the Google Doc, paste the clipboard butter into that file


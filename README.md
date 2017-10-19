# README


## Quick Start

Put your LibCal Registration Data in a the `data` subdirectory

- `source("csv-to-df_make-attendance-roster.r")`
- `source("csv-to-df_write-to-gs.r")`

Look in `outfile` subdirectory for output.

---

## Goal of these scripts

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

## Step By Step Directions

### Make a "data" and "outfile" subdirectory 

1. Fork this repository as a new project in RStudio
1. Using the RStudio git tab, **Pull** the repo to update code
1. [In RStudio,] From the Files pane > New Folder > `data`
1. [In RStudio,] From the Files pane > New Folder > `outfile`
1. Download your Springshare registration data to your newly created `data` directory

### A. Make Attendance Roster

1. First, download your data from LibCal; place data inside the `data` directory of your RStudio Project 
    
    - You can also make subdirectories inside the data directory.
        
1. Open RStudio with Console as your active quadrant.  At the console, run the script:

    - `source("csv-to-df_make-attendance-roster.r")`
    
1. Look in the `outfile` subdirectory to find your output:  `attendance-roster.csv`

    - Open In MS Excel
    - Format with "Format As Table" Option
    - Print Options:  Landscape Orientation, and **Scaling** set to "Fit All Columns on One Page"

### B. Write Roster to Google-Drive, then Mark Attendance.  Add Email Addresses to DVS-Announce

This script will **Transform libcal files** (which you manually downloaded), **write to Google Drive**, and **produce dvs-annouce list**.

1. Download your attendance, waitlist, and cancellation data from LibCal; place data inside the `data` directory of your RStudio Project 
        
1. Open RStudio with Console as your active quadrant.  At the console, run the script: 

    - `source("csv-to-df_write-to-gs.r")`



#### This Roster script does two things...

1. Converts your attendance to a Google Sheet in your Google Drive space.  

    - See [At Google Drive](#at-google-drive) section to complete this manual process
        
1. Produces an Email Addresses to DVS-Announce txt file

    - The `dvs-announce_append-email.txt` file can be found in the `outfile` subdirectory of the RStudio Project
    
        1. Open the resulting HTML file, *email_list.html*.  Copy the addresses into your clipboard buffer
        1. Open the DVS Announce Google Doc, paste the clipboard buffer into that file.  Paste without formatting.
        
##### At Google Drive:
1. Manually move the processed and uploaded registration file from your MyDrive space to Joel's predefined location
    - `My Drive > Data and Visualization Services > Workshops > [Spring 2017] > Assessment`
1. The [codebook](https://docs.google.com/document/d/1MzJVkMQhAespElJ-JPT8PotqGPmZesk7FbvVTNv5Fo8/edit) defines where you will manually mark attendance, waitlist, and walk-ins.  You can use the paper Roster to help you complete this section.  

Note: The process of uploading the files can take several minutes.  The length of time seems to be related to the length of the list and whether this is the first upload session of your day.  In my experience, the more files I uploaded, the quicker the upload transaction (Hmm, that's a suspect experience.  It might just be the larger the number of rows, the longer the upload transaction.  More testing required).  




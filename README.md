# README


## Quick Start

1. Download your LibCal Registration Data

Run this from the console
2. **`rmarkdown::render("libcal_roster.Rmd")`**

    - by default this script **will not upload to Google Drive**
    - the script will prompt you to find the file(s) on your local file system (step 1)


Alternatively, To **upload the GoogleSheet** to Google Drive, run the following from the R console:

A. `rmarkdown::render("libcal_roster.Rmd", params = list(upload_googlesheets = "TRUE"))`

### Attendance Sheet

You must first download the registration file from SpringShare > LibCal > *your event* >  Manage Event > Excel


## Outputs

- **Roster** for Attendance that can be printed via MS Excel
- **visualization** that summarizes the registrees (printable)
- GoogleSheet -- Transformed roster that is uploaded to Google Drive as a Sheet
- **Email List of Newbies** -- list of people who want to be subscribed to the mailing lists

## Goal of these scripts

These scripts transform springshare libcal registration data.

There are two goals: transform and automate attendance file movement.

1. Transform the Springshare-registration data to produce a paper roster that can be used to track workshop attendance.

2. Transform the Springshare-registration data into a format which Joel requested for deposit in Google Drive.  Script will upload transformed data frame to Google Drive as a Google Sheet

> libcal --> RStudio --> GoogleDrive

## Assumptions:

- You have already downloaded the registration files from Springshare and have not changed the filenames
- No user data will be uploaded to GitLab or GitHub
    - use `.gitignore` to prevent uploading user data
    - User data on your personal machine is your responsibility
    - User data in the GoogleSheet is protected by the Google Drive permissions that you have set


## Step By Step Directions

### Make a `data` and `outfile` subdirectory 

1. Clone this repository as a new project in RStudio
1. Download your Springshare registration data 
1. Run this script in the R Console

    - `rmarkdown::render("libcal_roster.Rmd")`
    - You will be prompted to find the downloaded roster
    - The default will not upload to Google
    
        - To Upload to Google...   `rmarkdown::render("libcal_roster.Rmd", params = list(upload_googlesheets = "TRUE"))`


### Where to Find the Outputs

- Roster is in the `outfile` directory
    
    - Open in Excel:  `attendance-roster.csv`
    - Use Excel to **Format Tables** 
    - Use Excel Print functions
    
        - Change to Landscape 
        - Scale all columns to one page in the 
    
- Visualization will be in the RStudio project root (workshop_attendance), as libcal_roster.nb.html.  Just print the selected page

- Email List is in the `outfile` directory

    - `dvs-announce_append-email.txt`
    - This list is possible because we prompt patrons for this during the springshare registration process

- Google Sheet will be in your Google Drive main folder.

    - First time user will have to monitor the R Console for messages about authentication




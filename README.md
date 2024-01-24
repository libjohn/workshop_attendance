# README

To generate a workshop roster (CSV), email addresses to be added to marketing systems, and images visualizing registrants by group, and upload libcal registration to CDVS's Google Drive


## Quick Start

BEFORE You START

1. Download your LibCal Registration Data

### Generate Attendance Roster, email subscriptions, summary images

1. At RStudio Terminal (or CLI command prompt type, e.g. Windows PowerShell)
        - `quarto render ./attendance_reports.qmd -P generate_email_subscribers:true -P generate_print_roster:true`
        - or
        - `quarto render ./attendance_reports.qmd -P upload_googlesheets:true`
        - or
        - `quarto render ./attendance_reports.qmd -P generate_images:true`
        - my favorite
        - `quarto render ./attendance_reports.qmd -P generate_email_subscribers:true -P upload_googlesheets:true`
    - see bottom of this README for tips on quarto cli
2. Look in the output directory for reports

### upload to Google Drive

1. From Windows-Explorer, double-click `generate_google_attendance_report.bat` ; pick an attendance file
2. Look in your Google Drive home directory ; manually move to the CDVS workshop attendance folder for the proper year


## Outputs

Find outputs in the `output directory`.  
See Also:  attendance_reports.html

- **Roster** for Attendance that can be printed via MS Excel
- **visualization** that summarizes the registrants (printable)
- GoogleSheet -- Transformed roster that is uploaded to Google Drive as a Sheet
- **Email List of Newbies** -- list of people who want to be subscribed to the mailing lists

## Goal of these scripts

These scripts transform springshare libcal registration data.

There are three goals: transform and automate registration data for attendance tracking.

1. Transform the Springshare-registration data to produce a paper roster that can be used to track workshop attendance.  (see:  `output/atendance_upload/attendance-roster.csv`)

2. Generate a pre-workshop report showing basic demographics (See:  `attendance_reports.html`)

3. Upload the transformed registration data to CDVS's Google Drive.  Attendance data is kept on Google Drive.  (See _Quickstart_, above)



> libcal --> RStudio --> GoogleDrive

## Quarto cli

See [quarto documentation](https://quarto.org/docs/computations/parameters.html#rendering) for some tips on Quarto Command Line Interface.  In John's case, I'm using PowerShell version 7 (as of January 2024) to run this as the CLI.

## Assumptions:

- You have already downloaded the registration files from Springshare and have not changed the filenames
- No user data will be uploaded to GitLab or GitHub
    - use `.gitignore` to prevent uploading user data
    - User data on your personal machine is your responsibility
    - User data in the GoogleSheet is protected by the Google Drive permissions that you have set





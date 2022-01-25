# README

To generate a workshop roster (CSV), email addresses to be added to marketing systems, and images visualizing registrants by group, and upload libcal registration to CDVS's Google Drive


## Quick Start

BEFORE You START

1. Download your LibCal Registration Data

### Generate Attendance Roster, email subscriptions, summary images

1. From Windows-Explorer, double-click `generate_subscribers_and_roster_plus_htmlReport.bat` ; pick an attendance file
2. Look in the output directory for reports

### upload to Google Drive

1. From Windows-Explorer, double-click `generate_google_attendance_report.bat` ; pick an attendance file
2. Look in your Google Drive home directory ; manually move to the CDVS workshop attendance folder for the proper year


## Outputs

Fine outputs in the `output directory`.  
See Also:  attendance_reports.html

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





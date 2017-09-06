library(tidyverse)
library(readr)
library(lubridate)
library(stringr)
library(googlesheets)

rm(list = ls(all = TRUE))

###  USER INIPUT:  Enter your data directory
data_dir <- "data"   # identify the data directory


###  Load Data Files
files <- as_tibble(str_split(list.files(data_dir), 
                             "_", simplify = T, 4))
files <- files %>% 
  rename(prefix = V1, type = V2, id = V3, id2 = V4) %>% 
  mutate(id = if_else(id == "list", id2, id)) %>% 
  mutate(type = if_else(type == "wait", 
                        "wait_list", type)) %>% 
  mutate(download_date = str_sub(id, 8, -5)) %>% 
  mutate(course_id = str_sub(id, 1,7)) %>% 
  mutate(file_name = paste0(data_dir, 
                            "/", prefix, "_", 
                            type, "_", course_id, 
                            download_date, ".csv")) %>% 
  select(-id2, -id) %>% 
  arrange(type)

###  Produce Attendees List as a Data Frame
attendees_file_path <- files %>% 
  filter(type == "attendees") %>% 
  select(file_name, course_id)

Attendees <- read_csv(attendees_file_path$file_name, 
                      skip=9) %>% 
  mutate(list_type = "attendee") %>% 
  mutate(WorkshopID = attendees_file_path$course_id)

attendees_header <- read_csv(attendees_file_path$file_name, 
                             skip=1, n_max = 7, 
                             col_names = FALSE)

###  Produce Wailt List as a Data Frame
if("wait_list" %in% files$type){
  wl_file_path <- files %>% 
    filter(type == "wait_list") %>% 
    select(file_name, course_id)
  
  WaitList <- read_csv(wl_file_path$file_name, 
                       skip=9)%>% 
    mutate(list_type = "wait list") %>% 
    mutate(WorkshopID = wl_file_path$course_id)
}  


###  Produce Cancelled List as a Data Frame

if("cancelled" %in% files$type){
  cancelled_file_path <- files %>% 
    filter(type == "cancelled")
  
  forGoogleDrive_Cancelled <- read_csv(cancelled_file_path$file_name, skip = 8)
} 


### Process Event Metadata
eventMetaData_attendees <- attendees_header %>% 
  spread(X1, X2) 

eventDate <- mdy(
  str_split(
    eventMetaData_attendees$Date, ", ", 2
  )[[1]][2]
)


### Combine Attendee & Waitlist 
forGoogleDrive_attendees <- Attendees %>% 
  mutate("Workshop Name" = eventMetaData_attendees$Event) %>% 
  mutate("Workshop Date" = as.character(eventDate)) %>% 
  mutate("Attended" = "") %>% 
  mutate("Walk-in" = "") %>% 
  mutate("Waitlist" = "") %>% 
  select(`Attended`, `Walk-in`, `Waitlist`, list_type, `Workshop Date`,
         `Workshop Name`, `WorkshopID`, `First Name`,
         `Last Name`, `Email`, `Booking made`, 
         `Are you affiliated with Duke University?`,
         `Academic Status (or other)`,
         `Discipline or Affiliation`,
         `Institutes, Initiatives, or Program Affiliation`,
         `Where did you hear about this event?`,
         `Have you consulted with Data and Visualization Services before this workshop?`,
         `Would you like to receive more information about DVS events and training?`)

if("wait_list" %in% files$type){
  forGoogleDrive_WaitList <- WaitList %>% 
    mutate("Workshop Name" = eventMetaData_attendees$Event) %>% 
    mutate("Workshop Date" = as.character(eventDate)) %>% 
    mutate("Attended" = "") %>% 
    mutate("Walk-in" = "") %>% 
    mutate("Waitlist" = "") %>% 
    select(`Attended`, `Walk-in`, `Waitlist`, list_type, `Workshop Date`,
           `Workshop Name`, `WorkshopID`, `First Name`,
           `Last Name`, `Email`, `Booking made`, 
           `Are you affiliated with Duke University?`,
           `Academic Status (or other)`,
           `Discipline or Affiliation`,
           `Institutes, Initiatives, or Program Affiliation`,
           `Where did you hear about this event?`,
           `Have you consulted with Data and Visualization Services before this workshop?`,
           `Would you like to receive more information about DVS events and training?`)
}


if("wait_list" %in% files$type){
  forGoogleDrive_attendees <- bind_rows(
    forGoogleDrive_attendees,
    forGoogleDrive_WaitList
  ) %>% 
    arrange(`Last Name`)
} else {
  forGoogleDrive_attendees <- forGoogleDrive_attendees %>% 
    arrange(`Last Name`)
}


## Write Roster as a .txt file

attendees_header %>% 
  write_excel_csv("outfile/attendance-roster.csv", col_names = FALSE)

# add blank line
blank <-  as_tibble(" ")
blank %>% 
  write_excel_csv("outfile/attendance-roster.csv", append = TRUE)

#cat(paste0("Register: ", 
#           "http://duke.libcal.com/event/", 
#           files$course_id[1]),"\n") %>% 
#  write_excel_csv("outfile/attendance-roster.csv", 
#                  append = TRUE)

Example <- tibble(
  `Last Name` = "Chigurh", 
  `First Name` = "Anton", 
  Email = "cipher@cloud.net", 
  `Academic Status (or other)` = "Perpetual", 
  `Discipline or Affiliation` = "Sanitation", 
  list_type = "Example"
)

Roster <- bind_rows(Attendees, 
                    Example,
                    if("wait_list" %in% files$type){WaitList}
)

Roster %>% 
  select(`Last Name`, `First Name`, `Email`, 
         Status = `Academic Status (or other)`, 
         Discipline = `Discipline or Affiliation`, 
         Registration = list_type) %>% 
  arrange(`Last Name`) %>% 
  mutate(Attendance = "") %>% 
  mutate(Attendance = if_else(Status == "Perpetual", 
                              "X", Attendance)) %>% 
  write_excel_csv("outfile/attendance-roster.csv", 
                  append = TRUE, col_names = TRUE)

###############################
# processing script
#
#this script loads the raw data, processes and cleans it 
#and saves it as Rds file in the processed-data folder
#
# Note the ## ---- name ---- notation
# This is done so one can pull in the chunks of code into Quarto documents
# see here: https://bookdown.org/yihui/rmarkdown-cookbook/read-chunk.html
###############################


## ---- packages --------
# load needed packages. make sure they are installed.
library(dplyr) # for data processing/cleaning
library(tidyverse) # for data processing/cleaning
library(skimr) # for nice visualization of data 
library(here) # to set paths
library(lubridate) # to convert datetimes
library(stringr) # to perform regex extractions


## ---- loaddata --------
# path to data
# note the use of the here() package and not absolute paths
file1_location <- here::here("data","raw-data","CEAS_08.csv")
file2_location <- here::here("data","raw-data","Nigerian_Fraud.csv")
file3_location <- here::here("data","raw-data","SpamAssasin.csv")
# load data.
file1 <- read.csv(file1_location)
file2 <- read.csv(file2_location)
file3 <- read.csv(file3_location)
# append dataframes
rawdata <- bind_rows(list(file1, file2, file3))

## ---- exploredata --------
#take a look at the data
dplyr::glimpse(rawdata)
#another way to look at the data
summary(rawdata)
#this is a nice way to look at data
skimr::skim(rawdata)


## ---- cleandata --------
# create a distinct copy for processing
processeddata <- data.table::copy(rawdata)
# convert label and urls to factor
processeddata$label <- as.factor(processeddata$label)
processeddata$urls <- as.factor(processeddata$urls)
# create character length of subject and body fields and clean sender/receiver emails
# some sender and receiver emails either lack an email address or lack any attached contact name to be removed
# we utilize the dplyr 'if_else' function to handle separate cases and ensure we're returning consistent
# results throughout all rows of the dataset
processeddata <- processeddata %>% 
                 mutate(bodylength = nchar(trimws(body)),
                        subjectlength = nchar(trimws(subject)),
                        sender = if_else(
                                         is.na(str_match(processeddata$sender,"<([^>]*)>")[,2]),
                                         processeddata$sender,
                                         str_match(processeddata$sender,"<([^>]*)>")[,2]
                                         ),
                        receiver = if_else(
                                           is.na(str_match(processeddata$receiver,"<([^>]*)>")[,2]),
                                           processeddata$receiver,
                                           str_match(processeddata$receiver,"<([^>]*)>")[,2]
                                           ),
                        )
# create boolean check for sender == receiver as well as extract sender/receiver domains
# some sender and receiver emails either lack an email address or lack any attached contact name to be removed
# we utilize the dplyr 'if_else' function to handle separate cases and ensure we're returning consistent
# results throughout all rows of the dataset
processeddata <- processeddata %>% mutate(
                                          recursive = processeddata$sender == processeddata$receiver,
                                          senderdomain = if_else(
                                                                is.na(str_extract(processeddata$sender, "(?<=@).*")),
                                                                "",
                                                                str_extract(processeddata$sender, "(?<=@).*")
                                                                ),
                                          receiverdomain = if_else(
                                                                  is.na(str_extract(processeddata$receiver, "(?<=@).*")),
                                                                  "",
                                                                  str_extract(processeddata$receiver, "(?<=@).*")
                                                                  ),
                                          )
skimr::skim(processeddata)

## ---- savedata --------
# location to save raw file
save_raw_data_location <- here::here("data","raw-data","rawdata.rds")
saveRDS(rawdata, file = save_raw_data_location)
# location to save processed file
save_processed_data_location <- here::here("data","processed-data","processeddata.rds")
saveRDS(processeddata, file = save_processed_data_location)



## ---- notes --------
# anything you don't want loaded into the Quarto file but 
# keep in the R file, just give it its own label and then don't include that label
# in the Quarto file

# Dealing with NA or "bad" data:
# removing anyone who had "faulty" or missing data is one approach.
# it's often not the best. based on your question and your analysis approach,
# you might want to do cleaning differently (e.g. keep individuals with some missing information)

# Saving data as RDS:
# I suggest you save your processed and cleaned data as RDS or RDA/Rdata files. 
# This preserves coding like factors, characters, numeric, etc. 
# If you save as CSV, that information would get lost.
# However, CSV is better for sharing with others since it's plain text. 
# If you do CSV, you might want to write down somewhere what each variable is.
# See here for some suggestions on how to store your processed data:
# http://www.sthda.com/english/wiki/saving-data-into-r-data-format-rds-and-rdata

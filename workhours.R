library(googlesheets4)
library(googledrive)
library(lubridate)
library(tidyverse)

drive_auth()
sheets_auth(token = drive_token())
drive_find("Strava")
workhours <- drive_get("Strava activity log")
worksheets <- read_sheet(workhours, col_names = F)
head(worksheets)
colnames(worksheets) <- c("date", "timestamp", "activity", "distance", "time", "seconds", "link.activity", "link.url")
head(worksheets)
        split <- list(datetime = stringr::str_split(worksheets$date_time, pattern = " "),
              mode = worksheets$type)
split

lubridate::as.duration()
hms("02:02PM")

worksheets %>% 
  ggplot(aes(activity, seconds)) +
  geom_jitter()

colnames(worksheets)

worksheets$minutes <- worksheets$seconds/60

worksheets %>% 
  ggplot(aes(activity, minutes)) +
  geom_jitter(aes(colour = )) +
  geom_boxplot()

dates <- str_split(worksheets$date, pattern = " ", simplify = T)
worksheets$month_year <- factor(paste0(dates[, 1], "_", dates[, 3]),
                                   levels = unique(worksheets$month_year))
unique(worksheets$month_year)

worksheets %>% 
  ggplot(aes(activity, minutes)) +
  geom_boxplot(position = "dodge", outlier.alpha = 0) +
  geom_jitter(aes(colour = month_year))




unique(worksheets$month_year)
table(worksheets$month_year)


library(dplyr)
library(stringr)
library(tidyverse)


spl_df <- read.csv("~/Desktop/2022-2023-All-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

spl_df <- spl_df %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))
spl_df$date <- as.Date(spl_df$date, format = "%Y-%m-%d")

author_df <- spl_df %>% 
  filter(str_detect(Creator,"George Orwell"))

checkouts_per_month_GO <- author_df %>% 
  filter(CheckoutMonth == '9')%>%
  summarize(total_checkouts_GO = sum(Checkouts, na.rm = T)) %>%
  pull(total_checkouts_GO)


book <- spl_df %>%
  filter(MaterialType == "BOOK") %>%
  summarize(total_checkouts_MT = max(Checkouts, na.rm = T)) %>%
  pull(total_checkouts_MT)


fiction <- spl_df %>%
  filter(Subjects == "Fiction") %>%
  summarize(total_fiction = max(Checkouts, na.rm = T)) %>%
  pull(total_fiction)



checkouts_per_year <- spl_df %>%
  filter(CheckoutYear == '2022') %>%
  summarize(total_checkouts_year = max(Checkouts, na.rm = T)) %>%
  pull(total_checkouts_year)


king_df <- spl_df %>% 
  filter(str_detect(Creator,"Stephen King"))

checkouts_per_month_SK <- king_df %>%
  filter(MaterialType == "EBOOK") %>%
  summarize(total_checkouts_SK = max(Checkouts, na.rm = T)) %>%
  pull(total_checkouts_SK)











library(dplyr)
library(stringr)


spl_df <- read.csv("~/Desktop/2022-2023-All-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

spl_df <- spl_df %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))
spl_df$date <- as.Date(spl_df$date, format = "%Y-%m-%d")

author_df <- spl_df %>% 
  filter(str_detect(Creator,"George Orwell"))

checkouts_per_month_GO <- author_df %>% 
  group_by(date) %>%
  summarize(total_checkouts = sum(Checkouts))

book <- spl_df %>%
  filter(MaterialType == "BOOK") %>%
  group_by(MaterialType) %>%
  summarize(total_checkouts = max(Checkouts, na.rm = T))

fiction <- spl_df %>%
  filter(Subjects == "Fiction") %>%
  group_by(date) %>%
  summarize(total_fiction = max(Checkouts, na.rm = T))

checkouts_per_year <- spl_df %>%
  group_by(CheckoutYear) %>%
  summarize(total_checkouts = sum(Checkouts))

king_df <- spl_df %>% 
  filter(str_detect(Creator,"Stephen King"))

checkouts_per_month_SK <- king_df %>%
  group_by(date) %>%
  summarize(total_checkouts = max(Checkouts))

max_checkouts <- checkouts_per_month_SK %>%
  filter(total_checkouts == max(total_checkouts))





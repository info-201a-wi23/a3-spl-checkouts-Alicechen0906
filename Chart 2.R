# Load libraries
library("dplyr")
library("stringr")
library("ggplot2")



# Exercise 1: Load the data
spl_df <- read.csv("~/Desktop/2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

spl_df <- spl_df %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))
spl_df$date <- as.Date(spl_df$date, format = "%Y-%m-%d")

book <- spl_df %>% filter(MaterialType == "BOOK")
ebook <- spl_df %>% filter(MaterialType == "EBOOK")
audiobook <- spl_df %>% filter(MaterialType == "AUDIOBOOK")

num_book <- book %>%
  group_by(date) %>%
  summarize(total_books = sum(Checkouts, na.rm = T))

num_ebook <- ebook %>%
  group_by(date) %>%
  summarize(total_ebooks = sum(Checkouts, na.rm = T))

num_audiobook <- audiobook %>%
  group_by(date) %>%
  summarize(total_audiobooks = sum(Checkouts, na.rm = T))


ggplot() +
  geom_line(data = num_book,
            mapping = aes(
              x = date,
              y= total_books,
              color = "BOOK")) +
  geom_line(data = num_ebook,
            mapping = aes(
              x = date,
              y = total_ebooks,
              color = "EBOOK")) +
  geom_line(data = num_audiobook,
            mapping = aes(
              x = date,
              y = total_audiobooks,
              color = "AUDIOBOOK")) +
  labs(title = "Different types of books trends in 2017-2023",
       x = "Date",
       y = "Total_checkouts",
       color = "MaterialType")



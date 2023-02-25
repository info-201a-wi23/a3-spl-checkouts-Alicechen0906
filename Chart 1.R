# Load libraries
library("dplyr")
library("stringr")
library("ggplot2")

# Exercise 1: Load the data
spl_df <- read.csv("~/Desktop/2013-2023-5-Checkouts-SPL.csv", stringsAsFactors = FALSE)

spl_df <- spl_df %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))
spl_df$date <- as.Date(spl_df$date, format = "%Y-%m-%d")

gatsby <- spl_df %>% 
  filter(str_detect(Title, "The Great Gatsby"))

lord_rings <- spl_df %>%
  filter(str_detect(Title, "The Lord of the Rings"))

gatsby_checkouts <- gatsby %>%
  group_by(date) %>%
  summarize(total_gatsby_checkouts = sum(Checkouts, na.rm = T))

lord_rings_checkouts <- lord_rings %>%
  group_by(date) %>%
  summarize(total_lord_rings_checkouts = sum(Checkouts, na.rom = T))

new_chart <- left_join(lord_rings_checkouts, gatsby_checkouts)

ggplot() +
  geom_line(data = lord_rings_checkouts,
    mapping = aes(
          x = date, 
          y = total_lord_rings_checkouts,
      color = "The Lord of the Rings")) +
  geom_line(data = gatsby_checkouts,
      mapping = aes(
            x = date,
            y = total_gatsby_checkouts,
        color = "The Great Gatsby")) +
  scale_color_brewer(palette = "Set1") +
  labs(title = "Total checkouts for Two books 2013-2023", 
       x = "Date", 
       y = "Total_checkouts",
   color = "Book Name")


# Load libraries
library("dplyr")
library("stringr")
library("ggplot2")


# Exercise 1: Load the data
spl_df <- read.csv("~/Desktop/2022-2023-All-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

spl_df <- spl_df %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))
spl_df$date <- as.Date(spl_df$date, format = "%Y-%m-%d")


subject_chart <- spl_df %>% filter(Subjects %in% c("Comedy", "Fiction", "Fantasy"))

num_checkouts <- subject_chart %>%
  group_by(Subjects) %>%
  summarize(total_checkouts = sum(Checkouts, na.rm = T))


ggplot(num_checkouts) +
  geom_col(mapping = aes(
    x = Subjects,
    y = total_checkouts,
    fill = Subjects)) +
    labs(title = "Total checkouts in different genre 2022-2023", 
              x = "Subjects", 
              y = "Total_checkouts",
          color = "Subjects") 
  
  


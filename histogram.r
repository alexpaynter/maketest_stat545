library(readr)
library(here)
library(dplyr)
library(janitor)

words <- readLines(here('words.txt'))

out_tab <- tibble(
	Length = nchar(words)
) %>%
	janitor::tabyl(Length) %>%
	select(Length, Freq = n)

write.table(out_tab, file = "histogram.tsv", sep = "\t")


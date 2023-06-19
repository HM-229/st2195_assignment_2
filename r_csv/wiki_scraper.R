library("rvest")
library("dplyr")

## page setup for rvest
link <- "https://en.wikipedia.org/wiki/Comma-separated_values"
page <- read_html(link)


## scraping data / parsing data to vectors 
col_names <- html_element(page, ".wikitable > tbody:nth-child(1) > tr:nth-child(1)") %>% html_text2() %>% strsplit("\t") %>% unlist()
row_1 <- html_element(page, ".wikitable > tbody:nth-child(1) > tr:nth-child(2)") %>% html_text2()  %>% strsplit("\t") %>% unlist()
row_2 <- html_element(page, ".wikitable > tbody:nth-child(1) > tr:nth-child(3)") %>% html_text2() %>% strsplit("\t") %>% unlist()
row_3 <- html_element(page, ".wikitable > tbody:nth-child(1) > tr:nth-child(4)") %>% html_text2() %>% strsplit("\t") %>% unlist()
row_4 <- html_element(page, ".wikitable > tbody:nth-child(1) > tr:nth-child(5)") %>% html_text2() %>% strsplit("\t") %>% unlist()

## creating matrix
data_matrix <- matrix(c(row_1,row_2,row_3,row_4), byrow=TRUE, nrow = 4)
colnames(data_matrix) <- col_names
data_matrix

##to csv
write.csv(data_matrix, file = "R_csv.csv", row.names = TRUE)


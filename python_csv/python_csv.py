from bs4 import BeautifulSoup as soup
import requests
import pandas as pd 


## setting up bs4
url = "https://en.wikipedia.org/wiki/Comma-separated_values"
html = requests.get(url)
raw_data = soup(html.content, "html.parser")


## function asking for bs4 response // appends the text of each html tag to a list determined by dataname 
def scrapeData(colnr, dataname):
    css_selector = ".wikitable > tbody:nth-child(1) > tr:nth-child(%d)" %colnr
    data = soup.select(raw_data, str(css_selector))
    for i in data:
        dt = i.text.split("\n")
        for x in dt: 
            dataname.append(x)
    dataname.pop(0)
    dataname.pop(len(dataname)-1)



##scraping data with the functiond and appending the objects to a list for each column
colnames = []
scrapeData(1, colnames)

row_1 = []
scrapeData(2, row_1)

row_2 = []
scrapeData(3, row_2)

row_3 = []
scrapeData(4, row_3)

row_4 = []
scrapeData(5, row_4)


## creating matrix
csv_data = [row_1, row_2, row_3, row_4]

## matrix to Dataframe
df = pd.DataFrame(csv_data, columns=colnames)

## converting to csv
df.to_csv("python_csv.csv", index=False)


# test for package existance and install
if (!is.element("tidyverse", installed.packages())) 
  install.packages("tidyverse", dep = T)
library(tidyverse)
# Reads in CSV files as tibbles
cl <- as_tibble(read.csv("dh_causal_lookup.csv")) 
pl <- as_tibble(read.csv("dh_product_lookup.csv")) 
sl <- as_tibble(read.csv("dh_store_lookup.csv")) 
tr <- as_tibble(read.csv("dh_transactions.csv"))

# Joins the product to their transactions.
table <- left_join(pl, tr, by ="upc") 

# Filters transations for ONLY pasta and creates a new data frame.
table %>%
  filter(commodity=="pasta") -> commodity 

# Filters transations for ONLY PRIVATE LABEL THIN SPAGHETTI and creates a new data frame.
table %>%
  filter(product_description =="PRIVATE LABEL THIN SPAGHETTI") -> product

#Counts the length of unique households who purchased pasta.
n.commod <- length(unique(commodity$household))

#Counts the length of unique households who purchased PRIVATE LABEL THIN SPAGHETTI.
n.product <- length(unique(product$household))

#Divides the length of households who purchased PRIVATE LABEL THIN SPAGHETTI vs those who purchased
#pasta multiplied by 100 to give the household penetration of the product pasta. 
n.product/n.commod *100/1 -> household.penetration 

# Filters transations for pasta in region 1 and creates a new data frame.
commodity%>%
  filter(geography=="1")-> comreg1

#Counts the length of unique households who purchased pasta in region 1.
n.comreg1 <- length(unique(comreg1$household))

# Filters transations for pasta in region 2 and creates a new data frame.
commodity%>%
  filter(geography=="2")-> comreg2

#Counts the length of unique households who purchased pasta in region 2.
n.comreg2 <- length(unique(comreg2$household))

# Filters transations for PRIVATE LABEL THIN SPAGHETTI in region 1 and creates a new data frame.
product%>%
  filter(geography=="1")-> proreg1
 
#Counts the length of unique households who purchased PRIVATE LABEL THIN SPAGHETTI in region 1. 
n.proreg1 <- length(unique(proreg1$household))

# Filters transations for PRIVATE LABEL THIN SPAGHETTI in region 2 and creates a new data frame.
product%>%
  filter(geography=="2")-> proreg2

#Counts the length of unique households who purchased PRIVATE LABEL THIN SPAGHETTI in region 2.   
n.proreg2 <- length(unique(proreg2$household))

#Divides the length of households who purchased PRIVATE LABEL THIN SPAGHETTI vs those who purchased
#pasta multiplied by 100 to give the household penetration of the product pasta for region 1
#region2
n.proreg1/n.comreg1 *100 -> household.penetration.for.region.1
n.proreg2/n.comreg2 *100 -> household.penetration.for.region.2




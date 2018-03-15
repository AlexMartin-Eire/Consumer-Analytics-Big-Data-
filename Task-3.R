# test for package existance and install
if (!is.element("tidyverse", installed.packages())) 
  install.packages("tidyverse", dep = T)
library(tidyverse)

cl <- as_tibble(read.csv("dh_causal_lookup.csv")) 
pl <- as_tibble(read.csv("dh_product_lookup.csv")) 
sl <- as_tibble(read.csv("dh_store_lookup.csv")) 
tr <- as_tibble(read.csv("dh_transactions.csv"))

tr %>% left_join(pl) %>% filter(coupon == 1) %>% filter(commodity == "pasta") -> r1 # Purchased pasta with a coupon.

h <- unique(r1$household) # Each household, h is the same as x. 

tr %>% left_join(pl) %>% filter(commodity == "pasta") -> r2

# All household transactions involving a coupon and the purchasing of pasta
filter(r2, !is.na(match(r2$household,  h))) -> tmp

h2<-list() # Empty list
for (i in h) {
  tmp %>% filter(household == i) %>% arrange(day, -coupon) -> temp1 
if(temp1$coupon[1] == 1 & nrow(temp1) >1) {h2[length(h2)+1]<-i} }


length(h2) # Printed list containing (number) each household



#3009 for pasta.
#7378 pasta sauce
#3726 syrups
#1112 pancake mixes


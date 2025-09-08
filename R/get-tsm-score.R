library(tidyverse)
library(ggplot2)

rm(list=ls())

## load stocks list
stkList <- read.table("data/risk/stocks_list.txt", header=T, sep="\t")
    
## ----------------------------
##        *** TSM ***
## ----------------------------

## define time horizon and scenario
yrsPrj <- 2021:2059
rcpi <- "rcp45"

# calculate rank percentile of the TSM in the year 20XX
stkVec <- stkList %>%
    filter(!(species %in% c("fbm","fpe","fpi","fpp"))) %>% # ***TO BE FIXED WITH ALTERNATIVE TO AQUAMAP
    .$stock %>% as.character()
TSM <- NULL
for(i in yrsPrj){
 TSMtmp <- data.frame(stock=stkVec, tsm=NA)
 for(ii in 1:length(stkVec)){
     tmp <- read.table(paste0("data/risk/", rcpi,"/tsm_",stkVec[ii],".txt"), header=T) %>%
         filter(year %in% i)
     TSMtmp[ii,"tsm"] <- tmp$md
 }
 TSM <- TSMtmp %>%
     mutate(year = i) %>%
     bind_rows(TSM)
}

## calculate the percentile rank of the TSM
## (NB. this is over the time horizon 2021-2059, you may want
##      a single year or average over a short period in the near future)
TSM.rank.perc <- TSM %>%
    ungroup() %>%
    mutate(tsm.score = 1-percent_rank(tsm))

## calculate the range only for the purposes of summarising info in table A6.2
TSM.rank.perc %>%
    group_by(stock) %>%
    summarise(tsm.lw=round(min(tsm.score),2),
              tsm.up=round(max(tsm.score),2))

# New calculations for Håkan
#TSM |> distinct(year)
TSM |> distinct(stock)
raw_percent_tsm <- TSM |> 
  filter(year >= 2026 & year <= 2050) |> 
  summarise(median_tsm = median(tsm), .by = "stock") |> 
  mutate(tsm.score = 1-percent_rank(median_tsm))

write_csv(raw_percent_tsm, "output/2025/risk/raw_percent_tsm.csv")

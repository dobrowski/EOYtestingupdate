

library(readxl)
library(tidyverse)
library(here)




caaspp.file <- "CAASPP_Student_Completion_Status_Summary_Report_00000000000000_20230515163315.xlsx"

elpac.file <- "ELPAC Tests to be completed May 11.xlsx"



caaspp.ela <- read_xlsx(here("data",caaspp.file),
                         sheet = "SB ELA")


caaspp.math <- read_xlsx(here("data",caaspp.file),
                        sheet = "SB Math")


caaspp.cast <- read_xlsx(here("data",caaspp.file),
                        sheet = "CAST")


caaspp.caa.ela <- read_xlsx(here("data",caaspp.file),
                        sheet = "CAA ELA")


caaspp.caa.math <- read_xlsx(here("data",caaspp.file),
                        sheet = "CAA Math")


caaspp.caa.science <- read_xlsx(here("data",caaspp.file),
                        sheet = "CAA Science")

###



elpac.init.alt <- read_xlsx(here("data",elpac.file),
                        sheet = "Initial Alternate May 11")



elpac.sum.alt <- read_xlsx(here("data",elpac.file),
                            sheet = "Summative Alternate May 11")



elpac.init <- read_xlsx(here("data",elpac.file),
                            sheet = "Initial ELPAC May 11")



elpac.sum <- read_xlsx(here("data",elpac.file),
                            sheet = "Summative ELPAC May 11")

# caaspp <- caaspp.ela %>% full_join(caaspp.math)


complete <-  reduce(list(caaspp.caa.ela,
                       caaspp.caa.math,
                       caaspp.caa.science, 
                       caaspp.cast, 
                       caaspp.ela, 
                       caaspp.math,
                   #    elpac.init,
                   #    elpac.init.alt,
                       elpac.sum,
                       elpac.sum.alt),
       full_join, join_by(`RAN#`, `Organization Name`,
                          `Organization CDS code`))


mry.status <- complete %>%
    filter( str_starts(`Organization CDS code` , "27")) %>%
    select(starts_with("Org"), starts_with("%"))

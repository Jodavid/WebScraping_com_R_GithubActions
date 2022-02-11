
# Lendo as funções necessárias
source("src/WebScraping.R")

# Chamando as bibliotecas
library(rvest)
library(stringr)

url <- "https://jarbas.serenata.ai/dashboard/chamber_of_deputies/reimbursement/"
Webpage <- rvest::read_html(url)

Nomes <- WebScraping(Webpage, ".field-congressperson_name")
Subquota <- WebScraping(Webpage, ".field-subquota_translated")
Fornecedor <- WebScraping(Webpage, ".field-supplier_info")
ValoresReal <- WebScraping(Webpage, ".field-value")

ValoresReal <- ConveterStrparaNumerico(ValoresReal)

df <- data.frame(
  Name = Nomes,
  Subquota = Subquota,
  Provider = Fornecedor,
  Value = ValoresReal
)


write.csv2(df,paste0('data/',format(Sys.time(),"%d_%m_%Y_%H_%M"),'_scraping','.csv'), row.names=F)    
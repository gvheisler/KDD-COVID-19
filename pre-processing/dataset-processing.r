ds <- read.csv2("data.csv")
#ds <- read.csv2(url("https://ti.saude.rs.gov.br/covid19/download"))

ds$DATA_CONFIRMACAO <- as.Date(ds$DATA_CONFIRMACAO, format = "%d/%m/%Y")

ds <- ds[which(ds$DATA_CONFIRMACAO<=as.Date("31/12/2022", format = "%d/%m/%Y")),]

write.csv2(ds, "data.csv")

obitos <- nrow(ds[which(ds$EVOLUCAO=="OBITO"),])
recuperados <- nrow(ds[which(ds$EVOLUCAO=="RECUPERADO"),])

total <- obitos + recuperados

p_recuperados <- (recuperados*100)/total
p_obitos <- (obitos*100)/total

p_total <- p_recuperados + p_obitos

p_total

ds <- read.csv2("data.csv")
#ds <- read.csv2(url("https://ti.saude.rs.gov.br/covid19/download"))

ds$DATA_CONFIRMACAO <- as.Date(ds$DATA_CONFIRMACAO, format = "%d/%m/%Y")

ds <- ds[which(ds$DATA_CONFIRMACAO<=as.Date("31/12/2022", format = "%d/%m/%Y")),]


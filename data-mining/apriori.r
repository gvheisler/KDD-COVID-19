library(arules)

ds <- read.csv2(file.choose())
#ds <- read.csv2(url("https://ti.saude.rs.gov.br/covid19/download"))

ds <- ds[,c(13, 16:20)]
ds <- ds[-which(ds$EVOLUCAO!='OBITO'),]

colnames(ds) <- c("EVOLUTION", 'FEVER', "SHORTNESS OF BREATH", "SORE THROAT", "COUGHING")

for (i in 1:ncol(ds)) {
  ds[,i] <- as.factor(ds[,i])
}

regras <- apriori(data = ds, parameter = list(conf = 0.05, supp = 0.05), target = 'rules', minlen = 2, maxlen = 2)
regras <- subset(regras, rhs %in% 'EVOLUTION=OBITO')
regras <- sort(regras, by = 'support', decreasing = TRUE)
inspect(regras)

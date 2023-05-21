library(arules)

ds <- read.csv2(file.choose())
#ds <- read.csv2(url("https://ti.saude.rs.gov.br/covid19/download"))

ds <- ds[,c(13, 16:20)]
ds <- ds[-which(ds$EVOLUCAO!='OBITO'),]

colnames(ds) <- c("DEVELOPMENT", "COUGHING", "FEVER", "SORE THROAT", "SHORTNESS OF BREATH", "OTHER")

for(i in 2:ncol(ds)){
  ds[,i]<-ifelse(ds[,i]=="SIM","YES","NO")
}

ds$DEVELOPMENT <- ifelse(ds$DEVELOPMENT=="OBITO","DEATH","")

for (i in 1:ncol(ds)) {
  ds[,i] <- as.factor(ds[,i])
}

regras <- apriori(data = ds, parameter = list(conf = 0.05, supp = 0.05), target = 'rules', minlen = 2, maxlen = 2)
regras <- subset(regras, rhs %in% 'DEVELOPMENT=DEATH')
regras <- sort(regras, by = 'support', decreasing = TRUE)
inspect(regras)

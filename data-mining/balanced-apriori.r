library(rpart)
library(rpart.plot)

ds <- read.csv2("data.csv")
#ds <- read.csv2(url("https://ti.saude.rs.gov.br/covid19/download"))

ds <- ds[,c(13, 16:20)]
ds <- ds[-which(ds$EVOLUCAO!='OBITO'&ds$EVOLUCAO!='RECUPERADO'),]

colnames(ds) <- c("DEVELOPMENT", "COUGHING", "FEVER", "SORE THROAT", "SHORTNESS OF BREATH", "OTHER")

for(i in 2:ncol(ds)){
  ds[,i]<-ifelse(ds[,i]=="SIM","YES","NO")
}

ds$DEVELOPMENT <- ifelse(ds$DEVELOPMENT=="OBITO","DEATH","RECUPERATED")

ds_deaths <- ds[which(ds$DEVELOPMENT=='DEATH'),]

ds_rec <- ds[which(ds$DEVELOPMENT=='RECUPERATED'),]
ds_rec <- ds_rec[sample(nrow(ds_deaths)),]

ds <- rbind(ds_rec, ds_deaths)

for (i in 1:ncol(ds)) {
  ds[,i] <- as.factor(ds[,i])
}


supports <- c(1.0,0.9,0.8,0.7,0.6,0.5,0.4,0.3,0.2,0.1);


supports = c(0.2)
for(sup in supports){
  regras <- apriori(data = ds, parameter = list(conf = 0.8, supp = sup), control = list(verbose = TRUE), target = 'rules', minlen = 2, maxlen = 10)
  regras <- subset(regras, rhs %in% 'DEVELOPMENT=DEATH')
  regras <- sort(regras, by = 'confidence', decreasing = TRUE)
  inspect(regras)
}

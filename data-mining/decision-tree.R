library(rpart)
library(rpart.plot)

ds <- read.csv2("data.csv")
#ds <- read.csv2(url("https://ti.saude.rs.gov.br/covid19/download"))

ds <- ds[,c(13, 16:20)]
ds <- ds[-which(ds$EVOLUCAO!='OBITO'&ds$EVOLUCAO!='RECUPERADO'),]

#colnames(ds) <- c("DEVELOPMENT", "COUGHING", "FEVER", "SORE THROAT", "SHORTNESS OF BREATH", "OTHER")

#for(i in 2:ncol(ds)){
#  ds[,i]<-ifelse(ds[,i]=="SIM","YES","NO")
#}

#ds$DEVELOPMENT <- ifelse(ds$DEVELOPMENT=="OBITO","DEATH","RECUPERATED")

ds_deaths <- ds[which(ds$EVOLUCAO=='OBITO'),]

ds_rec <- ds[which(ds$EVOLUCAO=='RECUPERADO'),]
ds_rec <- ds_rec[sample(nrow(ds_deaths)),]

ds <- rbind(ds_rec, ds_deaths)

for (i in 1:ncol(ds)) {
  ds[,i] <- as.factor(ds[,i])
}

ds <- ds[,-5]

tree <- rpart(formula = EVOLUCAO ~ ., data = ds, method = "class", cp = 0.0001)

rpart.plot(tree, type = 3, clip.right.labs = FALSE, under = FALSE)

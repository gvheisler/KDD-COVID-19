ds <- read.csv2(file.choose())
#ds <- read.csv2(url("https://ti.saude.rs.gov.br/covid19/download"))

ds$DATA_CONFIRMACAO <- as.Date(ds$DATA_CONFIRMACAO, format = "%d/%m/%Y")

ds <- ds[which(ds$DATA_CONFIRMACAO<=as.Date("31/12/2022", format = "%d/%m/%Y")),]


total_days <- seq(as.Date(min(ds$DATA_CONFIRMACAO)), as.Date(max(ds$DATA_CONFIRMACAO)), by = 'days')


# Daily cases plot

ds_dailyCases <- ds[,c(9, 13)]

dailyCases <- data.frame(matrix(nrow = length(total_days), ncol = 2))
colnames(dailyCases) <- c('day', 'cases')
dailyCases$day <- total_days

for (i in 1:nrow(dailyCases)) {
  dfAux <- ds[which(ds_dailyCases$DATA_CONFIRMACAO==dailyCases[i,1]),]
  dailyCases[i,2] <- nrow(dfAux)
}

plot(x = dailyCases$day, y = dailyCases$cases, type = 'l',
     xlab = 'Day', ylab = 'Cases', 
     main = "Cases of COVID-19 confirmed by day")


# daily deaths plot

ds_dailyDeaths <- ds[,c(12, 13)]
ds_dailyDeaths <- ds_dailyDeaths[-which(ds_dailyDeaths$EVOLUCAO!="OBITO"),]
ds_dailyDeaths$DATA_EVOLUCAO <- as.Date(ds_dailyDeaths$DATA_EVOLUCAO, format = "%d/%m/%Y")
ds_dailyDeaths <- ds_dailyDeaths[which(ds_dailyDeaths$DATA_EVOLUCAO<=as.Date("31/12/2022", format = "%d/%m/%Y")),]

dailyDeaths <- data.frame(matrix(nrow = length(total_days), ncol = 2))
colnames(dailyDeaths) <- c('day', 'deaths')
dailyDeaths$day <- total_days



for (i in 1:nrow(dailyDeaths)) {
  dfAux <- ds[which(ds_dailyDeaths$DATA_EVOLUCAO==dailyDeaths[i,1]),]
  dailyDeaths[i,2] <- nrow(dfAux)
}

plot(x = dailyDeaths$day, y = dailyDeaths$deaths, type = 'l', col = 'red',
     xlab = 'Day', ylab = 'Deaths', 
     main = "Deaths by COVID-19 by day")


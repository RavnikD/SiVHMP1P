library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/266ffcdd-bcfe-40e2-a8d9-f738ac820aa5", "Podaci/h-H1.xlsx", mode = "wb")

#' Tablica H1 Platna bilanca - svodna tablica (EUR)
#'
#' @name H1
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export


# UCITAVANJE PRVE TABLICE
H1a <- read.xlsx(file = "Podaci/h-H1.xlsx", 1,
                 startRow = 6, endRow = 39, as.data.frame = TRUE, header = FALSE)

#Micanje redaka koji su u potpunosti NA
H1a <- H1a[, colSums(is.na(H1a)) != nrow(H1a)]

#Transponiranje tablice
H1a <- as.data.frame(t(H1a))

#Davanje imena header-ima
colnames(H1a) <- c("Datum",
                   "TEKUCE.TRANSAKCIJE",
                   "Roba.usluge.i.primarni.dohodak",
                   "RUPD.Prihodi",
                   "RUPD.Rashodi",
                   "Roba.i.usluge",
                   "RU.Prihodi",
                   "RU.Rashodi",
                   "Roba",
                   "R.Prihodi",
                   "R.Rashodi",
                   "Usluge",
                   "U.Prihodi",
                   "U.Rashodi",
                   "Primarni.dohodak",
                   "PD.Prihodi",
                   "PD.Rashodi",
                   "Sekundarni.dohodak",
                   "SD.Prihodi",
                   "SD.Rashodi",
                   "KAPITALNE.TRANSAKCIJE",
                   "FINANCIJSKE.TRANSAKCIJE",
                   "Izravna.ulaganja",
                   "IU.Imovina",
                   "IU.Obveze",
                   "Portfeljna.ulaganja",
                   "PU.Imovina",
                   "PU.Obveze",
                   "Financijske.izvedenice",
                   "Ostala.ulaganja",
                   "OU.Imovina",
                   "OU.Obveze",
                   "Medunarodne.pricuve.",
                   "NETO.POGRESKE.I.PROPUSTI")

#Brisanje 1.redka
H1a <- H1a[-1,]

#Micanje space-a
H1a$Datum <- trimws(H1a$Datum)

#Micanje tocke na kraju datuma
H1a$Datum <- substr(H1a$Datum, 1, nchar(H1a$Datum)-1)

#Sredivanje stupca Datum
for(i in c(82:88)){
  H1a$Datum[i] <- as.character(paste0("20",substr(H1a$Datum[i], 6, 7),"-","04","-","0",substr(H1a$Datum[i],1,1)))
}

for(i in c(18:81)){
  H1a$Datum[i] <- as.character(paste0("20",substr(H1a$Datum[i], 6, 7),"-","04","-","0",substr(H1a$Datum[i],1,1)))
}

H1a$Datum[65] <- as.character("2011-04-04")

H1a$Datum[17] <- as.character("2016")

#Factor -> char -> numeric
H1a[] <- lapply(H1a, as.character)
for(i in c(2:ncol(H1a))){
  H1a[i] <- as.numeric(unlist(H1a[i]))
}

#' Tablica H1 Platna bilanca - svodna tablica (USD)
#'

# UCITAVANJE DRUGE TABLICE
H1b <- read.xlsx(file = "Podaci/h-H1.xlsx", 2,
                 startRow = 6, endRow = 39, as.data.frame = TRUE, header = FALSE)

#Micanje redaka koji su u potpunosti NA
H1b <- H1b[, colSums(is.na(H1b)) != nrow(H1b)]

#Transponiranje tablice
H1b <- as.data.frame(t(H1b))

#Davanje imena header-ima
colnames(H1b) <- c("Datum",
                   "TEKUCE.TRANSAKCIJE",
                   "Roba.usluge.i.primarni.dohodak",
                   "RUPD.Prihodi",
                   "RUPD.Rashodi",
                   "Roba.i.usluge",
                   "RU.Prihodi",
                   "RU.Rashodi",
                   "Roba",
                   "R.Prihodi",
                   "R.Rashodi",
                   "Usluge",
                   "U.Prihodi",
                   "U.Rashodi",
                   "Primarni.dohodak",
                   "PD.Prihodi",
                   "PD.Rashodi",
                   "Sekundarni.dohodak",
                   "SD.Prihodi",
                   "SD.Rashodi",
                   "KAPITALNE.TRANSAKCIJE",
                   "FINANCIJSKE.TRANSAKCIJE",
                   "Izravna.ulaganja",
                   "IU.Imovina",
                   "IU.Obveze",
                   "Portfeljna.ulaganja",
                   "PU.Imovina",
                   "PU.Obveze",
                   "Financijske.izvedenice",
                   "Ostala.ulaganja",
                   "OU.Imovina",
                   "OU.Obveze",
                   "Medunarodne.pricuve.",
                   "NETO.POGRESKE.I.PROPUSTI")

#Brisanje 1.redka
H1b <- H1b[-1,]

#Micanje space-a
H1b$Datum <- trimws(H1b$Datum)

#Micanje tocke na kraju datuma
H1b$Datum <- substr(H1b$Datum, 1, nchar(H1b$Datum)-1)

#Sredivanje stupca Datum
for(i in c(82:88)){
  H1b$Datum[i] <- as.character(paste0("20",substr(H1b$Datum[i], 6, 7),"-","04","-","0",substr(H1b$Datum[i],1,1)))
}

for(i in c(18:81)){
  H1b$Datum[i] <- as.character(paste0("20",substr(H1b$Datum[i], 6, 7),"-","04","-","0",substr(H1b$Datum[i],1,1)))
}

H1b$Datum[65] <- as.character("2011-04-04")

H1b$Datum[17] <- as.character("2016")

#Factor -> char -> numeric
H1b[] <- lapply(H1b, as.character)
for(i in c(2:ncol(H1b))){
  H1b[i] <- as.numeric(unlist(H1b[i]))
}

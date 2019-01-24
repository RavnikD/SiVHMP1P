library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/fe6ad2e2-c2cb-4fb0-854a-0cbbf2794a8e", "Podaci/h-H6.xlsx", mode = "wb")

#' Tablica H6 Platna bilanca - svodna tablica (HRK)
#'
#' @name H6
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export


# UCITAVANJE PRVE TABLICE
H6 <- read.xlsx(file = "Podaci/h-H6.xlsx", 1,
                startRow = 6, endRow = 39, as.data.frame = TRUE, header = FALSE)

#Micanje redaka koji su u potpunosti NA
H6 <- H6[, colSums(is.na(H6)) != nrow(H6)]

#Transponiranje tablice
H6 <- as.data.frame(t(H6))

#Davanje imena header-ima
colnames(H6) <- c("Datum",
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
H6 <- H6[-1,]

#Micanje space-a
H6$Datum <- trimws(H6$Datum)

#Micanje tocke na kraju datuma
H6$Datum <- substr(H6$Datum, 1, nchar(H6$Datum)-1)

#Sredivanje stupca Datum
for(i in c(82:88)){
  H6$Datum[i] <- as.character(paste0("20",substr(H6$Datum[i], 6, 7),"-","04","-","0",substr(H6$Datum[i],1,1)))
}

for(i in c(18:81)){
  H6$Datum[i] <- as.character(paste0("20",substr(H6$Datum[i], 6, 7),"-","04","-","0",substr(H6$Datum[i],1,1)))
}

H6$Datum[65] <- as.character("2011-04-04")

H6$Datum[17] <- as.character("2016")

#Factor -> char -> numeric
H6[] <- lapply(H6, as.character)
for(i in c(2:ncol(H6))){
  H6[i] <- as.numeric(unlist(H6[i]))
}

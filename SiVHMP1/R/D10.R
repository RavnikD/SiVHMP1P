library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/9b11412d-f8d9-4923-910a-9120e1b09dd3", "Podaci/h-D10.xls", mode = "wb")

#' Tablica D10 Inozmena pasiva DMFI
#
#' @name D10
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export

# UCITAVANJE GODISNJE TABLICE
D10 <- read.xlsx(file = "Podaci/h-D10.xls", 1,
                 startRow = 6, endRow = 40, as.data.frame = TRUE, header = FALSE)

#Micanje redaka koji su u potpunosti NA
D10 <- D10[, colSums(is.na(D10)) != nrow(D10)]

#Transponiranje tablice
D10<- as.data.frame(t(D10))


#Davanje imena header-ima
colnames(D10) <- c("Datum",
                   "1.0.0.Devizna.inozemna.pasiva",
                   "1.1.0.Obveze.prema.stranim.financijskim.institucijama",
                   "1.1.1.Od.toga.uz.valutnu.klauzulu",
                   "1.1.2.Podredeni.i.hibridni.instrumenti",
                   "1.1.3.Depozitni.novac",
                   "1.1.4.Oroceni.depoziti.i.depoziti.s.otkaznim.rokom",
                   "1.1.5.Krediti",
                   "1.1.6.Obveznice",
                   "1.1.7.Udjeli.novcanih.fondova",
                   "1.2.0.Obveze.prema.stranim.nefinancijskim.institucijama",
                   "1.2.1.Od.toga.uz.valutnu.klauzulu",
                   "1.2.2.Podredeni.i.hibridni.instrumenti",
                   "1.2.3.stedni.i.oroceni.depoziti",
                   "1.2.4.stedni.depoziti.",
                   "1.2.5.Oroceni.depoziti.i.depoziti.s.otkaznim.rokom",
                   "1.2.6.Krediti",
                   "1.2.7.Obveznice",
                   "1.2.8.Udjeli.novcanih.fondova",
                   "2.0.0.Kunska.inozemna.pasiva",
                   "2.1.0.Obveze.prema.stranim.financijskim.institucijama",
                   "2.1.1.Podredeni.i.hibridni.instrumenti",
                   "2.1.2.Depozitni.novac",
                   "2.1.3.Oroceni.depoziti.i.depoziti.s.otkaznim.rokom",
                   "2.1.4.Krediti",
                   "2.1.5.Obveznice",
                   "2.1.6.Udjeli.novcanih.fondova",
                   "2.2.0.Obveze.prema.stranim.nefinancijskim.institucijama",
                   "2.2.1.Podredeni.i.hibridni.instrumenti",
                   "2.2.2.Depozitni.novac",
                   "2.2.3.Oroceni.depoziti.i.depoziti.s.otkaznim.rokom",
                   "2.2.4.Krediti",
                   "2.2.5.Obveznice",
                   "2.2.6.Udjeli.novcanih.fondova",
                   "Ukupno")


#Brisanje 1.redka
D10 <- D10[-1,]

#Factor -> char -> numeric
D10[] <- lapply(D10, as.character)
for(i in c(2:ncol(D10))){
  D10[i] <- as.numeric(unlist(D10[i]))
}


#Sredivanje stupca Datum
for(i in c(1:nrow(D10))){
  if(substr(D10$Datum[i], 4, 5) > 90){
    g <- substr(D10$Datum[i], 4, 5)
    m <- substr(D10$Datum[i], 1, 2)
    D10$Datum[i] <- as.character(paste0("19", g, "-", m))
  } else {
    g <- substr(D10$Datum[i], 4, 5)
    m <- substr(D10$Datum[i], 1, 2)
    D10$Datum[i] <- as.character(paste0("20", g, "-", m))
  }
}



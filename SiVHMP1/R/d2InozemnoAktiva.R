library(xlsx)

dir.create("Podaci")
##Skidanjepodataka
download.file("http://www.hnb.hr/documents/20182/9905edf0-2b1a-44e6-8f95-bd898094ef0d", "Podaci/h-InozemnaAktiva.xlsx", mode = "wb")

# Tablica D2 Inozemna Aktiva
#
#' @name D2
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export
InozemnaAktiva <- read.xlsx(file = "Podaci/h-InozemnaAktiva.xlsx", 1,
                startRow = 6, endRow = 25, as.data.frame = TRUE, header = FALSE)


InozemnaAktiva <- InozemnaAktiva[, colSums(is.na(InozemnaAktiva)) != nrow(InozemnaAktiva)]

##Transponiranje tablice
InozemnaAktiva <- as.data.frame(t(InozemnaAktiva))

##Imenovanje redaka
colnames(InozemnaAktiva) <- c("Datum",
                  "Devizna.inozemna.aktiva",
                  "Potrazivanja.od.stranih.financijskih.institucija",
                  "Efektivni.strani.novac",
                  "Tekuci.racuni",
                  "Oroceni.depoziti.i.depoziti.s.otkaznim.rokom",
                  "Vrijednosni.papiri",
                  "Krediti",
                  "Dionice.stranih.financijskih.institucija",
                  "Potrazivanja.od.stranih.nefinancijskih.institucija",
                  "Potrazivanja.od.stranih.drzava",
                  "Potrazivanja.od.stranih.osoba",
                  "Vrijednosni.papiri",
                  "Krediti",
                  "Dionice.stranih.osoba",
                  "Kunska.inozemna.aktiva",
                  "Potrazivanja.od.stranih.financijskih.institucija",
                  "Potrazivanja.od.stranaca",
                  "Od.toga.Krediti",
                  "Ukupno")

##Brisanje vi?ka
InozemnaAktiva <- InozemnaAktiva[-1,]

##Pretvaranje iz Factor -> char -> numeric
InozemnaAktiva[] <- lapply(InozemnaAktiva, as.character)
for(i in c(2:ncol(InozemnaAktiva))){
  InozemnaAktiva[i] <- as.numeric(unlist(InozemnaAktiva[i]))
}

##Sredivanje Datuma
for(i in c(1:nrow(InozemnaAktiva))){
  if(substr(InozemnaAktiva$Datum[i], 4, 5) > 90){
    g <- substr(InozemnaAktiva$Datum[i], 4, 5)
    m <- substr(InozemnaAktiva$Datum[i], 1, 2)
    InozemnaAktiva$Datum[i] <- as.character(paste0("19", g, "-", m))
  } else {
    g <- substr(InozemnaAktiva$Datum[i], 4, 5)
    m <- substr(InozemnaAktiva$Datum[i], 1, 2)
    InozemnaAktiva$Datum[i] <- as.character(paste0("20", g, "-", m))
  }
}

InozemnaAktiva1 <- InozemnaAktiva[-c(10:19)]
InozemnaAktiva2 <- InozemnaAktiva[-c(2:9)]
InozemnaAktiva2 <- InozemnaAktiva2[-c(8:11)]
InozemnaAktiva3 <- InozemnaAktiva[-c(2:15)]

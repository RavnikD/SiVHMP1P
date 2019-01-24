library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/347541f4-7f60-49f4-bd28-8a0567c417cd", "Podaci/h-D8.xls", mode = "wb")

#' Tablica D8 Devizni depoziti kod DMFI
#
#' @name D8
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export
# Ucitavanje godisnje tablice
D8 <- read.xlsx(file = "Podaci/h-D8.xls", 1,
                startRow = 6, endRow = 36, as.data.frame = TRUE, header = FALSE)

#Micanje redaka koji su u potpunosti NA
D8 <- D8[, colSums(is.na(D8)) != nrow(D8)]

#Transponiranje tablice
D8 <- as.data.frame(t(D8))

#Davanje imena header-ima
colnames(D8) <- c("Datum",
                  "1.0.0.stedni.depoziti",
                  "1.1.Lokalna.drzava",
                  "1.2.Nefinancijska.drustva",
                  "1.3.Kucanstva",
                  "1.4.Ostale.bankarske.institucije",
                  "1.5.Nebankarske.financijske.institucije",
                  "1.6.Investicijski.fondovi.osim.novcanih.fondova",
                  "1.7.Drugi.financijski.posrednici",
                  "1.8.Pomocne.financijske.institucije",
                  "1.9.Osiguravajuca.drustva.i.mirovinski.fondovi",
                  "2.0.Oroceni.depoziti",
                  "2.1.Lokalna.drzava",
                  "2.1.1.Od.toga.uz.valutnu.klauzulu",
                  "2.2.Nefinancijska.drustva",
                  "2.2.1.Od.toga.uz.valutnu.klauzulu",
                  "2.3.Kucanstva",
                  "2.3.1.Od.toga.uz.valutnu.klauzulu",
                  "2.4.Ostale.bankarske.institucije",
                  "2.4.1.Od.toga.uz.valutnu.klauzulu",
                  "2.5.Nebankarske.financijske.institucije",
                  "2.5.1.Od.toga.uz.valutnu.klauzulu",
                  "2.6.Investicijski.fondovi.osim.novcanih.fondova",
                  "2.6.1.Od.toga.uz.valutnu.klauzulu",
                  "2.7.Drugi.financijski.posrednici",
                  "2.7.1.Od.toga.uz.valutnu.klauzulu",
                  "2.8.Pomocne.financijske.institucije",
                  "2.8.1.Od.toga.uz.valutnu.klauzulu",
                  "2.9.Osiguravajuca.drustva.i.mirovinski.fondovi",
                  "2.9.1.Od.toga.uz.valutnu.klauzulu",
                  "Ukupno")

#Brisanje 1.redka
D8 <- D8[-1,]

#Factor -> char -> numeric
D8[] <- lapply(D8, as.character)
for(i in c(2:ncol(D8))){
  D8[i] <- as.numeric(unlist(D8[i]))
}

#Sredivanje stupca Datum
for(i in c(1:nrow(D8))){
  if(substr(D8$Datum[i], 4, 5) > 90){
    g <- substr(D8$Datum[i], 4, 5)
    m <- substr(D8$Datum[i], 1, 2)
    D8$Datum[i] <- as.character(paste0("19", g, "-", m))
  } else {
    g <- substr(D8$Datum[i], 4, 5)
    m <- substr(D8$Datum[i], 1, 2)
    D8$Datum[i] <- as.character(paste0("20", g, "-", m))
  }
}


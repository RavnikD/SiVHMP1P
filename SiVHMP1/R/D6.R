library(xlsx)

dir.create("Podaci")

##Download podataka
download.file("http://www.hnb.hr/documents/20182/3d898d07-f916-494d-adeb-af4b42882efa", "Podaci/h-D6.xls", mode = "wb")

#' Tablica D6 Depozitni novac kod DMFI
#
#' @name D6
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export

##Ucitavanje podataka iz tablice
D6 <- read.xlsx(file = "Podaci/h-D6.xls", 1,
                startRow = 6, endRow = 17, as.data.frame = TRUE, header = FALSE)

##Brisanje Na redaka
D6 <- D6[, colSums(is.na(D6)) != nrow(D6)]

##Transponiranje tablice
D6 <- as.data.frame(t(D6))

##Imenovanje stupaca
colnames(D6) <- c("Datum",
                  "Lokalna.drzava",
                  "Nefinancijska.drustva",
                  "Kucanstva",
                  "Ostale.bankarske.institucije",
                  "Nebankarske.financijske.institucije",
                  "Investicijski.fondovi.osim.novcanih.fondova",
                  "Drugi.financijski.posrednici",
                  "Pomocne.financijske.institucije",
                  "Osiguravajuca.drustva.i.mirovinski.fondovi",
                  "Manje.cekovi.banaka.i.obracun.cekova.banaka",
                  "Ukupno")


##Brisanje 1.redka
D6 <- D6[-1,]

##Pretvaranje iz Factor -> char -> numeric
D6[] <- lapply(D6, as.character)
for(i in c(2:ncol(D6))){
  D6[i] <- as.numeric(unlist(D6[i]))
}
##Sredivanje Datuma
for(i in c(1:nrow(D6))){
  if(substr(D6$Datum[i], 4, 5) > 90){
    g <- substr(D6$Datum[i], 4, 5)
    m <- substr(D6$Datum[i], 1, 2)
    D6$Datum[i] <- as.character(paste0("19", g, "-", m))
  } else {
    g <- substr(D6$Datum[i], 4, 5)
    m <- substr(D6$Datum[i], 1, 2)
    D6$Datum[i] <- as.character(paste0("20", g, "-", m))
  }
}



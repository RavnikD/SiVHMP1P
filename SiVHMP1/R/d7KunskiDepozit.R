library(xlsx)


dir.create("Podaci")
##Download podataka
download.file("http://www.hnb.hr/documents/20182/1b0e78d4-0032-4622-8785-2857cd92d9cd", "Podaci/h-KunskiDepozit.xlsx", mode = "wb")

# Tablica D7 Kunski Depozit
#
#' @name D7
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export
KunskiDepozit <- read.xlsx(file = "Podaci/h-KunskiDepozit.xlsx", 1,
                startRow = 6, endRow = 27, as.data.frame = TRUE, header = FALSE)

##Brisanje NA redove
KunskiDepozit <- KunskiDepozit[, colSums(is.na(KunskiDepozit)) != nrow(KunskiDepozit)]

##Transponiranje tablice
KunskiDepozit <- as.data.frame(t(KunskiDepozit))

##Imenovanje redaka
colnames(KunskiDepozit) <- c("Datum",
                  "stedni.depoziti",
                  "Lokalna.drzava",
                  "Nefinancijska.drustva",
                  "Kucanstva",
                  "Ostale.bankarske.institucije",
                  "Nebankarske.financijske.institucije",
                  "Investicijski.fondovi.osim.novcanih.fondova",
                  "Drugi.financijski.posrednici",
                  "Pomocne.financijske.institucije",
                  "Osiguravajuca.drustva.i.mirovinski.fondovi",
                  "Oroceni.depoziti.i.depoziti.s.otkaznim.rokom",
                  "Lokalna.drzava1",
                  "Nefinancijska.drustva",
                  "Kucanstva",
                  "Ostale.bankarske.institucije",
                  "Nebankarske.financijske.institucije",
                  "Investicijski.fondovi.osim.novcanih.fondova",
                  "Drugi.financijski.posrednici",
                  "Pomocne.financijske.institucije",
                  "Osiguravajuca.drustva.i.mirovinski.fondovi",
                  "Ukupno")

##Brisanje 1.redka
KunskiDepozit <- KunskiDepozit[-1,]

## Pretvaranaje iz Factor -> char -> numeric
KunskiDepozit[] <- lapply(KunskiDepozit, as.character)
for(i in c(2:ncol(KunskiDepozit))){
  KunskiDepozit[i] <- as.numeric(unlist(KunskiDepozit[i]))
}

##Sredivanje Datuma
for(i in c(1:nrow(KunskiDepozit))){
  if(substr(KunskiDepozit$Datum[i], 4, 5) > 90){
    g <- substr(KunskiDepozit$Datum[i], 4, 5)
    m <- substr(KunskiDepozit$Datum[i], 1, 2)
    KunskiDepozit$Datum[i] <- as.character(paste0("19", g, "-", m))
  } else {
    g <- substr(KunskiDepozit$Datum[i], 4, 5)
    m <- substr(KunskiDepozit$Datum[i], 1, 2)
    KunskiDepozit$Datum[i] <- as.character(paste0("20", g, "-", m))
  }
}

##Podjela u 2 Data framea
KunskiDepozit1 <- KunskiDepozit[-c(12:21)]
KunskiDepozit2 <- KunskiDepozit[-c(2:11)]

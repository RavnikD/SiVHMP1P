library(xlsx)

dir.create("Podaci")

download.file("http://www.hnb.hr/documents/20182/c03bacf5-12ac-4405-8bff-0f7228307a6e",  "Podaci/h-Obveznice.xlsx", mode = "wb")

# Tablica D9 Obveznice i instrumenti tr?i?ta
#
#' @name D9
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export

obveznice <- read.xlsx(file = "Podaci/h-Obveznice.xlsx", 1,
                startRow = 6, endRow = 18, as.data.frame = TRUE, header = FALSE)

obveznice <- obveznice[, colSums(is.na(obveznice)) != nrow(obveznice)]

obveznice <- as.data.frame(t(obveznice))

colnames(obveznice) <- c("Datum",
                  "Instrumenti.trzista.novca.neto",
                  "Obveznice.neto",
                  "Primljeni.krediti",
                  "Lokalna.drzava",
                  "Nefinancijska.drustva",
                  "Ostale.bankarske.institucije",
                  "Nebankarske.financijske.institucije",
                  "Investicijski.fondovi.osim.novcanih.fondova",
                  "Drugi.financijski.posrednici",
                  "Pomocne.financijske.institucije",
                  "Osiguravajuca.drustva.i.mirovinski.fondovi",
                  "Ukupno")

obveznice <- obveznice[-1,]

obveznice[] <- lapply(obveznice, as.character)
for(i in c(2:ncol(obveznice))){
  obveznice[i] <- as.numeric(unlist(obveznice[i]))
}

for(i in c(1:nrow(obveznice))){
  if(substr(obveznice$Datum[i], 4, 5) > 90){
    g <- substr(obveznice$Datum[i], 4, 5)
    m <- substr(obveznice$Datum[i], 1, 2)
    obveznice$Datum[i] <- as.character(paste0("19", g, "-", m))
  } else {
    g <- substr(obveznice$Datum[i], 4, 5)
    m <- substr(obveznice$Datum[i], 1, 2)
    obveznice$Datum[i] <- as.character(paste0("20", g, "-", m))
  }
}

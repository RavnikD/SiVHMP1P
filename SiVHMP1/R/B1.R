library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("https://www.hnb.hr/documents/20182/2671ceb5-f724-470e-b124-1376f088abb1", "Podaci/h-B1.xls", mode = "wb")

# Tablica B1 Konsolidirana bilanca monetarnih financijskih insitucija
#
#' @name B1
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export
B1 <- read.xlsx(file = "Podaci/h-B1.xls", 1,
                startRow = 6, endRow = 27, as.data.frame = TRUE, header = FALSE)

B1 <- as.data.frame(t(B1))

#Davanje naslova
colnames(B1) <- c("Godina",
                  "Aktiva",
                  "Inozemna.aktiva.neto",
                  "Plasmani",
                  "Potrazivanja.od.sredisnje.drzave.i.fondova.socijalne.sigurnosti.neto",
                  "Potrazivanja.od.ostalih.domacih.sektora",
                  "Potrazivanja.od.ostalih.bankarskih.institucija",
                  "Potrazivanja.od.nebankarskih.financijskih.institucija",
                  "Potrazivanja.od.investicijskih.fondova.osim.nov?anih.fondova",
                  "Potrazivanja.od.drugih.financijskih.posrednika",
                  "Potrazivanja.od.pomocnih.financijskih.institucija",
                  "Potrazivanja.od.osiguravajucih.drustava.i.mirovinskih.fondova",
                  "Ukupno",
                  "PASIVA",
                  "Novcana.masa",
                  "Stedni.i.oroceni.depoziti",
                  "Devizni.depoziti",
                  "Obveznice.i.instrumenti.trzista.novca",
                  "Udjeli.novcanih.fondova",
                  "Ograniceni.i.blokirani.depoziti",
                  "Ostalo(neto)",
                  "Ukupno")

B1 <- B1[-1,]


#Brisanje NA stupca
B1 <- B1[, colSums(is.na(B1)) != nrow(B1)]


#Brisanje NA retka
B1 <- B1[rowSums(is.na(B1)) != ncol(B1),]


colnames(B1) <- gsub(" ",".",colnames(B1))
colnames(B1) <- gsub("\\(|\\)",".",colnames(B1))






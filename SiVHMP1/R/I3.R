library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/01de6360-23e7-4e35-af50-7e79dae8e998", "Podaci/h-I3.xlsx", mode = "wb")

#' Tablica I3 Dug opce drzave (ESA 2010)
#
#' @name I3
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export


I3 <- read.xlsx(file = "Podaci/h-I3.xlsx", 1, startRow = 8, endRow = 38, as.data.frame = TRUE, header = FALSE)
I3 <- as.data.frame(t(I3))
I3header <- read.xlsx(file = "Podaci/h-I3.xlsx", 1, startRow = 7, endRow = 7, header = FALSE)
I3header <- as.data.frame(t(I3header))

I3 <- cbind(I3header,I3)

colnames(I3) <- c("Godina",
                  "Unutarnji.dug.opCe.drzave",
                  "UDOD.Unutarnji.dug.sredisnje.drzave",
                  "UDOD.UDSD.Kratkorocni.duznicki.vrijednosni.papiri",
                  "UDOD.UDSD.Dugoro?ni.duznicki.vrijednosni.papiri",
                  "UDOD.UDSD.Krediti",
                  "UDOD.Unutarnji.dug.fondova.socijalne.sigurnosti",
                  "UDOD.UDFSS.Kratkorocni.duznicki.vrijednosni.papiri",
                  "UDOD.UDFSS.Dugorocni.duznicki.vrijednosni.papiri",
                  "UDOD.UDFSS.Krediti",
                  "UDOD.Unutarnji.dug.lokalne.drzave",
                  "UDOD.UDLD.Kratkorocni.duznicki.vrijednosni.papiri",
                  "UDOD.UDLD.Dugorocni.duznicki.vrijednosni.papiri",
                  "UDOD.UDLD.Krediti",
                  "Inozemni.dug.opce.drzave",
                  "IDOP.Inozemni.dug.sredisnje.drzave",
                  "IDOP.IDSD.Kratkorocni.duznicki.vrijednosni.papiri",
                  "IDOP.IDSD.Dugoro?ni.du?ni?ki.vrijednosni.papiri",
                  "IDOP.IDSD.Krediti",
                  "IDOP.Inozemni.dug.fondova.socijalne.sigurnosti",
                  "IDOP.IDFSS.Kratkorocni.duznicki.vrijednosni.papiri",
                  "IDOP.IDFSS.Dugorocni.duznicki.vrijednosni.papiri",
                  "IDOP.IDFSS.Krediti",
                  "IDOP.Inozemni.dug.lokalne.drzave",
                  "IDOP.IDLD.Kratkorocni.duznicki.vrijednosni.papiri",
                  "IDOP.IDLD.Dugoro?ni.duznicki.vrijednosni.papiri",
                  "IDOP.IDLD.Krediti",
                  "Ukupno.dug.opce.drzave",
                  "Dodatak.Izdana.jamstva.opce.drzave",
                  "D.Domaca",
                  "D.od.toga.jamstva.dana.na.kredite.HBORa",
                  "D.Inozemna")

I3 <- I3[-1,]

colnames(I3) <- gsub(" ",".",colnames(I3))
colnames(I3) <- gsub("\\(|\\)",".",colnames(I3))

#Brisanje stupaca koji su u potpunosti NA
I3 <- I3[, colSums(is.na(I3)) != nrow(I3)]

I3$Godina <- as.character(I3$Godina)


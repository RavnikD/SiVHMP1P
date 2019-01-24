library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/0facf84f-6af8-4893-8dde-d366ee7be04d", "Podaci/h-I2.xlsx", mode = "wb")

#' Tablica I2 Glavni makroagregati opce drzave u skupu racuna ESA 2010
#
#' @name I2
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export


I2 <- read.xlsx(file = "Podaci/h-I2.xlsx", 1, startRow = 6, endRow = 67, as.data.frame = TRUE, header = FALSE)

I2 <- as.data.frame(t(I2))

colnames(I2) <- c("Godina",
                  "TEKUCI.RACUNI",
                  "TR.Racun.proizvodnje",
                  "TR.Izvori",
                  "TR.I.Output",
                  "TR.I.O.Trzisni.output.i.output.za.vlastitu.krajnju.uporabu",
                  "TR.I.O.Netrzisni.output",
                  "TR.Uporabe",
                  "TR.U.Intermedijarna.potrosnja",
                  "TR.U.Dodana.vrijednost,.bruto",
                  "TR.U.Potrosnja.fiksnoga.kapitala",
                  "TR.U.Dodana.vrijednost,.neto",
                  "TR.Racun.generiranja.dohotka",
                  "TR.Izvori",
                  "TR.I.Ostale.subvencije.na.proizvodnju,.primljene",
                  "TR.Uporabe",
                  "TR.U.Naknade.zaposlenicima,.placene",
                  "TR.U.Ostali.porezi.na.proizvodnju,.placeni",
                  "TR.U.Poslovni.visak,.neto",
                  "TR.Racun.primarne.alokacije.dohotka",
                  "TR.Izvori",
                  "TR.I.Porezi.na.proizvodnju.i.uvoz,.primljeni",
                  "TR.I.P.Porezi.na.proizvode,.primljeni",
                  "TR.I.P.Ostali.porezi.na.proizvodnju,.primljeni",
                  "TR.I.Subvencije,.placene",
                  "TR.I.S.Subvencije.na.proizvode,.placene",
                  "TR.I.S.Ostale.subvencije.na.proizvodnju,.placene",
                  "TR.I.Vlasnicki.dohodak,.primljeni",
                  "TR.I.V.Kamate,.primljene",
                  "TR.I.V.Ostali.vlasnicki.dohodak,.primljeni",
                  "TR.Uporabe",
                  "TR.U.Vlasnicki.dohodak,.placeni",
                  "TR.U.V.Kamate,.placene",
                  "TR.U.V.Ostali.vlasnicki.dohodak,.placeni",
                  "TR.U.Primarni.dohodak,.neto",
                  "TR.Racun.sekundarne.rapodjele.dohotka",
                  "TR.Izvori",
                  "TR.I.Tekuci.porezi.na.dohodak,.bogatstvo.itd.,.primljeni",
                  "TR.I.Neto.socijalni.doprinosi",
                  "TR.I.Ostali.tekuci.transferi,.primljeni",
                  "TR.Uporabe",
                  "TR.U.Tekuci.porezi.na.dohodak,.bogatstvo.itd.,.placeni",
                  "TR.U.Socijalne.naknade.osim.socijalnih.transfera.u.naturi,.placene",
                  "TR.U.Socijalni.transferi.u.naturi,.placeni",
                  "TR.U.Ostali.tekuci.transferi,.placeni",
                  "TR.U.Raspolozivi.dohodak,.neto",
                  "TR.Racun.uporabe.raspolozivog.dohotka",
                  "TR.Uporabe",
                  "TR.U.Izdaci.za.finalnu.potrosnju",
                  "TR.U.I.Izdaci.za.individualnu.potrosnju",
                  "TR.U.I.Izdaci.za.zajednicku.potrosnju",
                  "TR.U.Stednja,.neto",
                  "KAPITALNI.RACUN",
                  "KR.Promijene.u.imovini",
                  "KR.PI.Bruto.investicije",
                  "KR.PI.B.Bruto.investicije.u.dugotrajnu.imovinu",
                  "KR.PI.B.Promjene.zaliha.i.neto.povecanje.dragocjenosti",
                  "KR.PI.Neto.povecanje.neproizvedene.nefinancijske.imovine",
                  "KR.Promjene.u.obvezama.i.neto.vrijednosti",
                  "KR.PO.Kapitalni.transferi,.primljeni",
                  "KR.PO.Kapitalni.transferi,.placeni",
                  "KR.PO.Neto.pozajmljivanje.neto.zaduzivanje")

I2 <- I2[-1,]

#Brisanje stupaca koji su u potpunosti NA
I2 <- I2[, colSums(is.na(I2)) != nrow(I2)]

#Brisanje redaka koji su u potpunosti NA
I2 <- I2[rowSums(is.na(I2)) != ncol(I2),]

colnames(I2) <- gsub(" ",".",colnames(I2))
colnames(I2) <- gsub("\\(|\\)",".",colnames(I2))

I2$Godina <- as.character(I2$Godina)




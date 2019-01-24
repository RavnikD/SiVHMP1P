library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/5c84e63f-f7f8-4576-910c-e1967f9b09b8", "Podaci/h-I1.xlsx", mode = "wb")

#' Tablica I1a Nefinancijski racuni opce drzave
#
#' @name I1
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export

I1 <- read.xlsx(file = "Podaci/h-I1.xlsx", 1, startRow = 6, endRow = 95, as.data.frame = TRUE, header = FALSE)

I1a <- as.data.frame(t(I1))


#Davanje imena header-ima
colnames(I1a) <- c("Godina",
                   "Trimestar",
                   "NA.",
                   "KOD.Ukupni.prihodi",
                   "KOD.UP.Ukupni.tekuci.prihodi",
                   "KOD.UP.UTP.Direktni.porezi",
                   "KOD.UP.UTP.Indirektni.porezi",
                   "KOD.UP.UTP.Socijalni.doprinosi",
                   "KOD.UP.UTP.Ostali.tekuci.prihodi",
                   "KOD.UP.UTP.Prihodi.od.prodaje",
                   "KOD.UP.Ukupni.kapitalni.prihodi",
                   "KOD.Ukupni.rashodi",
                   "KOD.UR.Ukupni.tekuci.rashodi",
                   "KOD.UR.UTR.Tekuci.transferi",
                   "KOD.UR.UTR.TT.a.Socijalne.naknade",
                   "KOD.UR.UTR.TT.b.Subvencije",
                   "KOD.UR.UTR.TT.c.Ostali.tekuci.transferi",
                   "KOD.UR.UTR.Kamate",
                   "KOD.UR.UTR.Naknade.zaposlenicima",
                   "KOD.UR.UTR.Intermedijarna.potrosnja",
                   "KOD.UR.Ukupni.kapitalni.rashodi",
                   "KOD.UR.UKR.Investicije",
                   "KOD.UR.UKR.Ostali.kapitalni.transferi",
                   "A.Neto.pozajmljivanje.Neto.zaduzivanje",
                   "B.Sredisnja.drzava",
                   "SD.Ukupni.prihodi",
                   "SD.UP.Ukupni.tekuci.prihodi",
                   "SD.UP.UTP.Direktni.porezi",
                   "SD.UP.UTP.Indirektni.porezi",
                   "SD.UP.UTP.Socijalni.doprinosi",
                   "SD.UP.UTP.Ostali.tekuci.prihodi",
                   "SD.UP.UTP.Prihodi.od.prodaje",
                   "SD.UP.Ukupni.kapitalni.prihodi",
                   "SD.Ukupni.rashodi",
                   "SD.UR.Ukupni.tekuci.rashodi",
                   "SD.UR.UTR.Tekuci.transferi",
                   "SD.UR.UTR.TT.a.Socijalne.naknade",
                   "SD.UR.UTR.TT.b.Subvencije",
                   "SD.UR.UTR.TT.c.Ostali.tekuci.transferi",
                   "SD.UR.UTR.Kamate",
                   "SD.UR.UTR.Naknade.zaposlenicima",
                   "SD.UR.UTR.Intermedijarna.potrosnja",
                   "SD.UR.Ukupni.kapitalni.rashodi",
                   "SD.UR.UKR.Investicije",
                   "SD.UR.UKR.Ostali.kapitalni.transferi",
                   "B.Neto.pozajmljivanje.Neto.zaduzivanje",
                   "C.Fondovi.socijalne.sigurnosti",
                   "FSS.Ukupni.prihodi",
                   "FSS.UP.Ukupni.tekuci.prihodi",
                   "FSS.UP.UTP.Direktni.porezi",
                   "FSS.UP.UTP.Indirektni.porezi",
                   "FSS.UP.UTP.Socijalni.doprinosi",
                   "FSS.UP.UTP.Ostali.tekuci.prihodi",
                   "FSS.UP.UTP.Prihodi.od.prodaje",
                   "FSS.UP.Ukupni.kapitalni.prihodi",
                   "FSS.Ukupni.rashodi",
                   "FSS.UR.Ukupni.tekuci.rashodi",
                   "FSS.UP.UTR.Tekuci.transferi",
                   "FSS.UP.UTR.TT.a.Socijalne.naknade",
                   "FSS.UP.UTR.TT.b.Subvencije",
                   "FSS.UP.UTR.TT.c.Ostali.tekuci.transferi",
                   "FSS.UP.UTR.Kamate",
                   "FSS.UP.UTR.Naknade.zaposlenicima",
                   "FSS.UP.UTR.Intermedijarna.potrosnja",
                   "FSS.UR.Ukupni.kapitalni.rashodi",
                   "FSS.UR.UKR.Investicije",
                   "FSS.UR.UKR.Ostali.kapitalni.transferi",
                   "C.Neto.pozajmljivanje.Neto.zaduzivanje",
                   "D.Lokalna.drzava",
                   "LD.Ukupni.prihodi",
                   "LD.UP.Ukupni.tekuci.prihodi",
                   "LD.UP.UTP.Direktni.porezi",
                   "LD.UP.UTP.Indirektni.porezi",
                   "LD.UP.UTP.Socijalni.doprinosi",
                   "LD.UP.UTP.Ostali.tekuci.prihodi",
                   "LD.UP.UTP.Prihodi.od.prodaje",
                   "LD.UP.Ukupni.kapitalni.prihodi",
                   "LD.Ukupni.rashodi",
                   "LD.UR.Ukupni.tekuci.rashodi",
                   "LD.UR.UTR.Tekuci.transferi",
                   "LD.UR.UTR.TT.a.Socijalne.naknade",
                   "LD.UR.UTR.TT.b.Subvencije",
                   "LD.UR.UTR.TT.c.Ostali.tekuci.transferi",
                   "LD.UR.UTR.Kamate",
                   "LD.UR.UTR.Naknade.zaposlenicima",
                   "LD.UR.UTR.Intermedijarna.potrosnja",
                   "LD.UR.Ukupni.kapitalni.rashodi",
                   "LD.UR.UKR.Investicije",
                   "LD.UR.UKR.Ostali.kapitalni.transferi",
                   "D.Neto.pozajmljivanje.Neto.zaduzivanje")

I1a <- I1a[-1,]
I1a <- I1a[,-3]

colnames(I1a) <- gsub(" ",".",colnames(I1a))
colnames(I1a) <- gsub("\\(|\\)",".",colnames(I1a))


i1a1a <- rbind(I1a[1:15,])
i1a1a <- i1a1a[,-2]

i1a1a$Godina <- as.character(i1a1a$Godina)




#' Tablica I1b Nefinancijski racuni opce drzave

I1b <- rbind(I1a[16:78,])

I1b$Trimestar <- as.character(I1b$Trimestar)

godina <- 2002

for(i in seq(1, 63, 4)){
  I1b$Trimestar[i] <- capture.output(cat(godina, "I"))
  I1b$Trimestar[i+1] <- capture.output(cat(godina, "I1a"))
  I1b$Trimestar[i+2] <- capture.output(cat(godina, "i1aI"))
  if(godina != 2017){
    I1b$Trimestar[i+3] <- capture.output(cat(godina, "IV"))
  }
  godina <- godina + 1
}

I1b$Godina <- as.character(I1b$Godina)

I1b <- I1b[,-1]


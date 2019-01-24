library(xlsx)


dir.create("Podaci")
#Download podataka
download.file("https://www.dzs.hr/Hrv_Eng/Pokazatelji/MSI%20BRUTO%20DOMACI%20PROIZVOD.xlsx", "Podaci/h-BDP.xls", mode = "wb")

# Tablica BDP Kvartal/Godina
#
#' @name BDP
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export

## stvaljanje podataka iz tablice u BDPgodina
BDPgodina <- read.xlsx(file = "Podaci/h-BDP.xls", 7,
                  startRow = 11, endRow = 29, as.data.frame = TRUE)

##Davanje naslove
colnames(BDPgodina) <- c("Godina",
                    "Poljoprivreda.sumarstvo.i.ribarstvo",
                    "Preradivacka.industrija.rudarstvo.i.vadenje.te.ostale.industrije",
                    "Preradivacka.industrija",
                    "Gradevinarstvo",
                    "Trgovina.na.veliko.i.na.malo.prijevoz.i.skladistenje.smjestaj.i.priprema.i.usluzivanje.hrane",
                    "Informacije.i.komunikacije",
                    "Financijske.djelatnosti.i.djelatnosti.osiguranja",
                    "Poslovanje.nekretninama",
                    "Strucne.znanstvene.tehnicke.administrativne.i.pomocne.usluzne.djelatnosti",
                    "Javna.uprava.i.obrana.obrazovanje.djelatnosti.zdravstvene.zastite.i.socijalne.skrbi",
                    "Ostale.usluzne.djelatnosti",
                    "Bruto.dodana.vrijednost.bazicne.cijene",
                    "Porezi.na.proizvode.minus.subvencije.na.proizvode",
                    "Bruto.domaci.proizvod.trzisne.cijene")



BDPgodina$Godina = as.numeric(BDPgodina$Godina)
BDPgodina$Godina = c(2000:2017)

##Brisanje vi?ka polja

BDPgodina <- BDPgodina[c(0:15)]

# Tablica BDP Kvartal
#
#' @name BDP
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export

## stvaljanje podataka iz tablice u BDPkvartal

BDPkvartal <- read.xlsx(file = "Podaci/h-BDP.xls", 7,
                  startRow = 11, endRow = 124, as.data.frame = TRUE)

#Imenovanje stupaca

colnames(BDPkvartal) <- c("Kvartali",
                    "Poljoprivreda.sumarstvo.i.ribarstvo",
                    "Preradivacka.industrija.rudarstvo.i.vadenje.te.ostale.industrije",
                    "Preradivacka.industrija",
                    "Gradevinarstvo",
                    "Trgovina.na.veliko.i.na.malo.prijevoz.i.skladistenje.smjestaj.i.priprema.i.usluzivanje.hrane",
                    "Informacije.i.komunikacije",
                    "Financijske.djelatnosti.i.djelatnosti.osiguranja",
                    "Poslovanje.nekretninama",
                    "Strucne.znanstvene.tehnicke.administrativne.i.pomocne.usluzne.djelatnosti",
                    "Javna.uprava.i.obrana.obrazovanje.djelatnosti.zdravstvene.zastite.i.socijalne.skrbi",
                    "Ostale.usluzne.djelatnosti",
                    "Bruto.dodana.vrijednost.bazicne.cijene",
                    "Porezi.na.proizvode.minus.subvencije.na.proizvode",
                    "Bruto.domaci.proizvod.trzisne.cijene")

##Brisanje viska polja

BDPkvartal <- BDPkvartal[-c(1:19),]
BDPkvartal <- BDPkvartal[c(0:15)]

##ispravljanje pogre?aka

BDPkvartal$Kvartali <- gsub('â€“', '-', BDPkvartal$Kvartali)

BDPkvartal <- BDPkvartal[complete.cases(BDPkvartal), ]


godina <- 2000


#Petlja mijenja "I-II" u "2010 I"

for(i in seq(1, 75, 4)){
  BDPkvartal$Kvartali[i] <- capture.output(cat(godina, "I"))
  BDPkvartal$Kvartali[i+1] <- capture.output(cat(godina, "II"))
  BDPkvartal$Kvartali[i+2] <- capture.output(cat(godina, "III"))
  if(godina != 2018){
    BDPkvartal$Kvartali[i+3] <- capture.output(cat(godina, "IV"))
  }
  godina <- godina + 1
}



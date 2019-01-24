library(xlsx)

dir.create("Podaci")
#Download podataka
download.file("https://www.hnb.hr/documents/20182/b8aee808-08e1-42c5-830e-3e2555953f5f", "Podaci/h-C1.xlsx", mode = "wb")

# Tablica C1 Aktiva/pasiva
#
#' @name C1
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export
#'
## stavljanje podake iz tablica u Bilancaaktiva
Bilancaaktiva <- read.xlsx(file = "Podaci/h-C1.xlsx", 1,
                 startRow = 6, endRow = 36, as.data.frame = TRUE, header = FALSE)

Bilancaaktiva <- as.data.frame(t(Bilancaaktiva))

#Imenovanje stupaca
colnames(Bilancaaktiva) <- c("Datum",
                   "-",
                   "Inozemna.aktiva",
                   "Zlato",
                   "Posebna.prava.vucenja",
                   "Pricuvna.pozicija.kod.MMF",
                   "Efektiva.i.depoziti.u.stranim.bankama",
                   "Oroceni.depoziti.u.stranim.bankama",
                   "Plasmani.u.vrijednosne.papire.u.devizama",
                   "Nekonvertibilna.devizna.aktiva",
                   "Ostala.potrazivanja",
                   "Potrazivanje.od.sredisnje.drzave",
                   "Potrazivanja.u.kn",
                   "Krediti.za.premoscivanje",
                   "Krediti.po.posebnim.propisima",
                   "Ostali.krediti",
                   "Potrazivanje.u.devizama",
                   "Potrazivanje.od.ostalih.domacih.sektora",
                   "Potrazivanje.od.kreditnih.institucija",
                   "Krediti.kreditnim.institucijama",
                   "Krediti.za.refinanciranje",
                   "Krediti.na.temelju.vrijednosnih.papira",
                   "Lombardni.kredit",
                   "Kratkorocni.kredit.za.likvidnost",
                   "Ostali.krediti",
                   "Obratni.repo.krediti.redovite.operacije",
                   "Obratni.repo.krediti.strukturne.operacije",
                   "Krediti.uz.financijsko.osiguranje.strukturne.operacije",
                   "Dospjela.nenaplacena.potrazivanja",
                   "Potrazivanja.od.ostalih.financijsih.institucija",
                   "Ukupno")

## Brisanje vi?ka tablica

Bilancaaktiva <- Bilancaaktiva[-2]
Bilancaaktiva <- Bilancaaktiva[-1,]

## postavljanje podataka tipa numeric

Bilancaaktiva[] <- lapply(Bilancaaktiva, as.character)
for(i in c(2:ncol(Bilancaaktiva))){
  Bilancaaktiva[i] <- as.numeric(unlist(Bilancaaktiva[i]))
}

##ispravljanje oblika datuma

for(i in c(1:nrow(Bilancaaktiva))){
  if(substr(Bilancaaktiva$Datum[i], 4, 5) > 90){
    g <- substr(Bilancaaktiva$Datum[i], 4, 5)
    m <- substr(Bilancaaktiva$Datum[i], 1, 2)
    Bilancaaktiva$Datum[i] <- as.character(paste0("19", g, "-", m))
  } else {
    g <- substr(Bilancaaktiva$Datum[i], 4, 5)
    m <- substr(Bilancaaktiva$Datum[i], 1, 2)
    Bilancaaktiva$Datum[i] <- as.character(paste0("20", g, "-", m))
  }
}


##passiva


Bilancapassiva <- read.xlsx(file = "Podaci/h-C1.xlsx", 1,
                 startRow = 44, endRow = 74, as.data.frame = TRUE, header = FALSE)

##Transponiranje bilancapasiva
Bilancapassiva <- as.data.frame(t(Bilancapassiva))

##Imenovanje stupaca
colnames(Bilancapassiva) <- c("Datum",
                   "-",
                   "Primarni.novac",
                   "Gotov.novac.izvan.kreditnih.institucija",
                   "Blagajne.kreditnih.institucija",
                   "Depoziti.kreditnih.institucija",
                   "Racuni.za.namiru.kreditnih.institucija",
                   "Izdvojena.kunska.obavezna.pricuva",
                   "Upisani.obvezni.blagajnicki.zapisi.HNB",
                   "Prekonocni.depoziti",
                   "Depoziti.ostalih.financijski.institucija",
                   "Ograniceni.i.blokirani.depoziti",
                   "Izdvojena.devizna.obavezna.pricuva",
                   "Ograniceni.depoziti",
                   "Blokirani.devizni.depoziti",
                   "Inozemna.pasiva",
                   "Krediti.MMF",
                   "Obveze.prema.medunarodnim.institucijama",
                   "Obveze.prema.stranim.bankama",
                   "Depoziti.sredisnje.drzave.i.fondova.socijalne.sigurnosti",
                   "Depozitni.novac",
                   "Depozitni.novac.sredisnje.drzave",
                   "Depozitni.novac.socijalne.sigurnosti",
                   "Devizni.depoziti.sredisnje.drzave",
                   "Blagajnicki.zapisi.HNB",
                   "Blagajnicki.zapisi.HNB",
                   "Blagajnicki.zapisi.HNB.u.kn",
                   "Blagajnicki.zapisi.HNB.u.stranoj.valuti",
                   "Kapitalski.racuni",
                   "Ostalo.neto",
                   "Ukupno")

##brisanje viska
Bilancapassiva <- Bilancapassiva[-2]
Bilancapassiva <- Bilancapassiva[-1,]

##Factor -> char -> numeric
Bilancapassiva[] <- lapply(Bilancapassiva, as.character)
for(i in c(2:ncol(Bilancapassiva))){
  Bilancapassiva[i] <- as.numeric(unlist(Bilancapassiva[i]))
}

##Sredivanje stupca Datum
for(i in c(1:nrow(Bilancapassiva))){
  if(substr(Bilancapassiva$Datum[i], 4, 5) > 90){
    g <- substr(Bilancapassiva$Datum[i], 4, 5)
    m <- substr(Bilancapassiva$Datum[i], 1, 2)
    Bilancapassiva$Datum[i] <- as.character(paste0("19", g, "-", m))
  } else {
    g <- substr(Bilancapassiva$Datum[i], 4, 5)
    m <- substr(Bilancapassiva$Datum[i], 1, 2)
    Bilancapassiva$Datum[i] <- as.character(paste0("20", g, "-", m))
  }
}


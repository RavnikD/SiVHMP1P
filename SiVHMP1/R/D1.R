library(xlsx)

dir.create("Podaci")

##Download podataka
download.file("http://www.hnb.hr/documents/20182/5669de5c-ec4a-4be1-a11b-70c584b62020", "Podaci/h-D1.xls", mode = "wb")

#' Tablica D1a Konsolidirana bilanca DMFI (aktiva)
#
#' @name D1
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export

##Punjenje tablice sa podacima
D1 <- read.xlsx(file = "Podaci/h-D1.xls", 1,
                 startRow = 7, endRow = 37, as.data.frame = TRUE, header = FALSE)


##Brisanje NA redaka
D1 <- D1[, colSums(is.na(D1)) != nrow(D1)]

##Transponiranje tablice D1
D1<- as.data.frame(t(D1))

#Imenaovanje stupaca
colnames(D1) <- c("Datum",
                   "-",
                   "Pricuve.kreditnih.institucija.kod.sredisnje.banke",
                   "Kunske.pricuve.kod.sredisnje.banke",
                   "Devizne.pricuve.kod.sredisnje.banke",
                   "Inozemna.aktiva",
                   "Potrazivanja.od.sredisnje.drzave.i.fondova.socijalne.sigurnosti",
                   "Potrazivanja.od.ostalih.domacih.sektora",
                   "Potrazivanja.od.lokalne.drzave",
                   "Potrazivanja.od.nefinancijskih.drustava",
                   "Potrazivanja.od.kucanstava",
                   "Potrazivanja.od.ostalih.bankarskih.institucija",
                   "Potrazivanja.od.nebankarskih.financijskih.institucija",
                   "Potrazivanja.od.investicijskih.fondova.osim.novcanih.fondova",
                   "Potrazivanja.od.drugih.financijskih.posrednika",
                   "Potrazivanja.od.pomocnih.financijskih.institucija",
                   "Potrazivanja.od.osiguravajucih.drustava.i.mirovinskih.fondova",
                   "Ukupno.Aktiva",
                   "PASIVA",
                   "Depozitni.novac",
                   "stedni.i.oroceni.depoziti",
                   "Devizni.depoziti",
                   "Obveznice.i.instrumenti.trzista.novca",
                   "Udjeli.novcanih.fondova.",
                   "Inozemna.pasiva",
                   "Depoziti.sredisnje.drzave.i.fondova.socijalne.sigurnosti",
                   "Krediti.primljeni.od.sredisnje.banke",
                   "Ograniceni.i.blokirani.depoziti",
                   "Kapitalski.racuni",
                   "Ostalo.neto",
                   "Ukupno.Pasiva")


##Brisanje viska redaka
D1 <- D1[-2]
D1 <- D1[-19]
D1 <- D1[-1,]


#Factor -> char -> numeric
D1[] <- lapply(D1, as.character)
for(i in c(2:ncol(D1))){
  D1[i] <- as.numeric(unlist(D1[i]))
}

##Ispravljanje Datuma
for(i in c(1:nrow(D1))){
  if(substr(D1$Datum[i], 4, 5) > 90){
    g <- substr(D1$Datum[i], 4, 5)
    m <- substr(D1$Datum[i], 1, 2)
    D1$Datum[i] <- as.character(paste0("19", g, "-", m))
  } else {
    g <- substr(D1$Datum[i], 4, 5)
    m <- substr(D1$Datum[i], 1, 2)
    D1$Datum[i] <- as.character(paste0("20", g, "-", m))
  }
}


#' Tablica D1a Konsolidirana bilanca DMFI (pasiva)
#
#' @name D1a
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}

## Ucitavanja D1a
D1a <- read.xlsx(file = "Podaci/h-D1.xls", 1,
                 startRow = 41, endRow = 71, as.data.frame = TRUE, header = FALSE)

##brisanje praznih redaka
D1a <- D1a[, colSums(is.na(D1a)) != nrow(D1a)]


##Transponiranje tablice
D1a <- as.data.frame(t(D1a))

##Imenovanje stupaca
colnames(D1a) <- c("Datum",
                   "AKTIVA",
                   "Pricuve.kreditnih.institucija.kod.sredisnje.banke",
                   "Kunske.pricuve.kod.sredisnje.banke",
                   "Devizne.pricuve.kod.sredisnje.banke",
                   "Inozemna.aktiva",
                   "Potrazivanja.od.sredisnje.drzave.i.fondova.socijalne.sigurnosti",
                   "Potrazivanja.od.ostalih.domacih.sektora",
                   "Potrazivanja.od.lokalne.drzave",
                   "Potrazivanja.od.nefinancijskih.drustava",
                   "Potrazivanja.od.stanovnistva",
                   "Potrazivanja.od.ostalih.bankarskih.institucija",
                   "Potrazivanja.od.nebankarskih.financijskih.institucija",
                   "Potrazivanja.od.investicijskih.fondova.osim.novcanih",
                   "Potrazivanja.od.drugih.financijskih.posrednika",
                   "Potrazivanja.od.pomocnih.financijskih.institucija",
                   "Potrazivanja.od.drustava.za.osiguranje.i.mirovinskih.fondova",
                   "Ukupno.Aktiva",
                   "PASIVA",
                   "Depozitni.novac",
                   "stedni.i.oroceni.depoziti",
                   "Devizni.depoziti",
                   "Obveznice.i.instrumenti.trzista.novca",
                   "Udjeli.novcanih.fondova.",
                   "Inozemna.pasiva",
                   "Depoziti.sredisnje.drzave.i.fondova.socijalne.sigurnosti",
                   "Krediti.primljeni.od.sredisnje.banke",
                   "Ograniceni.i.blokirani.depoziti",
                   "Kapitalski.racuni",
                   "Ostalo.neto",
                   "Ukupno.Pasiva")

##Brisanje vi?ka
D1a <- D1a[-2]
D1a <- D1a[-19]
D1a <- D1a[-1,]

##Pretvaranje Factor -> char -> numeric
D1a[] <- lapply(D1a, as.character)
for(i in c(2:ncol(D1a))){
  D1a[i] <- as.numeric(unlist(D1a[i]))
}

##Ispravljanje Datuma
for(i in c(1:nrow(D1a))){
  if(substr(D1a$Datum[i], 4, 5) > 90){
    g <- substr(D1a$Datum[i], 4, 5)
    m <- substr(D1a$Datum[i], 1, 2)
    D1a$Datum[i] <- as.character(paste0("19", g, "-", m))
  } else {
    g <- substr(D1a$Datum[i], 4, 5)
    m <- substr(D1a$Datum[i], 1, 2)
    D1a$Datum[i] <- as.character(paste0("20", g, "-", m))
  }
}

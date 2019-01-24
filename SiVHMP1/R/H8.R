library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/a03ebf3f-f6af-49a6-a99b-fba08eb93150", "Podaci/h-H8.xlsx", mode = "wb")

#' Tablica H8a Medunarodne pricuve i devizna likvidnost
#
#' Sluzbene medunarodne pricuve i ostale devizne pricuve (priblizna trzisna vrijednost)
#' @name H8a
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export


# UCITAVANJE PRVE TABLICE
H8a <- read.xlsx(file = "Podaci/h-H8.xlsx", 1,
                 startRow = 6, endRow = 25, as.data.frame = TRUE, header = FALSE)

#Transponiranje tablice
H8a <- as.data.frame(t(H8a))

#Brisanje 1.redka
H8a <- H8a[-1,]
H8a <- H8a[-1,]
H8a <- H8a[-2]

#Davanje imena header-ima
colnames(H8a) <- c("Datum",
                   "Slu?bene.me?unarodne.pri?uve",
                   "Devizne.pri?uve.u.konvertibilnoj.stranoj.valuti",
                   "Du?ni?ki.vrijednosni.papiri",
                   "od.toga.izdavatelji.sa.sjedi?tem.u.zemlji.o.kojoj.se.izvje?tava.ali.locirani.u.inozemstvu",
                   "Ukupno.valuta.i.depoziti.kod",
                   "ostalih.sredi?njih.banaka.BIS.i.MMF",
                   "banaka.sa.sjedi?tem.u.zemlji.o.kojoj.se.izvje?tava",
                   "od.toga.locirane.u.inozemstvu",
                   "banaka.sa.sjedi?tem.izvan.zemlje.o.kojoj.se.izvje?tava",
                   "od.toga.locirane.u.zemlji.o.kojoj.se.izvje?tava",
                   "Pri?uvna.pozicija.u.MMF",
                   "Posebna.prava.vu?enja.SDR",
                   "Zlato",
                   "Ostale.devizne.pri?uve",
                   "obratni.repo.poslovi",
                   "Ostale.devizne.pri?uve",
                   "oro?eni.depoziti",
                   "Ukupno")

#Factor -> char -> numeric
H8a[] <- lapply(H8a, as.character)
for(i in c(2:ncol(H8a))){
  H8a[i] <- as.numeric(unlist(H8a[i]))
}

#Sredivanje stupca datum
for(i in c(1:nrow(H8a))){
  H8a$Datum[i] <- as.character(paste0(substr(H8a$Datum[i], 7, 10),"-",substr(H8a$Datum[i], 4, 5),"-",substr(H8a$Datum[i], 1, 2)))
}

#' Tablica H8b Medunarodne pricuve i devizna likvidnost
#'
#' Obvezani kratkorocni neto odljevi medunarodnih i ostalih deviznih pricuva (nominalna vrijednost)
#'

# UCITAVANJE DRUGE TABLICE
H8b <- read.xlsx(file = "Podaci/h-H8.xlsx", 1,
                 startRow = 27, endRow = 59, as.data.frame = TRUE, header = FALSE)

#Transponiranje tablice
H8b <- as.data.frame(t(H8b))

#Brisanje redaka
H8b <- H8b[-1,]
H8b <- H8b[-1,]

#Dodavanje datuma
H8b <- cbind(z = H8a$Datum, H8b)

#Davanje imena header-ima
colnames(H8b) <- c("Datum",
                   "Devizni.krediti.du?ni?ki.vrijednosni.papiri.i.depoziti.ukupni.neto.odljevi.do.1.godine",
                   "Hrvatska.narodna.banka",
                   "Do.1.mjesec.Glavnica",
                   "Do.1.mjesec.Kamate",
                   "Preko.1.do.3.mjeseca.Glavnica",
                   "Preko.1.do.3.mjeseca.Kamate",
                   "Preko.3.mjeseca.do.1.godine.Glavnica",
                   "Preko.3.mjeseca.do.1.godine.Kamate",
                   "Sredi?nja.dr?ava"	,
                   "Do.1.mjesec.Glavnica",
                   "Do.1.mjesec.Kamate",
                   "Preko.1.do.3.mjeseca.Glavnica",
                   "Preko.1.do.3.mjeseca.Kamate",
                   "Preko.3.mjeseca.do.1.godine.Glavnica",
                   "Preko.3.mjeseca.do.1.godine.Kamate",
                   "Agregatna..kratka.i.duga.pozicija.deviznih.terminskih.poslova.deviznih.ro?nica.i.me?uvalutnih.swapova.u.odnosu.na.doma?u.valutu.",
                   "Kratke.pozicije",
                   "Do.1.mjesec",
                   "Preko.1.do.3.mjeseca",
                   "Preko.3.mjeseca.do.1.godine",
                   "Duge.pozicije",
                   "Do.1.mjesec",
                   "Preko.1.do.3.mjeseca",
                   "Preko.3.mjeseca.do.1.godine",
                   "Ostalo",
                   "odljevi.s.osnove.repo.poslova.",
                   "Do.1.mjesec.Glavnica",
                   "Do.1.mjesecKamate",
                   "Preko.1.do.3.mjeseca.Glavnica",
                   "Preko.1.do.3.mjeseca.Kamate",
                   "Preko.3.mjeseca.do.1.godine.Glavnica",
                   "Preko.3.mjeseca.do.1.godine.Kamate",
                   "Ukupni.kratkoro?ni.neto.odljevi.me?unarodnih.i.ostalih.deviznih.pri?uva")

#Factor -> char -> numeric
H8b[] <- lapply(H8b, as.character)
for(i in c(2:ncol(H8b))){
  H8b[i] <- as.numeric(unlist(H8b[i]))
}

#' Tablica H8c Monetarni i kreditni agregati
#'
#' Potencijalni kratkorocni neto odljevi medunarodnih pricuva (nominalna vrijednost)
#'

# UCITAVANJE TRECE TABLICE
H8c <- read.xlsx(file = "Podaci/h-H8.xlsx", 1,
                 startRow = 61, endRow = 79, as.data.frame = TRUE, header = FALSE)

#Transponiranje tablice
H8c <- as.data.frame(t(H8c))

#Brisanje redaka
H8c <- H8c[-1,]
H8c <- H8c[-1,]

#Dodavanje datuma
H8c <- cbind(z = H8a$Datum, H8c)

#Davanje imena header-ima
colnames(H8c) <- c("Datum",
                   "Potencijalne.devizne.obveze",
                   "Izdane.garancije.s.dospije?em.od.1.godine",
                   "Hrvatska.narodna.banka",
                   "Sredi?nja.dr?ava",
                   "Do.1.mjesec",
                   "Preko.1.do.3.mjeseca",
                   "Preko.3.mjeseca.do.1.godine",
                   "Ostale.potencijalne.obveze",
                   "Hrvatska.narodna.banka",
                   "Do.1.mjesec",
                   "Preko.1.do.3.mjeseca",
                   "Preko.3.mjeseca.do.1.godine",
                   "Sredi?nja.dr?ava",
                   "Izdani.devizni.du?ni?ki.vrijed..papiri.s.opcijom.prodaje",
                   "Neiskori?teni.okvirni.krediti.ugovoreni.s",
                   "BIS",
                   "MMF",
                   "Agregatna.kratka.i.duga.pozicija.deviznih.opcija.prema.doma?oj.valuti",
                   "Ukupni.kratkoro?ni.neto.odljevi.me?unarodnih.i.ostalih.deviznih.pri?uva")

#Factor -> char -> numeric
H8c[] <- lapply(H8c, as.character)
for(i in c(2:ncol(H8c))){
  H8c[i] <- as.numeric(unlist(H8c[i]))
}

# UCITAVANJE CETVRTE TABLICE
H8d <- read.xlsx(file = "Podaci/h-H8.xlsx", 1,
                 startRow = 81, endRow = 96, as.data.frame = TRUE, header = FALSE)

#Transponiranje tablice
H8d <- as.data.frame(t(H8d))

#Brisanje redaka
H8d <- H8d[-1,]
H8d <- H8d[-1,]

#Dodavanje datuma
H8d <- cbind(z = H8a$Datum, H8d)

#' Tablica H8d Monetarni i kreditni agregati

#Davanje imena header-ima
colnames(H8d) <- c("Datum",
                   "kratkorocni.kunski.dug.s.valutnom.klauzulom",
                   "u.tome.sredisnja.drzava",
                   "devizni.financijski.instrumenti.koji.se.ne.honoriraju.u.devizama",
                   "zalozena.imovina",
                   "repo.poslovi.s.vrijednosnim.papirima",
                   "posuzeni.ili.repo.i.ukljuceni.u.Dio.I",
                   "posuzeni.ili.repo.ali.nisu.ukljuceni.u.Dio.I",
                   "primljeni.ili.steceni.i.ukljuceni.u.Dio.I",
                   "primljeni.ili.steceni.ali.nisu.ukljuceni.u.Dio.I",
                   "financijske.izvedenice.neto.po.trzisnoj.vrijednosti"	,
                   "valutna.struktura.sluzbenih.medunarodnih.pricuva",
                   "SPV.i.valute.koje.cine.SPV",
                   "valute.koje.ne.cine.SPV",
                   "USD",
                   "EURO",
                   "Ostale")

#Factor -> char -> numeric
H8d[] <- lapply(H8d, as.character)
for(i in c(2:ncol(H8d))){
  H8d[i] <- as.numeric(unlist(H8d[i]))
}


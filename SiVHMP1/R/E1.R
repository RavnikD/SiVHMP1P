library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/d2ad271b-a42a-4e1d-89b6-538261379df7", "Podaci/h-E1.xls", mode = "wb")

#' Tablica E1a Agregirana bilanca investicijskih fondova (stanja)
#
#' @name E1
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export
# UCITAVANJE GODISNJE TABLICE
E1 <- read.xlsx(file = "Podaci/h-E1.xls", 1,
                 startRow = 7, endRow = 44, as.data.frame = TRUE, header = FALSE)


#Micanje redaka koji su u potpunosti NA
E1 <- E1[, colSums(is.na(E1)) != nrow(E1)]

#Transponiranje tablice
E1<- as.data.frame(t(E1))

#Davanje imena header-ima
colnames(E1) <- c("Datum",
                   "AKTIVA",
                   "Dani.depoziti.i.zajmovi",
                   "Domaci.sektori",
                   "od.toga.Monetarne.financijske.institucije",
                   "Inozemstvo",
                   "Ulaganja.u.duznicke.vrijednosne.papire",
                   "Domaci.sektori",
                   "od.toga.Nefinancijska.drustva",
                   "od.toga.Financijska.drustva",
                   "od.toga.Opca.drzava",
                   "Inozemstvo",
                   "od.toga.Nefinancijska.drustva",
                   "od.toga.Financijska.drustva",
                   "od.toga.Opca.drzava",
                   "Ulaganja.u.dionice.i.ostali.dionicki.kapital",
                   "Domaci.sektori",
                   "od.toga.Nefinancijska.drustva",
                   "od.toga.Financijska.drustva",
                   "Inozemstvo",
                   "od.toga.Nefinancijska.drustva",
                   "od.toga.Financijska.drustva",
                   "Nefinancijska.imovina",
                   "Ostala.imovina.ukljucujuci.financijske.derivate",
                   "Ukupno.Aktiva",
                   "PASIVA",
                   "Primljeni.depoziti.i.zajmovi",
                   "Izdani.udjeli.dionice.investicijskih.fondova",
                   "Domaci.sektori",
                   "od.toga.Nefinancijska.drustva",
                   "od.toga.Financijska.drustva",
                   "od.toga.Kucanstva",
                   "Inozemstvo",
                   "od.toga.Nefinancijska.drustva",
                   "od.toga.Financijska.drustva",
                   "od.toga.Kucanstva",
                   "Ostale.obveze.ukljucujuci.financijske.derivate",
                   "Ukupno.Pasiva")


#Brisanje 1.redka
E1 <- E1[-2]
E1 <- E1[-26]
E1<- E1[-1,]

#Factor -> char -> numeric
E1[] <- lapply(E1, as.character)
for(i in c(2:ncol(E1))){
  E1[i] <- as.numeric(unlist(E1[i]))
}

#Sredivanje stupca Datum
for(i in c(1:nrow(E1))){
  if(substr(E1$Datum[i], 4, 5) > 90){
    g <- substr(E1$Datum[i], 4, 5)
    m <- substr(E1$Datum[i], 1, 2)
    E1$Datum[i] <- as.character(paste0("19", g, "-", m))
  } else {
    g <- substr(E1$Datum[i], 4, 5)
    m <- substr(E1$Datum[i], 1, 2)
    E1$Datum[i] <- as.character(paste0("20", g, "-", m))
  }
}

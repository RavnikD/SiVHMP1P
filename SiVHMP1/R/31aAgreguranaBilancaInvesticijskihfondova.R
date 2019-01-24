library(xlsx)

dir.create("Podaci")
#Download podataka
download.file("http://www.hnb.hr/documents/20182/7fc61af9-41dd-4d4e-8541-939948d8fd3b", "Podaci/h-AgreguranaBilancaInvesticijskihfondova.xlsx", mode = "wb")

# Tablica 31a
#
#' @name 31a
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export

# UCITAVANJE GODISNJE TABLICE
AgreguranaBilanca <- read.xlsx(file = "Podaci/h-AgreguranaBilancaInvesticijskihfondova.xlsx", 1,
                 startRow = 7, endRow = 44, as.data.frame = TRUE, header = FALSE)

#Micanje redaka koji su u potpunosti NA
AgreguranaBilanca <- AgreguranaBilanca[, colSums(is.na(AgreguranaBilanca)) != nrow(AgreguranaBilanca)]

#Transponiranje tablice
AgreguranaBilanca <- as.data.frame(t(AgreguranaBilanca))

#Davanje imena header-ima
colnames(AgreguranaBilanca) <- c("Datum",
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
AgreguranaBilanca <- AgreguranaBilanca[-2]
AgreguranaBilanca <- AgreguranaBilanca[-26]
AgreguranaBilanca <- AgreguranaBilanca[-1,]

#Micanje space-a
AgreguranaBilanca$Datum <- trimws(AgreguranaBilanca$Datum)

#Micanje tocke na kraju datuma
AgreguranaBilanca$Datum <- substr(AgreguranaBilanca$Datum, 1, nchar(AgreguranaBilanca$Datum)-1)

#Factor -> char -> numeric
AgreguranaBilanca[] <- lapply(AgreguranaBilanca, as.character)
for(i in c(2:ncol(AgreguranaBilanca))){
  AgreguranaBilanca[i] <- as.numeric(unlist(AgreguranaBilanca[i]))
}

#Sredivanje stupca Datum
for(i in c(7:25)){
  AgreguranaBilanca$Datum[i] <- as.character(paste0("20",substr(AgreguranaBilanca$Datum[i], 6, 7),"-","04","-","0",substr(AgreguranaBilanca$Datum[i],1,1)))
}

for(i in c(26:30)){
  AgreguranaBilanca$Datum[i] <- as.character(paste0("200",substr(AgreguranaBilanca$Datum[i], 6, 7),"-","04","-","0",substr(AgreguranaBilanca$Datum[i],1,1)))
}

for(i in c(31:nrow(AgreguranaBilanca))){
  if(substr(AgreguranaBilanca$Datum[i], 4, 5) > 90){
    g <- substr(AgreguranaBilanca$Datum[i], 4, 5)
    m <- substr(AgreguranaBilanca$Datum[i], 1, 2)
    AgreguranaBilanca$Datum[i] <- as.character(paste0("19", g, "-", m))
  } else {
    g <- substr(AgreguranaBilanca$Datum[i], 4, 5)
    m <- substr(AgreguranaBilanca$Datum[i], 1, 2)
    AgreguranaBilanca$Datum[i] <- as.character(paste0("20", g, "-", m))
  }
}

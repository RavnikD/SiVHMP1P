library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/98f5bca9-e530-461d-9c25-eb4e8b5b0efc", "Podaci/h-h11.xlsx", mode = "wb")

#' Tablica H11 Indeksi efektivnih tecajeva kune
#
#' @name h11
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export


# UCITAVANJE GODISNJE TABLICE
H11 <- read.xlsx(file = "Podaci/h-h11.xlsx", 1,
                 startRow = 7, endRow = 282, as.data.frame = TRUE, header = FALSE)

#Micanje redaka koji su u potpunosti NA
H11 <- H11[, colSums(is.na(H11)) != nrow(H11)]

#Micanje praznih stupca
H11 <- H11[-5]
H11 <- H11[-6]
H11 <- H11[-7]
H11 <- H11[-8]

#Davanje imena header-ima
colnames(H11) <- c("Godina",
                   "Mjesec",
                   "Nominalni.efektivni.tecaj",
                   "RETD.Indeks.potrosackih.cijena",
                   "RETD.Indeks.proizvodackih.cijena.industrije",
                   "REFTKD.Jedinicni.troskovi.rada.u.ukupnome.gospodarstvu",
                   "REFTKD.Jedinicni.troskovi.rada.u.preradivackoj.industriji")

#Sredivanje godine
H11$Godina <- as.character(H11$Godina)
H11$Godina <- substr(H11$Godina, 1, 4)

#Factor -> char
H11$Mjesec <- as.character(H11$Mjesec)

#Micanje space-a s kraja mjeseca
H11$Mjesec <- trimws(H11$Mjesec)

#Pretvaranje stupca godina u godina-mjesec (YYYY -> YYYY-MM)
for(i in c(1:nrow(H11))){
  if(!is.na(H11$Godina[i])){
    godina <- H11$Godina[i]
  }
  switch (as.character(H11$Mjesec[i]),
          "sijeĂ„Ĺ¤anj" = H11$Godina[i] <- as.character(paste0(godina,"-",1)),
          "veljaĂ„Ĺ¤a" = H11$Godina[i] <- as.character(paste0(godina,"-",2)),
          "oÄąÄľujak" = H11$Godina[i] <- as.character(paste0(godina,"-",3)),
          "travanj" = H11$Godina[i] <- as.character(paste0(godina,"-",4)),
          "svibanj" = H11$Godina[i] <- as.character(paste0(godina,"-",5)),
          "lipanj" = H11$Godina[i] <- as.character(paste0(godina,"-",6)),
          "srpanj" = H11$Godina[i] <- as.character(paste0(godina,"-",7)),
          "kolovoz" = H11$Godina[i] <- as.character(paste0(godina,"-",8)),
          "rujan" = H11$Godina[i] <- as.character(paste0(godina,"-",9)),
          "listopad" = H11$Godina[i] <- as.character(paste0(godina,"-",10)),
          "studeni"  = H11$Godina[i] <- as.character(paste0(godina,"-",11)),
          "prosinac" = H11$Godina[i] <- as.character(paste0(godina,"-",12))
  )
}

#Micanje stupca Mjesec
H11 <- H11[-2]

colnames(H11)[1] <- "Datum"

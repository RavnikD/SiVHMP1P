library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/0b0a6d39-2a80-4272-bfdc-39dcb166a09f", "Podaci/h-J1a.xlsx", mode = "wb")

#' Tablica J1a Harmonizirani indeksi potrosackih cijena
#
#' @name J1a
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export

# UCITAVANJE GODISNJE TABLICE
J1a <- read.xlsx(file = "Podaci/h-J1a.xlsx", 1,
                 startRow = 8, endRow = 258, as.data.frame = TRUE, header = FALSE)

#Micanje redaka koji su u potpunosti NA
J1a <- J1a[, colSums(is.na(J1a)) != nrow(J1a)]

#Davanje imena header-ima
colnames(J1a) <- c("Godina",
                   "Mjesec",
                   "BI.HIPC.Ukupno",
                   "BI.HIPC.Dobra",
                   "BI.HIPC.Usluge",
                   "BI.HIPCSP.Ukupno",
                   "BI.HIPCSP.Dobra",
                   "BI.HIPCSP.Usluge",
                   "MSP.HIPC.Ukupno",
                   "MSP.HIPC.Dobra",
                   "MSP.HIPC.Usluge",
                   "MSP.HIPCSP.Ukupno",
                   "MSP.HIPCSP.Dobra",
                   "MSP.HIPCSP.Usluge",
                   "GSP.HIPC.Ukupno",
                   "GSP.HIPC.Dobra",
                   "GSP.HIPC.Usluge",
                   "GSP.HIPCSP.Ukupno",
                   "GSP.HIPCSP.Dobra",
                   "GSP.HIPCSP.Usluge")

#Sredivanje godine
J1a$Godina <- as.character(J1a$Godina)
J1a$Godina <- substr(J1a$Godina, 1, 4)

#Factor -> char
J1a$Mjesec <- as.character(J1a$Mjesec)

#Micanje space-a s kraja mjeseca
J1a$Mjesec <- trimws(J1a$Mjesec)

#Pretvaranje stupca godina u godina-mjesec (YYYY -> YYYY-MM)
for(i in c(1:nrow(J1a))){
  if(!is.na(J1a$Godina[i])){
    godina <- J1a$Godina[i]
  }
  switch (as.character(J1a$Mjesec[i]),
          "sijeĂ„Ĺ¤anj" = J1a$Godina[i] <- as.character(paste0(godina,"-",1)),
          "veljaĂ„Ĺ¤a" = J1a$Godina[i] <- as.character(paste0(godina,"-",2)),
          "oÄąÄľujak" = J1a$Godina[i] <- as.character(paste0(godina,"-",3)),
          "travanj" = J1a$Godina[i] <- as.character(paste0(godina,"-",4)),
          "svibanj" = J1a$Godina[i] <- as.character(paste0(godina,"-",5)),
          "lipanj" = J1a$Godina[i] <- as.character(paste0(godina,"-",6)),
          "srpanj" = J1a$Godina[i] <- as.character(paste0(godina,"-",7)),
          "kolovoz" = J1a$Godina[i] <- as.character(paste0(godina,"-",8)),
          "rujan" = J1a$Godina[i] <- as.character(paste0(godina,"-",9)),
          "listopad" = J1a$Godina[i] <- as.character(paste0(godina,"-",10)),
          "studeni"  = J1a$Godina[i] <- as.character(paste0(godina,"-",11)),
          "prosinac" = J1a$Godina[i] <- as.character(paste0(godina,"-",12))
  )
}

#Micanje stupca Mjesec
J1a <- J1a[-2]

colnames(J1a)[1] <- "Datum"

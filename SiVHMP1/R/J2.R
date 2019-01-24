library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/5242d6dd-fc95-4eeb-bc97-87d4ae7a64be", "Podaci/h-J2.xlsx", mode = "wb")

#' Tablica J2 Temeljni indeksi potrosakcih cijena
#
#' @name J2
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export


# UCITAVANJE GODISNJE TABLICE
J2 <- read.xlsx(file = "Podaci/h-j2.xlsx", 1,
                startRow = 7, endRow = 257, as.data.frame = TRUE, header = FALSE)

#Micanje redaka koji su u potpunosti NA
J2 <- J2[, colSums(is.na(J2)) != nrow(J2)]


#Davanje imena header-ima
colnames(J2) <- c("Godina",
                  "Mjesec",
                  "BI.Ukupno",
                  "BI.Dobra",
                  "BI.Usluge",
                  "MSP.Ukupno",
                  "MSP.Dobra",
                  "MSP.Usluge",
                  "GSP.Ukupno",
                  "GSP.Dobra",
                  "GSP.Usluge")

#Sredivanje godine
J2$Godina <- as.character(J2$Godina)
J2$Godina <- substr(J2$Godina, 1, 4)

#Factor -> char
J2$Mjesec <- as.character(J2$Mjesec)

#Micanje space-a s kraja mjeseca
J2$Mjesec <- trimws(J2$Mjesec)

#Pretvaranje stupca godina u godina-mjesec (YYYY -> YYYY-MM)
for(i in c(1:nrow(J2))){
  if(!is.na(J2$Godina[i])){
    godina <- J2$Godina[i]
  }
  switch (as.character(J2$Mjesec[i]),
          "sijeĂ„Ĺ¤anj" = J2$Godina[i] <- as.character(paste0(godina,"-",1)),
          "veljaĂ„Ĺ¤a" = J2$Godina[i] <- as.character(paste0(godina,"-",2)),
          "oÄąÄľujak" = J2$Godina[i] <- as.character(paste0(godina,"-",3)),
          "travanj" = J2$Godina[i] <- as.character(paste0(godina,"-",4)),
          "svibanj" = J2$Godina[i] <- as.character(paste0(godina,"-",5)),
          "lipanj" = J2$Godina[i] <- as.character(paste0(godina,"-",6)),
          "srpanj" = J2$Godina[i] <- as.character(paste0(godina,"-",7)),
          "kolovoz" = J2$Godina[i] <- as.character(paste0(godina,"-",8)),
          "rujan" = J2$Godina[i] <- as.character(paste0(godina,"-",9)),
          "listopad" = J2$Godina[i] <- as.character(paste0(godina,"-",10)),
          "studeni"  = J2$Godina[i] <- as.character(paste0(godina,"-",11)),
          "prosinac" = J2$Godina[i] <- as.character(paste0(godina,"-",12))
  )
}

#Micanje stupca Mjesec
J2 <- J2[-2]

colnames(J2)[1] <- "Datum"


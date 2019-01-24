library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/7e044113-48bc-43f0-8f92-8a6672e3d74b", "Podaci/h-J5.xlsx", mode = "wb")

#' Tablica J5 Indeksi pouzdanja ocekivanja i raspolozenja potrosaca
#
#' @name J5
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export
J5<- read.xlsx(file = "Podaci/h-J5.xlsx", 1, startRow = 8, endRow = 195, as.data.frame = TRUE, header = FALSE)

#Brisanje stupaca koji su u potpunosti NA
J5 <- J5[, colSums(is.na(J5)) != nrow(J5)]

#Davanje imena header-ima
colnames(J5) <- c("Godina",
                  "Mjesec",
                  "KI.Indeks.pouzdanja.potrosaca",
                  "KI.Indeks.ocekivanja.potrosaca",
                  "KI.Indeks.raspolozenja.potrosaca",
                  "Indeksi.odgovora.I1",
                  "Indeksi.odgovora.I2",
                  "Indeksi.odgovora.I3",
                  "Indeksi.odgovora.I4",
                  "Indeksi.odgovora.I7",
                  "Indeksi.odgovora.I8",
                  "Indeksi.odgovora.I11"

)

J5$Godina <- as.character(J5$Godina)
J5$Godina <- as.numeric(J5$Godina)

J5$Mjesec <- as.character(J5$Mjesec)


#Micanje space-a s kraja mjeseca
J5$Mjesec <- trimws(J5$Mjesec)

#Micanje space-a
J5$Mjesec <- trimws(J5$Mjesec)

#Pretvaranje stupca godina u godina-mjesec (YYYY -> YYYY-MM)
for(i in c(1:nrow(J5))){
  if(!is.na(J5$Godina[i])){
    godina <- J5$Godina[i]
  }
  switch (as.character(J5$Mjesec[i]),
          "sijeÄŤanj" = J5$Godina[i] <- as.character(paste0(godina,"-",1)),
          "veljaÄŤa" = J5$Godina[i] <- as.character(paste0(godina,"-",2)),
          "oĹľujak" = J5$Godina[i] <- as.character(paste0(godina,"-",3)),
          "travanj" = J5$Godina[i] <- as.character(paste0(godina,"-",4)),
          "svibanj" = J5$Godina[i] <- as.character(paste0(godina,"-",5)),
          "lipanj" = J5$Godina[i] <- as.character(paste0(godina,"-",6)),
          "srpanj" = J5$Godina[i] <- as.character(paste0(godina,"-",7)),
          "kolovoz" = J5$Godina[i] <- as.character(paste0(godina,"-",8)),
          "rujan" = J5$Godina[i] <- as.character(paste0(godina,"-",9)),
          "listopad" = J5$Godina[i] <- as.character(paste0(godina,"-",10)),
          "studeni"  = J5$Godina[i] <- as.character(paste0(godina,"-",11)),
          "prosinac" = J5$Godina[i] <- as.character(paste0(godina,"-",12))
  )
}

#Micanje stupca Mjesec
J5 <- J5[-2]


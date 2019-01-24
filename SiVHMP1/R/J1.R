library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/996b69a3-c057-4c09-a185-c01ab3d54fc4", "Podaci/h-J1.xlsx", mode = "wb")

#' Tablica J1 Indeksi potrosackih cijena i proizvodackih cijena industrije
#
#' @name J1
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export


# UCITAVANJE GODISNJE TABLICE
J1 <- read.xlsx(file = "Podaci/h-J1.xlsx", 1,
                startRow = 8, endRow = 258, as.data.frame = TRUE, header = FALSE)

#Micanje redaka koji su u potpunosti NA
J1 <- J1[, colSums(is.na(J1)) != nrow(J1)]

#Davanje imena header-ima
colnames(J1) <- c("Godina",
                  "Mjesec",
                  "BI.IPC.Ukupno",
                  "BI.IPC.Dobra",
                  "BI.IPC.Usluge",
                  "BI.Proizvodacke.cijene.industrije",
                  "MSP.IPC.Ukupno",
                  "MSP.IPC.Dobra",
                  "MSP.IPC.Usluge",
                  "MSP.Proizvodake.cijene.industrije",
                  "GSP.IPC.Ukupno",
                  "GSP.IPC.Dobra",
                  "GSP.IPC.Usluge",
                  "GSP.Proizvodacke.cijene.industrije")

#Sredivanje godine
J1$Godina <- as.character(J1$Godina)
J1$Godina <- substr(J1$Godina, 1, 4)

#Factor -> char
J1$Mjesec <- as.character(J1$Mjesec)

#Micanje space-a s kraja mjeseca
J1$Mjesec <- trimws(J1$Mjesec)

#Pretvaranje stupca godina u godina-mjesec (YYYY -> YYYY-MM)
for(i in c(1:nrow(J1))){
  if(!is.na(J1$Godina[i])){
    godina <- J1$Godina[i]
  }
  switch (as.character(J1$Mjesec[i]),
          "sijeĂ„Ĺ¤anj" = J1$Godina[i] <- as.character(paste0(godina,"-",1)),
          "veljaĂ„Ĺ¤a" = J1$Godina[i] <- as.character(paste0(godina,"-",2)),
          "oÄąÄľujak" = J1$Godina[i] <- as.character(paste0(godina,"-",3)),
          "travanj" = J1$Godina[i] <- as.character(paste0(godina,"-",4)),
          "svibanj" = J1$Godina[i] <- as.character(paste0(godina,"-",5)),
          "lipanj" = J1$Godina[i] <- as.character(paste0(godina,"-",6)),
          "srpanj" = J1$Godina[i] <- as.character(paste0(godina,"-",7)),
          "kolovoz" = J1$Godina[i] <- as.character(paste0(godina,"-",8)),
          "rujan" = J1$Godina[i] <- as.character(paste0(godina,"-",9)),
          "listopad" = J1$Godina[i] <- as.character(paste0(godina,"-",10)),
          "studeni"  = J1$Godina[i] <- as.character(paste0(godina,"-",11)),
          "prosinac" = J1$Godina[i] <- as.character(paste0(godina,"-",12))
  )
}

#Micanje stupca Mjesec
J1 <- J1[-2]

colnames(J1)[1] <- "Datum"

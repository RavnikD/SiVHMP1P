library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/09f6d6fe-4a6e-42fd-9196-59313400aec3", "Podaci/h-G10b.xlsx", mode = "wb")

#' Tablica G10b Godisnji srednji devizni tecajevi HNB-a na kraju razdoblja
#'
#' @name G10b
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export


# UCITAVANJE GODISNJE TABLICE
G10bG <- read.xlsx(file = "Podaci/h-G10b.xlsx", 1,
                   startRow = 6, endRow = 31, as.data.frame = TRUE, header = FALSE)

#Davanje imena header-ima
colnames(G10bG) <- c("Godina",
                     "Mjesec",
                     "EUR.HRK",
                     "ATS.HRK",
                     "FRF.HRK",
                     "100.ITL.HRK",
                     "CHF.HRK",
                     "GBP.HRK",
                     "USD.HRK",
                     "DEM.HRK")

#Micanje drugog stupca
G10bG <- G10bG[-2]

#Sredivanje godine
G10bG$Godina <- as.character(G10bG$Godina)
G10bG$Godina <- substr(G10bG$Godina, 1, 4)

#' Tablica G10b Mjesecni srednji devizni tecajevi HNB-a na kraju razdoblja


# UCITAVANJE MJESECNE TABLICE
G10bM <- read.xlsx(file = "Podaci/h-G10b.xlsx", 1,
                   startRow = 32, endRow = 355, as.data.frame = TRUE, header = FALSE)

#Micanje redaka koji su u potpunosti NA
G10bM <- G10bM[, colSums(is.na(G10bM)) != nrow(G10bM)]

#Davanje imena header-ima
colnames(G10bM) <- c("Godina",
                     "Mjesec",
                     "EUR.HRK",
                     "ATS.HRK",
                     "FRF.HRK",
                     "100.ITL.HRK",
                     "CHF.HRK",
                     "GBP.HRK",
                     "USD.HRK",
                     "DEM.HRK")

#Factor -> char
G10bM$Godina <- as.character(G10bM$Godina)
G10bM$Mjesec <- as.character(G10bM$Mjesec)

#Sredivanje godine
G10bM$Godina <- substr(G10bM$Godina, 1, 4)

#Micanje space-a s kraja mjeseca
G10bM$Mjesec <- trimws(G10bM$Mjesec)

#Pretvaranje stupca godina u godina-mjesec (YYYY -> YYYY-MM)
for(i in c(1:nrow(G10bM))){
  if(!is.na(G10bM$Godina[i])){
    godina <- G10bM$Godina[i]
  }
  switch (as.character(G10bM$Mjesec[i]),
          "sijeÄŤanj" = G10bM$Godina[i] <- as.character(paste0(godina,"-",1)),
          "veljaÄŤa" = G10bM$Godina[i] <- as.character(paste0(godina,"-",2)),
          "oĹľujak" = G10bM$Godina[i] <- as.character(paste0(godina,"-",3)),
          "travanj" = G10bM$Godina[i] <- as.character(paste0(godina,"-",4)),
          "svibanj" = G10bM$Godina[i] <- as.character(paste0(godina,"-",5)),
          "lipanj" = G10bM$Godina[i] <- as.character(paste0(godina,"-",6)),
          "srpanj" = G10bM$Godina[i] <- as.character(paste0(godina,"-",7)),
          "kolovoz" = G10bM$Godina[i] <- as.character(paste0(godina,"-",8)),
          "rujan" = G10bM$Godina[i] <- as.character(paste0(godina,"-",9)),
          "listopad" = G10bM$Godina[i] <- as.character(paste0(godina,"-",10)),
          "studeni"  = G10bM$Godina[i] <- as.character(paste0(godina,"-",11)),
          "prosinac" = G10bM$Godina[i] <- as.character(paste0(godina,"-",12))
  )
}

##Micanje stupca Mjesec
G10bM <- G10bM[-2]

colnames(G10bM)[1] <- "Datum"


library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/33ebeea1-3d13-4a42-b0fb-87223d026703", "Podaci/h-G10a.xlsx", mode = "wb")

#' Tablica G10a Godisnji prosjeci srednjih deviznih tecajeva
#'
#' @name G10a
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export



# UCITAVANJE GODISNJE TABLICE
G10aG <- read.xlsx(file = "Podaci/h-G10a.xlsx", 1,
                   startRow = 6, endRow = 31, as.data.frame = TRUE, header = FALSE)

#Davanje imena header-ima
colnames(G10aG) <- c("Godina",
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
G10aG <- G10aG[-2]

#Sredivanje godine
G10aG$Godina <- as.character(G10aG$Godina)
G10aG$Godina <- substr(G10aG$Godina, 1, 4)

#' Tablica G10a Mjesecni prosjeci srednjih deviznih tecajeva
#'

# UCITAVANJE MJESECNE TABLICE
G10aM <- read.xlsx(file = "Podaci/h-G10a.xlsx", 1,
                   startRow = 32, endRow = 355, as.data.frame = TRUE, header = FALSE)

#Micanje redaka koji su u potpunosti NA
G10aM <- G10aM[, colSums(is.na(G10aM)) != nrow(G10aM)]

#Davanje imena header-ima
colnames(G10aM) <- c("Godina",
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
G10aM$Godina <- as.character(G10aM$Godina)
G10aM$Mjesec <- as.character(G10aM$Mjesec)

#Sredivanje godine
G10aM$Godina <- substr(G10aM$Godina, 1, 4)

#Micanje space-a s kraja mjeseca
G10aM$Mjesec <- trimws(G10aM$Mjesec)

#Pretvaranje stupca godina u godina-mjesec (YYYY -> YYYY-MM)
for(i in c(1:nrow(G10aM))){
  if(!is.na(G10aM$Godina[i])){
    godina <- G10aM$Godina[i]
  }
  switch (as.character(G10aM$Mjesec[i]),
          "sijeÄŤanj" = G10aM$Godina[i] <- as.character(paste0(godina,"-",1)),
          "veljaÄŤa" = G10aM$Godina[i] <- as.character(paste0(godina,"-",2)),
          "oĹľujak" = G10aM$Godina[i] <- as.character(paste0(godina,"-",3)),
          "travanj" = G10aM$Godina[i] <- as.character(paste0(godina,"-",4)),
          "svibanj" = G10aM$Godina[i] <- as.character(paste0(godina,"-",5)),
          "lipanj" = G10aM$Godina[i] <- as.character(paste0(godina,"-",6)),
          "srpanj" = G10aM$Godina[i] <- as.character(paste0(godina,"-",7)),
          "kolovoz" = G10aM$Godina[i] <- as.character(paste0(godina,"-",8)),
          "rujan" = G10aM$Godina[i] <- as.character(paste0(godina,"-",9)),
          "listopad" = G10aM$Godina[i] <- as.character(paste0(godina,"-",10)),
          "studeni"  = G10aM$Godina[i] <- as.character(paste0(godina,"-",11)),
          "prosinac" = G10aM$Godina[i] <- as.character(paste0(godina,"-",12))
  )
}

#Micanje stupca Mjesec
G10aM <- G10aM[-2]

colnames(G10aM)[1] <- "Datum"

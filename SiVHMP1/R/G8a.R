library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/2ec6a2c9-38ce-4400-9fbf-bc9b09f4dcb9", "Podaci/h-G8a.xlsx", mode = "wb")

#' Tablica G8aG Kamatne stope na trezorske zapise RH (godisnji)
#'
#' @name G8aG
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export

# UCITAVANJE GODISNJE TABLICE
G8aG <- read.xlsx(file = "Podaci/h-G8a.xlsx", 1,
                  startRow = 7, endRow = 29, as.data.frame = TRUE, header = FALSE)

#Davanje imena header-ima
colnames(G8aG) <- c("Godina",
                    "Mjesec",
                    "IUHRK.3.mj",
                    "IUHRK.6.mj",
                    "IUHRK.12.mj",
                    "IUVKUE.3.mj",
                    "IUVKUE.12.mj")

#Micanje redaka koji su u potpunosti NA
G8aG <- G8aG[, colSums(is.na(G8aG)) != nrow(G8aG)]

#Factor -> char -> numeric
G8aG[] <- lapply(G8aG, as.character)
for(i in c(2:ncol(G8aG))){
  G8aG[i] <- as.numeric(unlist(G8aG[i]))
}

#Sredivanje godine
G8aG$Godina <- substr(G8aG$Godina, 1, 4)

#' Tablica G8aM Kamatne stope na trezorske zapise RH (mjesecni)
#'

# UCITAVANJE MJESECNE TABLICE
G8aM <- read.xlsx(file = "Podaci/h-G8a.xlsx", 1,
                  startRow = 29, endRow = 137, as.data.frame = TRUE, header = FALSE)

#Micanje redaka koji su u potpunosti NA
G8aM <- G8aM[, colSums(is.na(G8aM)) != nrow(G8aM)]

#Davanje imena header-ima
colnames(G8aM) <- c("Godina",
                    "Mjesec",
                    "IUHRK.3.mj",
                    "IUHRK.6.mj",
                    "IUHRK.12.mj",
                    "IUVKUE.3.mj",
                    "IUVKUE.12.mj")

#Factor -> char -> numeric
G8aM[] <- lapply(G8aM, as.character)
for(i in c(3:ncol(G8aM))){
  G8aM[i] <- as.numeric(unlist(G8aM[i]))
}

#Sredivanje godine
G8aM$Godina <- substr(G8aM$Godina, 1, 4)

#Micanje space-a s kraja mjeseca
G8aM$Mjesec <- trimws(G8aM$Mjesec)

#Pretvaranje stupca godina u godina-mjesec (YYYY -> YYYY-MM)
for(i in c(1:nrow(G8aM))){
  if(!is.na(G8aM$Godina[i])){
    godina <- G8aM$Godina[i]
  }
  switch (as.character(G8aM$Mjesec[i]),
          "sijeÄŤanj" = G8aM$Godina[i] <- as.character(paste0(godina,"-",1)),
          "veljaÄŤa" = G8aM$Godina[i] <- as.character(paste0(godina,"-",2)),
          "oĹľujak" = G8aM$Godina[i] <- as.character(paste0(godina,"-",3)),
          "travanj" = G8aM$Godina[i] <- as.character(paste0(godina,"-",4)),
          "svibanj" = G8aM$Godina[i] <- as.character(paste0(godina,"-",5)),
          "lipanj" = G8aM$Godina[i] <- as.character(paste0(godina,"-",6)),
          "srpanj" = G8aM$Godina[i] <- as.character(paste0(godina,"-",7)),
          "kolovoz" = G8aM$Godina[i] <- as.character(paste0(godina,"-",8)),
          "rujan" = G8aM$Godina[i] <- as.character(paste0(godina,"-",9)),
          "listopad" = G8aM$Godina[i] <- as.character(paste0(godina,"-",10)),
          "studeni"  = G8aM$Godina[i] <- as.character(paste0(godina,"-",11)),
          "prosinac" = G8aM$Godina[i] <- as.character(paste0(godina,"-",12))
  )
}

#Micanje stupca Mjesec
G8aM <- G8aM[-2]

colnames(G8aM)[1] <- "Datum"

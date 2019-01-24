library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/6ffecb49-45f4-4f33-ab75-34a6f930c058", "Podaci/h-H7.xlsx", mode = "wb")

#' Tablica H7 Medunarodne pricuve HNB-a i devizne pricuve banaka
#'
#' MPHNB = Medunarodne pricuve Hrvatske narodne banke
#' @name H7
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export

# UCITAVANJE GODISNJE TABLICE
H7 <- read.xlsx(file = "Podaci/h-H7.xlsx", 1,
                startRow = 9, endRow = 321, as.data.frame = TRUE, header = FALSE)

#Micanje redaka koji su u potpunosti NA
H7 <- H7[, colSums(is.na(H7)) != nrow(H7)]

#Davanje imena header-ima
colnames(H7) <- c("Godina",
                  "Mjesec",
                  "MPHNB.Ukupno",
                  "MPHNB.Posebna.prava.vucenja",
                  "MPHNB.Pricuvna.pozicija.u.MMF",
                  "MPHNB.Zlato",
                  "MPHNB.Devize.Ukupno",
                  "MPHNB.Devize.Valuta.i.depozit",
                  "MPHNB.Obveznice.i.zaduzenice",
                  "Devizne.pricuve.banaka")

#Factor -> char -> numeric
H7[] <- lapply(H7, as.character)
for(i in c(3:ncol(H7))){
  H7[i] <- as.numeric(unlist(H7[i]))
}

#Sredivanje godine
H7$Godina <- substr(H7$Godina, 1, 4)

#Micanje space-a s kraja mjeseca
H7$Mjesec <- trimws(H7$Mjesec)

#Pretvaranje stupca godina u godina-mjesec (YYYY -> YYYY-MM)
for(i in c(1:nrow(H7))){
  if(!is.na(H7$Godina[i])){
    godina <- H7$Godina[i]
  }
  switch (as.character(H7$Mjesec[i]),
          "sijeÄŤanj" = H7$Godina[i] <- as.character(paste0(godina,"-",1)),
          "veljaÄŤa" = H7$Godina[i] <- as.character(paste0(godina,"-",2)),
          "oĹľujak" = H7$Godina[i] <- as.character(paste0(godina,"-",3)),
          "travanj" = H7$Godina[i] <- as.character(paste0(godina,"-",4)),
          "svibanj" = H7$Godina[i] <- as.character(paste0(godina,"-",5)),
          "lipanj" = H7$Godina[i] <- as.character(paste0(godina,"-",6)),
          "srpanj" = H7$Godina[i] <- as.character(paste0(godina,"-",7)),
          "kolovoz" = H7$Godina[i] <- as.character(paste0(godina,"-",8)),
          "rujan" = H7$Godina[i] <- as.character(paste0(godina,"-",9)),
          "listopad" = H7$Godina[i] <- as.character(paste0(godina,"-",10)),
          "studeni"  = H7$Godina[i] <- as.character(paste0(godina,"-",11)),
          "prosinac" = H7$Godina[i] <- as.character(paste0(godina,"-",12))
  )
}

##Micanje stupca Mjesec
H7 <- H7[-2]

colnames(H7)[1] <- "Datum"

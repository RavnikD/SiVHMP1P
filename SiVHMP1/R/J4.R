library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/4f09f661-854e-49cb-862b-7de14ebbc119", "Podaci/h-J4.xlsx", mode = "wb")

#'  Tablica J4 Prosjecne mjesecne neto place
#
#' @name J4
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export
J4 <- read.xlsx(file = "Podaci/h-J4.xlsx", 1, startRow = 6, endRow = 328, as.data.frame = TRUE, header = FALSE)

#Brisanje stupaca koji su u potpunosti NA
J4 <- J4[, colSums(is.na(J4)) != nrow(J4)]



#Davanje imena header-ima
colnames(J4) <- c("Godina",
                  "Mjesec",
                  "Prosjecne.mjesecne.neto.place",
                  "Lancani.indeksi",
                  "Godisnji.mjesecni.indeksi",
                  "Godisnji.kumulativni.indeksi"

)

J4 <- J4[-1,]


J4$Godina <- as.character(J4$Godina)
J4$Godina <- as.numeric(J4$Godina)

J4$Mjesec <- as.character(J4$Mjesec)


#Micanje space-a s kraja mjeseca
J4$Mjesec <- trimws(J4$Mjesec)

#Micanje space-a
J4$Mjesec <- trimws(J4$Mjesec)

#Pretvaranje stupca godina u godina-mjesec (YYYY -> YYYY-MM)
for(i in c(1:nrow(J4))){
  if(!is.na(J4$Godina[i])){
    godina <- J4$Godina[i]
  }
  switch (as.character(J4$Mjesec[i]),
          "sijeÄŤanj" = J4$Godina[i] <- as.character(paste0(godina,"-",1)),
          "veljaÄŤa" = J4$Godina[i] <- as.character(paste0(godina,"-",2)),
          "oĹľujak" = J4$Godina[i] <- as.character(paste0(godina,"-",3)),
          "travanj" = J4$Godina[i] <- as.character(paste0(godina,"-",4)),
          "svibanj" = J4$Godina[i] <- as.character(paste0(godina,"-",5)),
          "lipanj" = J4$Godina[i] <- as.character(paste0(godina,"-",6)),
          "srpanj" = J4$Godina[i] <- as.character(paste0(godina,"-",7)),
          "kolovoz" = J4$Godina[i] <- as.character(paste0(godina,"-",8)),
          "rujan" = J4$Godina[i] <- as.character(paste0(godina,"-",9)),
          "listopad" = J4$Godina[i] <- as.character(paste0(godina,"-",10)),
          "studeni"  = J4$Godina[i] <- as.character(paste0(godina,"-",11)),
          "prosinac" = J4$Godina[i] <- as.character(paste0(godina,"-",12))
  )
}

#Micanje stupca Mjesec
J4 <- J4[-2]


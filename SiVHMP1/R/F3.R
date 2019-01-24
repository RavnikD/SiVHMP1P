library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/b7571e17-ff06-4d33-a8c4-53e59fc823bb", "Podaci/h-F3.xlsx", mode = "wb")

#' Tablica F3 Obveze pricuve banaka
#'
#' @name F3
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export

F3 <- read.xlsx(file = "Podaci/h-F3.xlsx", 1, startRow = 9, endRow = 319, as.data.frame = TRUE, header = FALSE)

#Brisanje stupaca koji su u potpunosti NA
F3 <- F3[, colSums(is.na(F3)) != nrow(F3)]

#Davanje imena header-ima
colnames(F3) <- c("Godina",
                  "Mjesec",
                  "Vagana.prosjecna.stopa.obvezne.rezerve",
                  "OOP.ukupno",
                  "OOP.u.kunama",
                  "OOP.u.stranoj.valuti",
                  "Ostali.obvezni.depoziti.kod.HNB",
                  "IOP.u.kunama",
                  "IOP.u.stranoj.valuti",
                  "Prosjecna.stopa.remuneracije.na.kunska.imobilizirana",
                  "Prosjecna.stopa.remuneracije.na.devizni.izdvojena"
)


F3$Godina <- as.character(F3$Godina)
F3$Godina <- as.numeric(F3$Godina)

F3$Mjesec <- as.character(F3$Mjesec)


#Micanje space-a s kraja mjeseca
F3$Mjesec <- trimws(F3$Mjesec)


#Micanje space-a
F3$Mjesec <- trimws(F3$Mjesec)

#Pretvaranje stupca godina u godina-mjesec (YYYY -> YYYY-MM)
for(i in c(1:nrow(F3))){
  if(!is.na(F3$Godina[i])){
    godina <- F3$Godina[i]
  }
  switch (as.character(F3$Mjesec[i]),
          "siječanj" = F3$Godina[i] <- as.character(paste0(godina,"-",1)),
          "veljača" = F3$Godina[i] <- as.character(paste0(godina,"-",2)),
          "ožujak" = F3$Godina[i] <- as.character(paste0(godina,"-",3)),
          "travanj" = F3$Godina[i] <- as.character(paste0(godina,"-",4)),
          "svibanj" = F3$Godina[i] <- as.character(paste0(godina,"-",5)),
          "lipanj" = F3$Godina[i] <- as.character(paste0(godina,"-",6)),
          "srpanj" = F3$Godina[i] <- as.character(paste0(godina,"-",7)),
          "kolovoz" = F3$Godina[i] <- as.character(paste0(godina,"-",8)),
          "rujan" = F3$Godina[i] <- as.character(paste0(godina,"-",9)),
          "listopad" = F3$Godina[i] <- as.character(paste0(godina,"-",10)),
          "studeni"  = F3$Godina[i] <- as.character(paste0(godina,"-",11)),
          "prosinac" = F3$Godina[i] <- as.character(paste0(godina,"-",12))
  )
}

#Micanje stupca Mjesec
F3 <- F3[-2]

F3$OOP.u.stranoj.valuti <- as.character(F3$OOP.u.stranoj.valuti)
F3$OOP.u.stranoj.valuti <- as.numeric(F3$OOP.u.stranoj.valuti)

F3$Ostali.obvezni.depoziti.kod.HNB <- as.character(F3$Ostali.obvezni.depoziti.kod.HNB)
F3$Ostali.obvezni.depoziti.kod.HNB <- as.numeric(F3$Ostali.obvezni.depoziti.kod.HNB)

F3$IOP.u.stranoj.valuti <- as.character(F3$IOP.u.stranoj.valuti)
F3$IOP.u.stranoj.valuti <- as.numeric(F3$IOP.u.stranoj.valuti)

F3$Prosjecna.stopa.remuneracije.na.kunska.imobilizirana <- as.character(F3$Prosjecna.stopa.remuneracije.na.kunska.imobilizirana)
F3$Prosjecna.stopa.remuneracije.na.kunska.imobilizirana <- as.numeric(F3$Prosjecna.stopa.remuneracije.na.kunska.imobilizirana)

F3$Prosjecna.stopa.remuneracije.na.devizni.izdvojena <- as.character(F3$Prosjecna.stopa.remuneracije.na.devizni.izdvojena)
F3$Prosjecna.stopa.remuneracije.na.devizni.izdvojena <- as.numeric(F3$Prosjecna.stopa.remuneracije.na.devizni.izdvojena)













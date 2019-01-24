library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/296265a5-9a82-43ea-8d6e-2d17bed45edd", "Podaci/h-F1.xls", mode = "wb")

#' Tablica F1 Aktivne kamatne stope HNB-a
#
#' @name F1
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export
F1 <- read.xlsx(file = "Podaci/h-F1.xls", 1, startRow = 9, endRow = 321, as.data.frame = TRUE, header = FALSE)


F1$X5 <- NULL
F1$X8 <- NULL
F1$X10 <- NULL
F1$X12 <- NULL
F1$X15 <- NULL
F1$X17 <- NULL
F1$X19 <- NULL
F1$X21 <- NULL

#Davanje imena header-ima
colnames(F1) <- c("Godina",
                  "Mjesec",
                  "Eskontna.stopa.HNB",
                  "Repo.stopa.HNB",
                  "AKS.Na.lombardne.kredite",
                  "AKS.Na.prekonocne.kredite",
                  "AKS.Na.interventne.kredite.za.premoscivanje.nelikvidnosti",
                  "AKS.Na.kredite.koristene.unutar.jednog.dana",
                  "AKS.Na.kratkorocni.kredit.za.likvidnost",
                  "AKS.Na.nepravilno.obracunatu.ili.manje.izdvojenu.obveznu.pricuvu",
                  "AKS.Na.nepropisno.koristena.sredstva.i.dospjele.nenaplacene.obveze",
                  "AKS.Na.koristena.sredstva.OP.za.odrzavanje.dnevne.likvidnosti"
)

F1$Godina <- as.character(F1$Godina)
F1$Godina <- as.numeric(F1$Godina)

F1$Mjesec <- as.character(F1$Mjesec)


#Micanje space-a s kraja mjeseca
F1$Mjesec <- trimws(F1$Mjesec)

#Micanje "7)" s kraja mjeseca
for(i in c(1:nrow(F1))){
  if(substr(F1$Mjesec[i], nchar(F1$Mjesec[i]), nchar(F1$Mjesec[i])) == ")"){
    F1$Mjesec[i] <- substr(F1$Mjesec[i], 1, nchar(F1$Mjesec[i])-2)
  }
}

#Micanje space-a
F1$Mjesec <- trimws(F1$Mjesec)

#Pretvaranje stupca godina u godina-mjesec (YYYY -> YYYY-MM)
for(i in c(1:nrow(F1))){
  if(!is.na(F1$Godina[i])){
    godina <- F1$Godina[i]
  }
  switch (as.character(F1$Mjesec[i]),
          "siječanj" = F1$Godina[i] <- as.character(paste0(godina,"-",1)),
          "veljača" = F1$Godina[i] <- as.character(paste0(godina,"-",2)),
          "ožujak" = F1$Godina[i] <- as.character(paste0(godina,"-",3)),
          "travanj" = F1$Godina[i] <- as.character(paste0(godina,"-",4)),
          "svibanj" = F1$Godina[i] <- as.character(paste0(godina,"-",5)),
          "lipanj" = F1$Godina[i] <- as.character(paste0(godina,"-",6)),
          "srpanj" = F1$Godina[i] <- as.character(paste0(godina,"-",7)),
          "kolovoz" = F1$Godina[i] <- as.character(paste0(godina,"-",8)),
          "rujan" = F1$Godina[i] <- as.character(paste0(godina,"-",9)),
          "listopad" = F1$Godina[i] <- as.character(paste0(godina,"-",10)),
          "studeni"  = F1$Godina[i] <- as.character(paste0(godina,"-",11)),
          "prosinac" = F1$Godina[i] <- as.character(paste0(godina,"-",12))
  )
}

# mjesec listopad '93 je razdvojen na 2 dijela, pa sam to rucno stavila
F1[11,1] = as.character("1993-10-7")
F1[12,1] = as.character("1993-10-31")

#Micanje stupca Mjesec
F1 <- F1[-2]

F1$Repo.stopa.HNB <- as.character(F1$Repo.stopa.HNB)
F1$Repo.stopa.HNB <- as.numeric(F1$Repo.stopa.HNB)

F1$AKS.Na.prekonocne.kredite <- as.character(F1$AKS.Na.prekonocne.kredite)
F1$AKS.Na.prekonocne.kredite <- as.numeric(F1$AKS.Na.prekonocne.kredite)

F1$AKS.Na.interventne.kredite.za.premoscivanje.nelikvidnosti <- as.character(F1$AKS.Na.interventne.kredite.za.premoscivanje.nelikvidnosti)
F1$AKS.Na.interventne.kredite.za.premoscivanje.nelikvidnosti <- as.numeric(F1$AKS.Na.interventne.kredite.za.premoscivanje.nelikvidnosti)

F1$AKS.Na.kratkorocni.kredit.za.likvidnost <- as.character(F1$AKS.Na.kratkorocni.kredit.za.likvidnost)
F1$AKS.Na.kratkorocni.kredit.za.likvidnost <- as.numeric(F1$AKS.Na.kratkorocni.kredit.za.likvidnost)



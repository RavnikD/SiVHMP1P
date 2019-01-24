library(xlsx)

dir.create("Podaci")

# Tablica A1 Monetarni i kreditni agregati
#
#' @name A1
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export

#Download podataka
download.file("https://www.hnb.hr/documents/20182/ffed056f-df13-4766-bc67-faa339fdc6b1", "Podaci/h-A1.xls", mode = "wb")

#Stavljanje podataka iz tablice u A1 DataFrame
A1 <- read.xlsx(file = "Podaci/h-A1.xls", 1,
                startRow = 8, endRow = 303, as.data.frame = TRUE)
#Brisanje NA supca
A1 <- A1[, colSums(is.na(A1)) != nrow(A1)]

#Davanje naslova
colnames(A1) <- c("Godina",
                  "Mjesec",
                  "Primarni.novac",
                  "Novcana.masa.M1",
                  "Nocana.masa.M1a",
                  "Ukupna.likvidna.sredstva.M4",
                  "Monetarni.agregati.prema.definiciji.ESB.M1",
                  "Monetarni.agregati.prema.definiciji.ESB.M2",
                  "Monetarni.agregati.prema.definiciji.ESB.M3",
                  "Neto.domaca.aktiva",
                  "Plasman",
                  "MSR.Primarni.novac",
                  "MSR.Novcana.masa.M1",
                  "MSR.Novcana.masa.M1a",
                  "MSR.Ukupna.likvidna.sredstva.M4",
                  "Monetarni.agregati.prema.definiciji.ESB.M1",
                  "Monetarni.agregati.prema.definiciji.ESB.M2",
                  "Monetarni.agregati.prema.definiciji.ESB.M3",
                  "MSR.Neto.domaca.aktiva",
                  "MSR.Plasmani")

#Factor -> char -> numeric
A1[] <- lapply(A1, as.character)


for(i in c(3:ncol(A1))){
  A1[i] <- as.numeric(unlist(A1[i]))
}

A1$Godina <- as.numeric(unlist(A1$Godina))
#Micanje space-a s kraja mjeseca
A1$Mjesec <- trimws(A1$Mjesec)
#Micanje "2)" s kraja mjeseca
for(i in c(1:nrow(A1))){
  if(substr(A1$Mjesec[i], nchar(A1$Mjesec[i]), nchar(A1$Mjesec[i])) == ")"){
    A1$Mjesec[i] <- substr(A1$Mjesec[i], 1, nchar(A1$Mjesec[i])-2)
  }
  A1$Godina[i] <- substr(A1$Godina[i], 1, 4)
}
#Pretvaranje stupca godina u godina-mjesec (YYYY -> YYYY-MM) i ispravljanje
for(i in c(1:nrow(A1))){
  if(!is.na(A1$Godina[i])){
    godina <- A1$Godina[i]
  }
  switch (as.character(A1$Mjesec[i]),
          "sijeÄŤanj" = A1$Godina[i] <- as.character(paste0(godina,"-",1)),
          "veljaÄŤa" = A1$Godina[i] <- as.character(paste0(godina,"-",2)),
          "oĹľujak" = A1$Godina[i] <- as.character(paste0(godina,"-",3)),
          "travanj" = A1$Godina[i] <- as.character(paste0(godina,"-",4)),
          "svibanj" = A1$Godina[i] <- as.character(paste0(godina,"-",5)),
          "lipanj" = A1$Godina[i] <- as.character(paste0(godina,"-",6)),
          "srpanj" = A1$Godina[i] <- as.character(paste0(godina,"-",7)),
          "kolovoz" = A1$Godina[i] <- as.character(paste0(godina,"-",8)),
          "rujan" = A1$Godina[i] <- as.character(paste0(godina,"-",9)),
          "listopad" = A1$Godina[i] <- as.character(paste0(godina,"-",10)),
          "studeni"  = A1$Godina[i] <- as.character(paste0(godina,"-",11)),
          "prosinac" = A1$Godina[i] <- as.character(paste0(godina,"-",12))
  )
}

#Micanje stupca Mjesec
A1 <- A1[-2]




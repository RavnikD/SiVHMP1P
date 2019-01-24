library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/51116b47-0a2a-40af-bc69-907e2bde8e9c", "Podaci/h-Pasivnekamatestope.xlsx", mode = "wb")

PasivneKamatneStope <- read.xlsx(file = "Podaci/h-Pasivnekamatestope.xlsx", 1, startRow = 9, endRow = 310, as.data.frame = TRUE, header = FALSE)

# Tablica F2 Pasivne Kamatne stope
#
#' @name A1
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export
PasivneKamatneStope$X5 <- NULL
PasivneKamatneStope$X7 <- NULL
PasivneKamatneStope$X18 <- NULL
PasivneKamatneStope$X19 <- NULL

colnames(PasivneKamatneStope) <- c("Godina",
                  "Mjesec",
                  "Kamatne.stope.na.sredstva.izdvojene.obveze",
                  "Kamatne.stope.na.upisane.obvezne.blag.zapisane.HNB",
                  "KSBZ.Od.7.dana",
                  "KSBZ.Od.35.dana",
                  "KSBZ.Od.70.dana",
                  "KSBZ.Od.105.dana",
                  "KSBZSV.Od.35.dana",
                  "KSBZSV.Od.63.dana",
                  "KSBZSV.Od.91.dana",
                  "KSBZSV.Od.182.dana",
                  "KSBZSV.Od.364.dana",
                  "Kamatne.stope.na.prekonocne.depozite.kod.HNB"
)


PasivneKamatneStope$Godina <- as.character(PasivneKamatneStope$Godina)
PasivneKamatneStope$Godina <- as.numeric(PasivneKamatneStope$Godina)

PasivneKamatneStope$Mjesec <- as.character(PasivneKamatneStope$Mjesec)


PasivneKamatneStope$Mjesec <- trimws(PasivneKamatneStope$Mjesec)

for(i in c(1:nrow(PasivneKamatneStope))){
  if(substr(PasivneKamatneStope$Mjesec[i], nchar(PasivneKamatneStope$Mjesec[i]), nchar(PasivneKamatneStope$Mjesec[i])) == ")"){
    PasivneKamatneStope$Mjesec[i] <- substr(PasivneKamatneStope$Mjesec[i], 1, nchar(PasivneKamatneStope$Mjesec[i])-2)
  }
}


PasivneKamatneStope$Mjesec <- trimws(PasivneKamatneStope$Mjesec)

for(i in c(1:nrow(PasivneKamatneStope))){
  if(!is.na(PasivneKamatneStope$Godina[i])){
    godina <- PasivneKamatneStope$Godina[i]
  }
  switch (as.character(PasivneKamatneStope$Mjesec[i]),
          "siječanj" = PasivneKamatneStope$Godina[i] <- as.character(paste0(godina,"-",1)),
          "veljača" = PasivneKamatneStope$Godina[i] <- as.character(paste0(godina,"-",2)),
          "ožujak" = PasivneKamatneStope$Godina[i] <- as.character(paste0(godina,"-",3)),
          "travanj" = PasivneKamatneStope$Godina[i] <- as.character(paste0(godina,"-",4)),
          "svibanj" = PasivneKamatneStope$Godina[i] <- as.character(paste0(godina,"-",5)),
          "lipanj" = PasivneKamatneStope$Godina[i] <- as.character(paste0(godina,"-",6)),
          "srpanj" = PasivneKamatneStope$Godina[i] <- as.character(paste0(godina,"-",7)),
          "kolovoz" = PasivneKamatneStope$Godina[i] <- as.character(paste0(godina,"-",8)),
          "rujan" = PasivneKamatneStope$Godina[i] <- as.character(paste0(godina,"-",9)),
          "listopad" = PasivneKamatneStope$Godina[i] <- as.character(paste0(godina,"-",10)),
          "studeni"  = PasivneKamatneStope$Godina[i] <- as.character(paste0(godina,"-",11)),
          "prosinac" = PasivneKamatneStope$Godina[i] <- as.character(paste0(godina,"-",12))
  )
}

PasivneKamatneStope[11,1] = as.character("1993-10-7")
PasivneKamatneStope[12,1] = as.character("1993-10-31")

PasivneKamatneStope <- PasivneKamatneStope[-2]

PasivneKamatneStope$Kamatne.stope.na.upisane.obvezne.blag.zapisane.HNB <- as.character(PasivneKamatneStope$Kamatne.stope.na.upisane.obvezne.blag.zapisane.HNB)
PasivneKamatneStope$Kamatne.stope.na.upisane.obvezne.blag.zapisane.HNB <- as.numeric(PasivneKamatneStope$Kamatne.stope.na.upisane.obvezne.blag.zapisane.HNB)

PasivneKamatneStope$KSBZ.Od.7.dana <- as.character(PasivneKamatneStope$KSBZ.Od.7.dana)
PasivneKamatneStope$KSBZ.Od.7.dana <- as.numeric(PasivneKamatneStope$KSBZ.Od.7.dana)

PasivneKamatneStope$KSBZ.Od.35.dana <- as.character(PasivneKamatneStope$KSBZ.Od.35.dana)
PasivneKamatneStope$KSBZ.Od.35.dana <- as.numeric(PasivneKamatneStope$KSBZ.Od.35.dana)

PasivneKamatneStope$KSBZ.Od.70.dana <- as.character(PasivneKamatneStope$KSBZ.Od.70.dana)
PasivneKamatneStope$KSBZ.Od.70.dana <- as.numeric(PasivneKamatneStope$KSBZ.Od.70.dana)

PasivneKamatneStope$KSBZ.Od.105.dana <- as.character(PasivneKamatneStope$KSBZ.Od.105.dana)
PasivneKamatneStope$KSBZ.Od.105.dana <- as.numeric(PasivneKamatneStope$KSBZ.Od.105.dana)


PasivneKamatneStope$KSBZSV.Od.35.dana <- as.character(PasivneKamatneStope$KSBZSV.Od.35.dana)
PasivneKamatneStope$KSBZSV.Od.35.dana <- as.numeric(PasivneKamatneStope$KSBZSV.Od.35.dana)

PasivneKamatneStope$KSBZSV.Od.63.dana <- as.character(PasivneKamatneStope$KSBZSV.Od.63.dana)
PasivneKamatneStope$KSBZSV.Od.63.dana <- as.numeric(PasivneKamatneStope$KSBZSV.Od.63.dana)

PasivneKamatneStope$KSBZSV.Od.91.dana <- as.character(PasivneKamatneStope$KSBZSV.Od.91.dana)
PasivneKamatneStope$KSBZSV.Od.91.dana <- as.numeric(PasivneKamatneStope$KSBZSV.Od.91.dana)

PasivneKamatneStope$KSBZSV.Od.182.dana <- as.character(PasivneKamatneStope$KSBZSV.Od.182.dana)
PasivneKamatneStope$KSBZSV.Od.182.dana <- as.numeric(PasivneKamatneStope$KSBZSV.Od.182.dana)

PasivneKamatneStope$KSBZSV.Od.364.dana <- as.character(PasivneKamatneStope$KSBZSV.Od.364.dana)
PasivneKamatneStope$KSBZSV.Od.364.dana <- as.numeric(PasivneKamatneStope$KSBZSV.Od.364.dana)

PasivneKamatneStope$Kamatne.stope.na.prekonocne.depozite.kod.HNB <- as.character(PasivneKamatneStope$Kamatne.stope.na.prekonocne.depozite.kod.HNB)
PasivneKamatneStope$Kamatne.stope.na.prekonocne.depozite.kod.HNB <- as.numeric(PasivneKamatneStope$Kamatne.stope.na.prekonocne.depozite.kod.HNB)

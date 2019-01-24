library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("https://www.hnb.hr/documents/20182/1b7c658b-fb69-4ec6-af80-79674fce00e1", "Podaci/h-J3.xlsx", mode = "wb")

#'  Tablica J3m Indeksi cijena stambenih nekretnina (godisnje)
#
#' @name J3
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export

# UCITAVANJE GODISNJE TABLICE
J3g <- read.xlsx(file = "Podaci/h-J3.xlsx", 1,
                 startRow = 8, endRow = 23, as.data.frame = TRUE, header = FALSE)

#Davanje imena header-ima
colnames(J3g) <- c("Godina",
                   "Tromjesjecje",
                   "BI.Ukupno",
                   "BI.Novi.stambeni.objekti",
                   "BI.Postojeci.stambeni.objekit",
                   "BI.Grad.Zagreb",
                   "BI.Jadran",
                   "BI.Ostalo",
                   "TSP.Ukupno",
                   "TSP.Novi.stambeni.objekti",
                   "TSP.Postojeci.stambeni.objekit",
                   "TSP.Grad.Zagreb",
                   "TSP.Jadran",
                   "TSP.Ostalo",
                   "GSP.Ukupno",
                   "GSP.Novi.stambeni.objekti",
                   "GSP.Postojeci.stambeni.objekit",
                   "GSP.Grad.Zagreb",
                   "GSP.Jadran",
                   "GSP.Ostalo")

#Factor -> char -> numeric
J3g[] <- lapply(J3g, as.character)
for(i in c(2:ncol(J3g))){
  J3g[i] <- as.numeric(unlist(J3g[i]))
}

#Micanje redaka koji su u potpunosti NA
J3g <- J3g[, colSums(is.na(J3g)) != nrow(J3g)]

#Sredivanje godine
J3g$Godina <- as.character(J3g$Godina)
J3g$Godina <- substr(J3g$Godina, 1, 4)

# UCITAVANJE MJESECNE TABLICE
J3m <- read.xlsx(file = "Podaci/h-J3.xlsx", 1,
                 startRow = 17, endRow = 89, as.data.frame = TRUE, header = FALSE)

#Davanje imena header-ima
colnames(J3m) <- c("Godina",
                   "Tromjesjecje",
                   "BI.Ukupno",
                   "BI.Novi.stambeni.objekti",
                   "BI.Postojeci.stambeni.objekit",
                   "BI.Grad.Zagreb",
                   "BI.Jadran",
                   "BI.Ostalo",
                   "TSP.Ukupno",
                   "TSP.Novi.stambeni.objekti",
                   "TSP.Postojeci.stambeni.objekit",
                   "TSP.Grad.Zagreb",
                   "TSP.Jadran",
                   "TSP.Ostalo",
                   "GSP.Ukupno",
                   "GSP.Novi.stambeni.objekti",
                   "GSP.Postojeci.stambeni.objekit",
                   "GSP.Grad.Zagreb",
                   "GSP.Jadran",
                   "GSP.Ostalo")

#Factor -> char -> numeric
J3m[] <- lapply(J3m, as.character)
for(i in c(3:ncol(J3m))){
  J3m[i] <- as.numeric(unlist(J3m[i]))
}

#Sredivanje godine
J3m$Godina <- substr(J3m$Godina, 1, 4)


#Pretvaranje stupca godina u godina-mjesec (YYYY -> YYYY-MM)
for(i in c(1:nrow(J3m))){
  if(!is.na(J3m$Godina[i])){
    godina <- J3m$Godina[i]
  }
  J3m$Godina[i] <- as.character(paste0(godina, "-", substr(J3m$Tromjesjecje[i], 1, 1), "-", "tr"))
}

##Micanje stupca Mjesec
J3m <- J3m[-2]

colnames(J3m)[1] <- "Tromjesjecje"

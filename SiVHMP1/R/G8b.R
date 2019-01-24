library(xlsx)

dir.create("Podaci")

#Download podataka
download.file("http://www.hnb.hr/documents/20182/a78c4e30-a8ef-4e26-bc9f-bcb511ee6430", "Podaci/h-G8b.xlsx", mode = "wb")

#' Tablica G8aG Prinosi do dospijeca na obveznice (godisnji)
#'
#' @name G8bG
#' @author David Ravnik \email{dravnik@unipu.hr}
#' @author Tomislava Kolar \email{tkolar@unipu.hr}
#' @references \url{https://www.hnb.hr/statistika}
#' @keywords dataframe
#' @export


# UCITAVANJE GODISNJE TABLICE
G8bG <- read.xlsx(file = "Podaci/h-G8b.xlsx", 1,
                  startRow = 7, endRow = 24, as.data.frame = TRUE, header = FALSE)

#Davanje imena header-ima
colnames(G8bG) <- c("Godina",
                    "Godina",
                    "USD.2g",
                    "USD.3g",
                    "USD.4g",
                    "USD.5g",
                    "USD.6g",
                    "USD.7g",
                    "USD.8g",
                    "USD.9g",
                    "USD.10g",
                    "EUR.2g",
                    "EUR.3g",
                    "EUR.4g",
                    "EUR.5g",
                    "EUR.6g",
                    "EUR.7g",
                    "EUR.8g",
                    "EUR.9g",
                    "EUR.10g",
                    "HRK.klauzula.EUR.2g",
                    "HRK.klauzula.EUR.3g",
                    "HRK.klauzula.EUR.4g",
                    "HRK.klauzula.EUR.5g",
                    "HRK.klauzula.EUR.6g",
                    "HRK.klauzula.EUR.7g",
                    "HRK.klauzula.EUR.8g",
                    "HRK.klauzula.EUR.9g",
                    "HRK.klauzula.EUR.10g",
                    "HRK.klauzula.EUR.11g",
                    "HRK.klauzula.EUR.12g",
                    "HRK.klauzula.EUR.13g",
                    "HRK.klauzula.EUR.14g",
                    "HRK.klauzula.EUR.15g",
                    "HRK.2g",
                    "HRK.3g",
                    "HRK.4g",
                    "HRK.5g",
                    "HRK.6g",
                    "HRK.7g",
                    "HRK.8g",
                    "HRK.9g",
                    "HRK.10g",
                    "HRK.11g")

#Micanje redaka koji su u potpunosti NA
G8bG <- G8bG[, colSums(is.na(G8bG)) != nrow(G8bG)]

#Factor -> char -> numeric
G8bG[] <- lapply(G8bG, as.character)
for(i in c(2:ncol(G8bG))){
  G8bG[i] <- as.numeric(unlist(G8bG[i]))
}

#Sredivanje godine
G8bG$Godina <- substr(G8bG$Godina, 1, 4)


#' Tablica G8aM Prinosi do dospijeca na obveznice (mjesecni)

# UCITAVANJE MJESECNE TABLICE
G8bM <- read.xlsx(file = "Podaci/h-G8b.xlsx", 1,
                  startRow = 24, endRow = 232, as.data.frame = TRUE, header = FALSE)

#Micanje redaka koji su u potpunosti NA
G8bM <- G8bM[, colSums(is.na(G8bM)) != nrow(G8bM)]

#Davanje imena header-ima
colnames(G8bM) <- c("Godina",
                    "Mjesec",
                    "USD.2g",
                    "USD.3g",
                    "USD.4g",
                    "USD.5g",
                    "USD.6g",
                    "USD.7g",
                    "USD.8g",
                    "USD.9g",
                    "USD.10g",
                    "EUR.2g",
                    "EUR.3g",
                    "EUR.4g",
                    "EUR.5g",
                    "EUR.6g",
                    "EUR.7g",
                    "EUR.8g",
                    "EUR.9g",
                    "EUR.10g",
                    "HRK.klauzula.EUR.2g",
                    "HRK.klauzula.EUR.3g",
                    "HRK.klauzula.EUR.4g",
                    "HRK.klauzula.EUR.5g",
                    "HRK.klauzula.EUR.6g",
                    "HRK.klauzula.EUR.7g",
                    "HRK.klauzula.EUR.8g",
                    "HRK.klauzula.EUR.9g",
                    "HRK.klauzula.EUR.10g",
                    "HRK.klauzula.EUR.11g",
                    "HRK.klauzula.EUR.12g",
                    "HRK.klauzula.EUR.13g",
                    "HRK.klauzula.EUR.14g",
                    "HRK.klauzula.EUR.15g",
                    "HRK.2g",
                    "HRK.3g",
                    "HRK.4g",
                    "HRK.5g",
                    "HRK.6g",
                    "HRK.7g",
                    "HRK.8g",
                    "HRK.9g",
                    "HRK.10g",
                    "HRK.11g")

#Factor -> char -> numeric
G8bM[] <- lapply(G8bM, as.character)
for(i in c(3:ncol(G8bM))){
  G8bM[i] <- as.numeric(unlist(G8bM[i]))
}

#Sredivanje godine
G8bM$Godina <- substr(G8bM$Godina, 1, 4)

#Micanje space-a s kraja mjeseca
G8bM$Mjesec <- trimws(G8bM$Mjesec)

#Pretvaranje stupca godina u godina-mjesec (YYYY -> YYYY-MM)
for(i in c(1:nrow(G8bM))){
  if(!is.na(G8bM$Godina[i])){
    godina <- G8bM$Godina[i]
  }
  switch (as.character(G8bM$Mjesec[i]),
          siječanj = G8bM$Godina[i] <- as.character(paste0(godina,"-",1)),
          veljača = G8bM$Godina[i] <- as.character(paste0(godina,"-",2)),
          ožujak = G8bM$Godina[i] <- as.character(paste0(godina,"-",3)),
          travanj = G8bM$Godina[i] <- as.character(paste0(godina,"-",4)),
          svibanj = G8bM$Godina[i] <- as.character(paste0(godina,"-",5)),
          lipanj = G8bM$Godina[i] <- as.character(paste0(godina,"-",6)),
          srpanj = G8bM$Godina[i] <- as.character(paste0(godina,"-",7)),
          kolovoz = G8bM$Godina[i] <- as.character(paste0(godina,"-",8)),
          rujan = G8bM$Godina[i] <- as.character(paste0(godina,"-",9)),
          listopad = G8bM$Godina[i] <- as.character(paste0(godina,"-",10)),
          studeni  = G8bM$Godina[i] <- as.character(paste0(godina,"-",11)),
          prosinac = G8bM$Godina[i] <- as.character(paste0(godina,"-",12))
  )
}

#Micanje stupca Mjesec
G8bM <- G8bM[-2]

colnames(G8bM)[1] <- "Datum"

library("ggplot2")
library("tidyverse")
library("lubridate")

#'Plotanje f2
#'
#'Funkcija koja plota f2
#'@param stupac predstavlja stupac kojeg korisnik zeli vizualizirati
#'@param nazivStupca predstavlja naziv stupac kojeg korisnik zeli vizualizirati
#'@return plot f2
#'@export

plotPasivneKamatneStope<- function(stupac, Naziv){

  date_df <- PasivneKamatneStope %>%
    mutate(Godina = paste0(Godina, "-01")) %>%
    mutate(Godina = lubridate::ymd(Godina))


  PasivneKamatneStope1 <- ggplot(data =  date_df, aes(x=Godina, y=stupac, group = 1)) +
    geom_line() + labs(x = "Godina", y = Naziv, title = paste("Vizualization", Naziv)) + geom_point()


    PasivneKamatneStope1 <- PasivneKamatneStope1 +
     theme_update(plot.title = element_text(hjust = 0.5))


    return(PasivneKamatneStope1)

 }

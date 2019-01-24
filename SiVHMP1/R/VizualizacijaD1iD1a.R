library("ggplot2")
library("tidyverse")
library("lubridate")

#'Plotanje gd1
#'
#'Funkcija d1
#'@param stupac predstavlja stupac kojeg korisnik zeli vizualizirati
#'@param nazivStupca predstavlja naziv stupac kojeg korisnik zeli vizualizirati
#'@return plot d1
#'@export

plotKonsolidiranabilancaD1<- function(stupac, Naziv){

  date_df <- D1 %>%
    mutate(Datum = paste0(Datum, "-01")) %>%
    mutate(Datum = lubridate::ymd(Datum))


  D1 <- ggplot(data =  date_df, aes(x=Datum, y=stupac, group = 1)) +
    geom_line() + labs(x = "Datum", y = Naziv, title = paste("Vizualization", Naziv)) + geom_point()


  D1 <- D1 +
    theme_update(plot.title = element_text(hjust = 0.5))


  return(D1)

}

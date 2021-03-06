library("ggplot2")
library("tidyverse")
library("lubridate")

#'Plotanje d8
#'
#'Funkcija d8
#'@param stupac predstavlja stupac kojeg korisnik zeli vizualizirati
#'@param nazivStupca predstavlja naziv stupac kojeg korisnik zeli vizualizirati
#'@return plot d8
#'@export

plotDnevniDepozitiD8<- function(stupac, Naziv){

  date_df <- D8 %>%
    mutate(Datum = paste0(Datum, "-01")) %>%
    mutate(Datum = lubridate::ymd(Datum))


  D8 <- ggplot(data =  date_df, aes(x=Datum, y=stupac, group = 1)) +
    geom_line() + labs(x = "Datum", y = Naziv, title = paste("Vizualization", Naziv)) + geom_point()


  D8 <- D8 +
    theme_update(plot.title = element_text(hjust = 0.5))


  return(D8)

}

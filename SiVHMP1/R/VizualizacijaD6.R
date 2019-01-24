library("ggplot2")
library("tidyverse")
library("lubridate")

#'Plotanje d6
#'
#'Funkcija d6
#'@param stupac predstavlja stupac kojeg korisnik zeli vizualizirati
#'@param nazivStupca predstavlja naziv stupac kojeg korisnik zeli vizualizirati
#'@return plot d6
#'@export

plotDepozitninovacD6<- function(stupac, Naziv){

  date_df <- D6 %>%
    mutate(Datum = paste0(Datum, "-01")) %>%
    mutate(Datum = lubridate::ymd(Datum))


  D6 <- ggplot(data =  date_df, aes(x=Datum, y=stupac, group = 1)) +
    geom_line() + labs(x = "Datum", y = Naziv, title = paste("Vizualization", Naziv)) + geom_point()


  D6 <- D6 +
    theme_update(plot.title = element_text(hjust = 0.5))


  return(D6)

}

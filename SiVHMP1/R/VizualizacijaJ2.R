library("ggplot2")
library("tidyverse")
library("lubridate")

#'Plotanje j2
#'
#'Funkcija koja plota j2
#'@param stupac predstavlja stupac kojeg korisnik zeli vizualizirati
#'@param nazivStupca predstavlja naziv stupac kojeg korisnik zeli vizualizirati
#'@return plot j2
#'@export

plotJ2<- function(stupac, Naziv){

  date_df <- J2 %>%
    mutate(Datum = paste0(Datum, "-01")) %>%
    mutate(Datum = lubridate::ymd(Datum))


  J2 <- ggplot(data =  date_df, aes(x=Datum, y=stupac, group = 1)) +
    geom_line() + labs(x = "Datum", y = Naziv, title = paste("Vizualization", Naziv)) + geom_point()


  J2 <- J2 +
    theme_update(plot.title = element_text(hjust = 0.5))


  return(J2)

}

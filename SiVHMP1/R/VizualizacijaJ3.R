library("ggplot2")
library("tidyverse")
library("lubridate")

#'Plotanje j3
#'
#'Funkcija koja plota j3
#'@param stupac predstavlja stupac kojeg korisnik zeli vizualizirati
#'@param nazivStupca predstavlja naziv stupac kojeg korisnik zeli vizualizirati
#'@return plot j3
#'@export


plotJ3<- function(stupac, Naziv){

  date_df <- J3g %>%
    mutate(Godina = paste0(Godina, "-01")) %>%
    mutate(Godina = lubridate::ymd(Godina))


  J3g <- ggplot(data =  date_df, aes(x=Godina, y=stupac, group = 1)) +
    geom_line() + labs(x = "Godina", y = Naziv, title = paste("Vizualization", Naziv)) + geom_point()


  J3g <- J3g +
    theme_update(plot.title = element_text(hjust = 0.5))


  return(J3g)

}

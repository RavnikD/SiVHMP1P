library("ggplot2")
library("tidyverse")
library("lubridate")

#'Plotanje l1
#'
#'Funkcija koja plota l1
#'@param stupac predstavlja stupac kojeg korisnik zeli vizualizirati
#'@param nazivStupca predstavlja naziv stupac kojeg korisnik zeli vizualizirati
#'@return plot l1
#'@export

plotIlaNefinancijskiracuni<- function(stupac, Naziv){

  date_df <- I1a %>%
    mutate(Godina = paste0(Godina, "-01")) %>%
    mutate(Godina = lubridate::ymd(Godina))


  I1a <- ggplot(data =  date_df, aes(x=Godina, y=stupac, group = 1)) +
    geom_line() + labs(x = "Godina", y = Naziv, title = paste("Vizualization", Naziv)) + geom_point()


  I1a <- I1a +
    theme_update(plot.title = element_text(hjust = 0.5))


  return(I1a)

}

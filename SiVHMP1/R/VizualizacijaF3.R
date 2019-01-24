library("ggplot2")
library("tidyverse")
library("lubridate")

#'Plotanje f3
#'
#'Funkcija koja plota f3
#'@param stupac predstavlja stupac kojeg korisnik zeli vizualizirati
#'@param nazivStupca predstavlja naziv stupac kojeg korisnik zeli vizualizirati
#'@return plot f3
#'@export

plotF3<- function(stupac, Naziv){

  date_df <- F3 %>%
    mutate(Godina = paste0(Godina, "-01")) %>%
    mutate(Godina = lubridate::ymd(Godina))


  F3 <- ggplot(data =  date_df, aes(x=Godina, y=stupac, group = 1)) +
    geom_line() + labs(x = "Godina", y = Naziv, title = paste("Vizualization", Naziv)) + geom_point()


  F3 <- F3 +
    theme_update(plot.title = element_text(hjust = 0.5))


  return(F3)

}

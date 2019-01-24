library("ggplot2")
library("tidyverse")
library("lubridate")

#'Plotanje f1
#'
#'Funkcija f1
#'@param stupac predstavlja stupac kojeg korisnik zeli vizualizirati
#'@param nazivStupca predstavlja naziv stupac kojeg korisnik zeli vizualizirati
#'@return plot f1
#'@export

plotF1<- function(stupac, Naziv){

  date_df <- F1 %>%
    mutate(Godina = paste0(Godina, "-01")) %>%
    mutate(Godina = lubridate::ymd(Godina))


  F1 <- ggplot(data =  date_df, aes(x=Godina, y=stupac, group = 1)) +
    geom_line() + labs(x = "Godina", y = Naziv, title = paste("Vizualization", Naziv)) + geom_point()


  F1 <- F1 +
    theme_update(plot.title = element_text(hjust = 0.5))


  return(F1)

}

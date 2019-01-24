library("ggplot2")
library("tidyverse")
library("lubridate")

#'Plotanje A1
#'
#'Funkcija A1
#'@param stupac predstavlja stupac kojeg korisnik zeli vizualizirati
#'@param nazivStupca predstavlja naziv stupac kojeg korisnik zeli vizualizirati
#'@return plot a1
#'@export
plotA1<- function(stupac, Naziv){

  date_df <- A1 %>%
    mutate(Godina = paste0(Godina, "-01")) %>%
    mutate(Godina = lubridate::ymd(Godina))


  A1 <- ggplot(data =  date_df, aes(x=Godina, y=stupac, group = 1)) +
    geom_line() + labs(x = "Godina", y = Naziv, title = paste("Vizualization", Naziv)) + geom_point()


  A1 <- A1 +
    theme_update(plot.title = element_text(hjust = 0.5))


  return(A1)

}

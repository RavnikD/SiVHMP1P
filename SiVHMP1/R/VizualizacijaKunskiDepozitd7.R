library("ggplot2")
library("tidyverse")
library("lubridate")
#'Plotanje d7
#'
#'Funkcija koja plota d7
#'@param stupac predstavlja stupac kojeg korisnik zeli vizualizirati
#'@param nazivStupca predstavlja naziv stupac kojeg korisnik zeli vizualizirati
#'@return plot d7
#'@export


plotKunskiDepozit1 <- function(stupac, Naziv){

  date_df <- KunskiDepozit1 %>%
    mutate(Datum = paste0(Datum, "-01")) %>%
    mutate(Datum = lubridate::ymd(Datum))



  KunskiDepozit <- ggplot(data = date_df, aes(x=Datum, y=stupac, group = 1)) +

    geom_line() + labs(x = "Datum", y = Naziv, title = paste("Vizualization", Naziv)) + geom_point()


  KunskiDepozit <- KunskiDepozit +
    theme_update(plot.title = element_text(hjust = 0.5))


  return(KunskiDepozit)

}

plotKunskiDepozit2 <- function(stupac, Naziv){

  KunskiDepozit <- ggplot(data = KunskiDepozit2, aes(x=Datum, y=stupac, group = 1)) +
    geom_line() + labs(x = "Datum", y = Naziv, title = paste("Godisnja vizualizacija za ", Naziv)) + geom_point()

  KunskiDepozit <- KunskiDepozit +
    theme_minimal() +
    theme_update(plot.title = element_text(hjust = 0.5))  +
    theme_update(axis.text.x = element_text(angle = 90, hjust = 1))
  return(KunskiDepozit)

}




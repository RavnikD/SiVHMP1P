library("ggplot2")
library("tidyverse")
library("lubridate")

#'Plotanje godisnjeg rasta BDP-a
#'
#'Funkcija koja plota godisnji rast BDP-a
#'@param stupac predstavlja stupac kojeg korisnik zeli vizualizirati
#'@param nazivStupca predstavlja naziv stupac kojeg korisnik zeli vizualizirati
#'@return plot godisnjeg BPD-a
#'@export

plotBDPgodina <- function(stupac, Naziv){

  godina <- ggplot(data = BDPgodina, aes(x=Godina, y=stupac, group = 1)) +
    geom_line() + labs(x = "Godina", y = Naziv, title = paste("Godisnja vizualizacija za ", Naziv)) + geom_point()

  theme_update(plot.title = element_text(hjust = 0.5))

  return(godina)
}


#'Plotanje kvartalni rasta BDP-a
#'
#'Funkcija koja plota kvartalni rast BDP-a
#'@param stupac predstavlja stupac kojeg korisnik zeli vizualizirati
#'@param nazivStupca predstavlja naziv stupac kojeg korisnik zeli vizualizirati
#'@return plot kvartalnog BPD-a
#'@export
plotBDPkvartal1 <- function(stupac, Naziv){

  kvartal <- ggplot(data = BDPkvartal, aes(x=Kvartali, y=stupac, group = 1, color = factor(Kvartali))) +
    geom_line() + labs(x = "Kvartali", y = Naziv, title = paste("Godisnja vizualizacija za ", Naziv)) +
    geom_point()

  kvartal <- kvartal +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    theme(legend.position="none") +
    theme(plot.title = element_text(hjust = 0.5, size=14)) +
    theme(axis.title.x = element_text(face = "bold", size=10)) +
    theme(axis.title.y = element_text(face = "bold", size=10)) +
    theme(axis.text.x = element_text(size=7.5)) +
    theme(axis.text.y = element_text(size=10))

  return(kvartal)
}

###########################################
###    TECHNIKI WIZUALIZACJI DANYCH     ###
###           LABORATORIUM 1            ###
###########################################

## 0) Prowadzacy
# Anna Kozak/Mateusz Krzyzinski/Hubert Ruczynski/Mikolaj Spytek 
# Kontakt: MS Teams lub mail
# anna.kozak@pw.edu.pl/mateusz.krzyzinski.stud@pw.edu.pl/hruczynski21@interia.pl/mikolaj.spytek.stud@pw.edu.pl

## 1) Spos�b pracy na zajeciach laboratoryjnych
# a) pracujemy w R (wiekszosc semestru) i Python
# b) pracujemy na przygotowanych plikach, kt�re beda na repozytorium przedmiotu
# c) podczas zajec prowadzacy bedzie wprowadzal zagdanienia, a nastepnie bedzie rozwiazywanie zadan w celu utrwalenia wiadomosci
# d) kolejna porcja materialu bedzie omawiana jezeli wiekszosc grupy wykona zadane zadanie 
# e) wszelkie pytania czy to zwiazane z kodem, praca domowa czy kwestie teoretyczne prosze smialo zglaszac prowadzacemu 

## 2) Materialy
# Repozytorium na GitHub
# https://github.com/mini-pw/2023Z-DataVisualizationTechniques 

## 3) Jak dziala GitHub?
# Jak zglosic prace domowa/projekt? (fork, commit, pull request)
# https://rogerdudler.github.io/git-guide/

## 4) Podstawy R - rozgrzewka

data(mtcars)
head(mtcars)

?mtcars


# Jak wybieramy wiersze (obserwacje) oraz kolumny (zmienne)?

# Pierwszy wiersz, pierwsza kolumna?
mtcars[c(1, 2), 4:5]
mtcars[1,1]

# 10 pierszych wierszy, 2 i 3 kolumna?
mtcars[1:10, 2:3]

# Jak wybieramy kolumny po nazwach? 

# Wszystkie wiersze i kolumny w kolejnosci "am", "wt", "mpg"?
mtcars[, c("am", "wt", "mpg")]

# Jak wybierac jedna kolumne?

# Uwaga na przecinek i wyb�r kolumn poprzez indeksy

# Pytania

# 1. Wymiar ramki danych
+
dim(mtcars)

# 2. Jakie sa typy zmiennych?
str(mtcars)

# 3. Ile jest unikalnych wartosci zmiennej "cyl" i jakie to sa wartosci?
unique(mtcars$cyl)
length(unique(mtcars$cyl))

# 4. Jaka jest srednia wartosc zmiennej "drat" dla samochod�w o wartosci zmiennej "cyl" r�wnej 4?
mean(mtcars[mtcars$cyl==4, c('drat')])

# 5. Jakie sa unikalne wartosci zmiennej "am" i jaki jest ich rozklad (liczba wystapien)? 
unique(mtcars$am)
table(mtcars$am)

# Prosty wykres

# Zaleznosc "mpg" i "hp" - scatter plot
plot(mtcars$mpg, mtcars$hp)

# Zmienna "cyl" - barplot
barplot(mtcars$cyl)

## 4) Gra proton, nalezy stworzyc plik R z kodami do rozwiazania gry (do 20 minut).

install.packages("proton")
library(proton)
proton()

employees[employees$surname == 'Insecure',]
proton(action = "login", login="johnins")

for(y in top1000passwords){
  proton(action = "login", login = "johnins", password = y)
}

employees[employees$surname == 'Pietraszko',]

x <- logs[logs$login == "slap",]
aggregate(x, x[c("host")], length)

proton(action = "server", host="194.29.178.16")

bash_history
for (x in bash_history){
  proton(action = "login", login = "slap", password = x)
}
  
## 5) Umieszczamy rozwiazanie na repozytorium.
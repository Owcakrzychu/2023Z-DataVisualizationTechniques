library(dplyr)

df <- read.csv("house_data.csv")


colnames(df)
dim(df)
apply(df, 2, function(x) sum(is.na(x))) # nie ma wartości NA w żadnej kolumnie

# 1. Jaka jest średnia cena nieruchomości z liczbą łazienek powyżej mediany i położonych na wschód od południka 122W?

df %>% 
  filter(long > -122, bathrooms > median(bathrooms)) %>% 
  summarise(srednia = mean(price))


# Odp: Średnia cena nieruchomości wynosi 625499.4

# 2. W którym roku zbudowano najwięcej nieruchomości?

df %>% 
  group_by(yr_built) %>% 
  summarise(count = n()) %>% 
  top_n(1, count)

# Odp: W roku 2014: 559 nieruchomości

# 3. O ile procent większa jest mediana ceny budynków położonych nad wodą w porównaniu z tymi położonymi nie nad wodą?

mediana1 <- median(df[df$waterfront == 1,"price"])
mediana2 <- median(df[df$waterfront == 0,"price"])

(mediana1 - mediana2)/mediana2

# Odp: Mediana ceny budynków położonych nad wodą w porównaniu z tymi położonymi nie nad wodą jest większa o ok 211%

# 4. Jaka jest średnia powierzchnia wnętrza mieszkania dla najtańszych nieruchomości posiadających 1 piętro (tylko parter) wybudowanych w każdym roku?

df %>% 
  filter(floors == 1) %>% 
  group_by(yr_built) %>% 
  filter(price == min(price)) %>% 
  ungroup %>% 
  summarise(srednia = mean(sqft_living))

# Odp: Średnia powierzchnia wynosi 1030 sqft.

# 5. Czy jest różnica w wartości pierwszego i trzeciego kwartyla jakości wykończenia pomieszczeń pomiędzy nieruchomościami z jedną i dwoma łazienkami? Jeśli tak, to jak różni się Q1, a jak Q3 dla tych typów nieruchomości?

df %>% 
  filter(bathrooms == 1 | bathrooms == 2) %>% 
  summarise(kwantyl = quantile(grade))

# Odp: Dla Q1 wartości wynosi 6, natomiast dla Q4 ta wartośc to 7.

# 6. Jaki jest odstęp międzykwartylowy ceny mieszkań położonych na północy a jaki tych na południu? (Północ i południe definiujemy jako położenie odpowiednio powyżej i poniżej punktu znajdującego się w połowie między najmniejszą i największą szerokością geograficzną w zbiorze danych)

top <- df %>%
  select(lat) %>% 
  top_n(-1, lat) 

bottom <- df %>% 
  select(lat) %>% 
  top_n(1, lat) %>% 
  filter(row_number()==1)

granica <- bottom + (top - bottom)/2



df %>% 
  filter(lat > as.numeric(granica)) %>% 
  summarise(kwartyl = IQR(price))

df %>% 
  filter(lat < as.numeric(granica)) %>% 
  summarise(kwartyl = IQR(price))

# Odp: Dla południa wynosi 122500, dla północy 321000

# 7. Jaka liczba łazienek występuje najczęściej i najrzadziej w nieruchomościach niepołożonych nad wodą, których powierzchnia wewnętrzna na kondygnację nie przekracza 1800 sqft?

df %>% 
  filter(waterfront == 0) %>% 
  mutate(powierzchnia = sqft_living/floors) %>% 
  filter(powierzchnia > 1800) %>% 
  group_by(bathrooms) %>% 
  summarise(n = n()) %>% 
  top_n(1, n)

df %>% 
  filter(waterfront == 0) %>% 
  mutate(powierzchnia = sqft_living/floors) %>% 
  filter(powierzchnia > 1800) %>% 
  group_by(bathrooms) %>% 
  summarise(n = n()) %>% 
  top_n(-1, n)
  
  
  
# Odp: Najczęściej występuje liczba łazienek 1.75, a najrzadziej 0, 1.25, 6.75, 7.5, 7.75 

# 8. Znajdź kody pocztowe, w których znajduje się ponad 550 nieruchomości. Dla każdego z nich podaj odchylenie standardowe powierzchni działki oraz najpopularniejszą liczbę łazienek

moda <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

odp <- df %>% 
  group_by(zipcode) %>% 
  summarise(n = n(), odchylenie = sd(sqft_lot), najpopolarniejsza_liczba_lazienek = moda(bathrooms)) %>% 
  filter(n > 550)


# Odp: odpowiedz znajduje sie w zmiennej odp

# 9. Porównaj średnią oraz medianę ceny nieruchomości, których powierzchnia mieszkalna znajduje się w przedziałach (0, 2000], (2000,4000] oraz (4000, +Inf) sqft, nieznajdujących się przy wodzie.


odp <- df %>% 
  filter(waterfront==0) %>% 
  mutate(przedzialy = case_when(sqft_living <= 2000 ~ "(0, 2000]",
                                sqft_living <= 4000 ~ "(2000,4000]",
                                sqft_living > 4000 ~ "(4000, +Inf)")) %>% 
  group_by(przedzialy) %>% 
  summarise(srednia = mean(price), mediana = median(price))

# Odp: Średnie to odpowiednio dla poziomów: 385084.3, 645419, 1338118.8
#      Mediany to odpowiednio dla poziomów: 359000, 595000, 1262750

# 10. Jaka jest najmniejsza cena za metr kwadratowy nieruchomości? (bierzemy pod uwagę tylko powierzchnię wewnątrz mieszkania)

df %>% 
  mutate(cena_za_metr = price/(sqft_living*0.09290304)) %>% 
  top_n(-1, cena_za_metr) %>% 
  select(cena_za_metr)

# Odp: Najniższa cena to 942.7919 USD/m^2 
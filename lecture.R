

# Data management for educational testing ---------------------------------



# You will get this file at the end, you don't need to type along!


# Goal: adopt a relational methodology for educational data



# This is something that you typically learn on the job.
# It is absolutely impossible to teach it in a 3 hour course.
# so, my apologies upfront



# Structure ---------------------------------------------------------------



# To manage educational data successfully you need to:

# 1. know how data should be stored to minimize the potential for errors
# 2. know the dimensions and requirements of your data
# 3. develop a data model
# 4. learn the necessary skills to massage real world data into your data model


# We will learn the general principles for (1)
# discus how to apply them to (2)
# Use the dexter data model in (3)
# practice with (4)

# This will all seem relatively easy until we finish with a real world assignment

# The plan is to start with this assignment no later than 11.00 so you can ask some questions 
# during the first part and finish at home




# How data should be stored -----------------------------------------------


# Any questions about R4DS chapters 12 and 13?




# What does educational data look like in long / tidy form?

# principles:

# Each variable must have its own column.
# Each observation must have its own row.
# Each value must have its own cell.

# rows and columns in educational data are:












# kolommen:

# antwoorden op vragen/vragenlijsten
# versie van een toets
# school nr
#X total test scores
#X model scores/plausible values
# landen van afkomst
# student nr
# leerlinggewichten

# =>
# persoon, item, antwoord -> in tidy dat model kun je daar van alles achter plakken
# key is persoon+item
# praktisch betekent dit dat de combinatie persoon+item maar 1 keer in deze tabel voor kan komen

# rij:
# observatie: persoon 14 antwoord G op item I1349







# How data is often stored ------------------------------------------------



library(dexter)
verbAggrData[1:10,1:10]


# assignment (10 minutes):

# transform verbAggrData into a tidy format
# using functions from base R and/or the tidyverse packages


# follow up question:
# what would in this case be the difference between the relational and the tidy format?







# Relational data ---------------------------------------------------------

# 1 fact, 1 place, 1 time

# keys and relational constraints




# further reading: Joe Celko; SQL for smarties; chap.  1-3





# The verbal Aggression data consists of a single test form

# In dexter it works like this

db = start_new_project(verbAggrRules, 
                       db_name = ':memory:',
                       person_properties = list(gender='unknown', anger=as.integer(NA)))

add_booklet(db, verbAggrData, 'VA questionnaire')

# stel je hebt al long format data: 
# add_response_data voegt data in tidy format toe


# What does the dexter db look like?

er_plot(db)

# To which table would you add: 
#   the text of an item?
#   response time?

# think of any variables that could be added to each of the other tables


# To extract tidy data from this relational model, use

?get_responses



# many booklets -----------------------------------------------------------

# Educational datasets often consist of many overlapping booklets, i.e. an incomplete design


# typical data
# this is called "compressed format"

# 45098  5098  F 2  D2 4 4 5  6 18 18  16 96  16 96|101100101000000100001100000
# 45099  5099  F 2  D2 4 4 5  6 20 16  16 96  16 96|101100101000000110001100000
# 45102  5102  M 1  D2 4 4 5  6 14 12  16 96  16 96|100000000110110010000000010
# 45103  5103  F 2  D2 4 4 5  6 21 15  16 96  16 96|110100101010000100110000110
# 45236  5236  M 1  D2 4 4 5  6 26 29  16 96  16 96|100111110000011110111100110
# 10697   697  - 3  D2 1 3 0 10  0 21   3  3  97 97|000000000000000000000000000
# 15084  5084  M 1  D2 1 1 0  4  0 26   1  1  97 97|000000000000000000000000000
# 20143   143  F 2  D2 2 2 5  6 37  0   6 86  98 98|100011011111110011111010101
# 20432   432  M 1  D2 2 1 0  4  2  0   5  5  98 98|000011000000000000000000000
# 22515  2515  M 1  D2 2 1 5  6 11  0   5 85  98 98|000011001010000010010100000
# 22880  2880  F 2  D2 2 2 0  8  7  0   6  6  98 98|011010010010000000000000000

#  ^                                           ^        ^ responses ^
#  probably person id                          |
#                                              probably booklet id 

# What are the strengths and weaknesses of this dataformat?

# What would you need to do to transform this to a tidy format?


# 1. maak er een data.frame van met individuele antwoorden in kolommen
# 2. documenteer je aannames
# 3. scheid persoonskenmerken en data
# 4. naar long format
# probleem: geen item identificatie
# vergeleken met het eerdere voorbeeld heb je hier een incompleet design
# bij dit soort bestanden heb je vaak een design bestand -> welke items in welk boekje
# boekje 97: lijst met item id's in de volgorde van afname
# dus: maak item positie kolom aan om te joinen met het design


# other common format is the extended format
# e.g. R packages TAM and mirt




# Opdracht: Data van het vergelijkingsonderzoek referentiesets Lezen

# Op http://www.toetsspecials.nl/html/referentiesets_openbaar/taal.shtm
# staat de data voor het vergelijkingsonderzoek referentiesets lezen.

# Deze is redelijk beroerd.

# Aan jullie de taak om deze dataset om te zetten in een vorm waar je een analyse mee kan doen.

# a) bewerk de data en zet deze in een dexter database. 
# b) Evalueer de uiteindelijke kwaliteit van de data. Bijv.
#    - Heb je alle fouten er uit gehaald?
#    - Hoe schat je de kans in dat er nog fouten in zitten die je niet hebt gevonden?
#    - Zo ja, waar zullen die zitten? Zijn ze in principe wel of niet te achterhalen?

# handmatige databewerking is verboden

# Aanwijzingen:

# Werk samen, verdeel zo mogelijk het werk maar zorg dat je alle aspecten meekrijgt
# Je eindproduct bevat zowel code, commentaar en conclusies. Maak deze in Rmarkdown maar
# begin met scripts

# Data:
# Lees zorgvuldig de toelichting op http://www.toetsspecials.nl/html/referentiesets_openbaar/taal.shtm

# De dataset is onderverdeeld per populatie maar het betreft één enkele verbonden dataset, je dient
#   deze dus te combineren.

# Ga er nooit zomaar vanuit dat data kloppen zonder dat te controleren. Controleer met name
# of identificaties (persoon, item, boekje) wel uniek zijn en of hetzelfde item-antwoord altijd gelijk 
# wordt gescoord

# De csv bestanden zijn gedeeltelijk onjuist opgeslagen. Voor het downloaden van de bestanden en het inlezen 
#   in een data.frame heb ik hieronder een script en functie beschikbaar gesteld. 

# Er zijn 3 soorten bestanden: extended, design en antwoorden. Je hebt ze allemaal nodig. Design heeft op elke
# regel in de eerste kolom het boekjesnummer (boekjes identificatie) gevolgd door de id's van de items in dat boekje.


library(xml2)
library(dplyr)
library(tidyr)
library(stringr)
library(stringi)

# data waar:
url = 'http://www.toetsspecials.nl/html/referentiesets_openbaar/taal.shtm'
doc = read_html(url)

# het is leesvaardigheid maar wordt taal genoemd

filenames = xml_find_all(doc, "//a[contains(@href,'csv') ]/@href") %>% 
  xml_text() %>%
  paste0('http://www.toetsspecials.nl', .)

# dit zijn de bestanden die je hebt
filenames



# functie om de csv's te lezen
# see ?read.csv2 for the ... arguments
read_messy_csv = function(file_url, ...)
{
  tmp = tempfile(fileext='.csv')
  download.file(url=file_url, destfile=tmp)
  # het probleem is missende cellen aan het eind van de rijen
  # gelukkig zijn er geen strings met quotes, dus deze simpele fix werkt
  l = readLines(tmp)
  sp = str_count(l,';')
  ncol = max(sp)
  l = paste0(l, sapply(ncol-sp, function(x) paste0(rep(';',x), collapse='')))
  writeLines(l,tmp)
  
  read.csv2(tmp, ...) 
}

# test functie
filenames[1]
df1 = read_messy_csv(filenames[1])
filenames[2]
df2 = read_messy_csv(filenames[2], header=F)
filenames[3]
df3 = read_messy_csv(filenames[3], header=F)

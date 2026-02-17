source("src/functions.R")

Annee <- 2025
Mois <- 11

sqlQuery <- sprintf("select * from vuecube where year(datevol)=%s and month(datevol)=%s", Annee, Mois)
outputFile    <- sprintf("vueCube%s%02d.csv", Annee, Mois)

if(get_os()=="windows") {
  jPath <- "J:/Etudes/1 - Public/ATN"
} else
  #jPath <- "/home/rserver/stat"    # Ne fonctionne pas sur RSERVER3
  jPath <- "."                      # Dans ce cas, crée le zip dans le dossier du projet

outputFileZip <- sprintf("%s/%s.zip", jPath, tools::file_path_sans_ext(outputFile))

con <- get_con()
DATA <- as.data.table(dbGetQuery(con,sqlQuery))
dbDisconnect(con)
DATA[, dateSaisie:=as.Date(dateSaisie)]
DATA[, dateVol:=as.Date(dateVol)]

fwrite (DATA, outputFile, sep = "|")

if(get_os()=="windows") {
  system(sprintf('"%s" -a -c -f "%s" "%s"', "C:/Windows/System32/tar.exe", outputFileZip, outputFile))
} else {
  print(zip(zipfile = outputFileZip, files = outputFile))
}
  
file.remove(outputFile)

library(DBI)
library(data.table)
library(odbc)
library(ini)

params <- read.ini("conf.ini")

get_os <- function(){
  # Return 'windows' | 'osx' | 'linux'
  sysinf <- Sys.info()
  if (!is.null(sysinf)){
    os <- sysinf['sysname']
    if (os == 'Darwin') os <- "osx"
  } else {
    os <- .Platform$OS.type
    if (grepl("^darwin", R.version$os)) os <- "osx"
    if (grepl("linux-gnu", R.version$os)) os <- "linux"
  }
  tolower(os)
}

get_con <- function(){
  if(get_os()=="windows")
    con <- dbConnect(odbc::odbc(),Driver = "SQL Server", Server = params$SQL$SERVER,Database = params$SQL$DATABASE, encoding = "UTF-8")
  else
    con <- dbConnect(odbc::odbc(),Driver = "ODBC Driver 18 for SQL Server", Server = params$SQL$SERVER,Database = params$SQL$DATABASE, UID = params$SQL$USER, PWD = params$SQL$PASSWORD, TrustServerCertificate="yes", encoding="UTF-8")
  con
}
rm(list = ls())
library(googledrive)
library(lubridate)
library(tidyverse)
library(gridExtra)
library(outliers)
library(plotly)
library(raster)
library(mmand)
library(Orcs)
library(rgee)
library(zip)
library(sf)

source("script/demo.R")
source("script/functions.R")

ee_Initialize()

drive_auth("s1078735@stud.sbg.ac.at")
# drive_auth("datasetfprudencio@gmail.com")


##################### CHICOS #####################

# # Generar un .svg para cada imagen.
# generate_preview()
# 
# # Subir todos los resultados de Google Drive
# httr::set_config(httr::config( ssl_verifypeer = 0L))
# httr::set_config(httr::config(http_version = 0))
# upload_results()
# 
# # Subir solo los svgs
# upload_preview()

##################### CHICOS #####################

# Funciones auxiliares para descargar
pt <- "point_0101"
download_viz(point = pt)
# download_thumbnails(point = "point_1382")
# download_labels(point = "point_1382")

# Funciones auxiliares para Cirrus and shadow
pt_list <- list.files(
  sprintf("/home/fernando/Documentos/%1s/viz", pt),
  pattern = ".svg", full.names = T
)

id <- basename(pt_list[5]) %>% str_sub(1, -5)
map_results <- s2_comparison(point = pt, id, max = c(4000, 2000))
map_results$rgb
map_results$cirrus

coordx <- " lon: -70.42044 | lat: -27.73097 | zoom: 16 "
display_app(coordx, id, cc = 5) 
# display_app(coordx, id, cc = 5, range = 8)
date_delete <- c(
  seq(
    as.Date("2019-02-01", "%Y-%m-%d"),
    as.Date("2019-02-09", "%Y-%m-%d"),
    "day"
  )
)

# Hampel filter  https://statsandr.com/blog/outliers-detection-in-r/
display_ts(id, dir_name = "/home/fernando/Descargas/", file = "ee-chart.csv", date_delete =  NULL)

file.remove("/home/fernando/Descargas/ee-chart.csv")


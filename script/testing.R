setwd("C:/Users/ryali93/Desktop/cloudsen12/script")
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

source("https://gist.githubusercontent.com/csaybar/daa1a877f3d1703b61846603e986b14c/raw/3fa6634a3348140ad6b7a1cb72106c13219bf294/demo.R")
source("https://gist.githubusercontent.com/csaybar/daa1a877f3d1703b61846603e986b14c/raw/8862f01b7564926d88f37a15d2d02c12dd373daf/demo.R")

ee_Initialize()

drive_auth("s1078735@stud.sbg.ac.at")

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
download_viz(point = "point_0085")
# download_thumbnails(point = "point_1382")
# download_labels(point = "point_1382")

# Funciones auxiliares para Cirrus and shadow
id <- "20190623T182921_20190623T183717_T11TPJ"
map_results <- s2_comparison(point = "point_0085", id, max = c(4000, 3000))
map_results$rgb
map_results$cirrus

coordx <- " lon: -115.05640 | lat: 44.00710 | zoom: 12 "
display_app(coordx, id, cc = 5, range = 6)
date_delete <- c(
  seq(
    as.Date("2019-02-01", "%Y-%m-%d"),
    as.Date("2019-02-09", "%Y-%m-%d"),
    "day"
  )
)

# Hampel filter  https://statsandr.com/blog/outliers-detection-in-r/
display_ts(id, dir_name = "C:/Users/ryali93/Downloads", file = "ee-chart.csv", date_delete =  NULL)
display_ts <- function(id, date_delete = as.Date("2022-01-01"), file = "ee-chart.csv", dir_name = "/home/csaybar/Downloads/") {
  f_csv <- read.csv(sprintf("%s/%s", dir_name, file))
  dates <- parse_date(as.character(f_csv$system.time_start), "%b %d, %Y")
  values_1 <- as.numeric(apply(f_csv[-1], 2, function(x) mean(as.numeric(gsub(",", "", x)), na.rm=TRUE)))
  title <- gsub("\\d{2,4}\\.\\d{2}\\.\\d{2}|\\.", "", colnames(f_csv[2]))
  if (title == "B2") {
    title <- "blue"
  } else if (title == "B11") {
    title <- "SWIR_01"
  }
  
  df_t <- tibble(dates = dates, values = values_1)
  
  # remove image to analyze
  img_id_to_exclude <- ee$Image(sprintf("COPERNICUS/S2/%s", id))
  date_to_an <- as.Date(ee_get_date_img(img_id_to_exclude)[["time_start"]])
  value_hline <- (df_t %>% filter(dates %in% date_to_an))$values
  
  df_t <- df_t %>% 
    filter(!dates %in% date_delete) %>% 
    filter(!dates %in% date_to_an)
  
  lower_bound <- median(df_t$values) - 3.5 * mad(df_t$values)
  upper_bound <- median(df_t$values) + 3.5 * mad(df_t$values)
  
  
  g1 <- ggplot(df_t, aes(x=dates, y = values)) +
    geom_point() +
    geom_line() +
    geom_hline(yintercept = lower_bound, col = "blue") + 
    geom_hline(yintercept = value_hline, col = "red") + 
    geom_hline(yintercept = upper_bound, col = "blue") + 
    theme_classic()+ 
    ggtitle(title)
  ggplotly(g1)
}

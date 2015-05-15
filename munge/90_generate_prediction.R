predict_simple = function(D) {
  D %<>% filter(level==9)
  
  D %>% 
    select(TRIP_ID) %>% 
    mutate(
      method = "simple",
      lat = 41.162142,
      lon = -8.621953,
      time = (83423824 * 15) / 1705015
    ) %>% 
    collect
}

predict_random = function(D, GHINFO) {
  D %<>% filter(level==9)
  
  len = D %>% collect %>% nrow
  
  STATS = GHINFO %>% 
    filter(level==9) %>% 
    summarise_each( funs(mean, sd), lon, lat) %>% 
    collect
  
  D %>% 
    select(TRIP_ID) %>% 
    collect %>% 
    mutate(
      method = "random",
      lat = rnorm(len, STATS$lat_mean, STATS$lat_sd),
      lon = rnorm(len, STATS$lon_mean, STATS$lon_sd),
      time = pmax(15, rnorm(len, 711.4351, 663.7596))
    )
}

# predict_ez3fh_ez3f5_self_route = function(D) {
# }

TEST = TEST_RAW %>% 
  left_join(TRIP_DETAILS, by="TRIP_ID")

PRED = bind_rows(
    predict_simple(TEST),
    predict_random(TEST, GHINFO)
  )
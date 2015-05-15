# Example format for LOCATION

# TRIP_ID, LATITUDE, LONGITUDE
# T1, 41.146504,-8.611317
# T2, 42.230000,-8.629454
# T10, 42.110000,-8.721111

write_submission_loc = function(D) {
  type = unique(D$method)
  filename = sprintf("reports/submission/submission_loc_%s_%s.csv", type, as.YYYYMMDD(now()))
  
  D = D %>% 
    select(TRIP_ID, lat, lon) %>% 
    collect()
  names(D) = c("TRIP_ID", "LATITUDE", "LONGITUDE")
  write.table(D, filename, quote=FALSE, sep=",", row.names=FALSE)
}

# Example format for TIME
# TRIP_ID,TRAVEL_TIME
# T1,60
# T2,90
# T3,122

write_submission_time = function(D) {
  type = unique(D$method)
  filename = sprintf("reports/submission/submission_time_%s_%s.csv", type, as.YYYYMMDD(now()))
  
  D = D %>% 
    select(TRIP_ID, time) %>% 
    collect()
  
  names(D) = c("TRIP_ID", "TRAVEL_TIME")
  write.table(D, filename, quote=FALSE, sep=",", row.names=FALSE)
}

PRED %>% 
  group_by(method) %>% 
  do({
    write_submission_loc(.)
    write_submission_time(.)
    data.frame()
  })
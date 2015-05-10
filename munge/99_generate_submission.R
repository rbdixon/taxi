# Example format for LOCATION

# TRIP_ID, LATITUDE, LONGITUDE
# T1, 41.146504,-8.611317
# T2, 42.230000,-8.629454
# T10, 42.110000,-8.721111

write_submission_loc = function(D) {
  D = collect(D)
  names(D) = c("TRIP_ID", "LATITUDE", "LONGITUDE")
  write.table(D, "reports/submission/submission_loc.csv", quote=FALSE, sep=",", row.names=FALSE)
}

# Example format for TIME
# TRIP_ID,TRAVEL_TIME
# T1,60
# T2,90
# T3,122

write_submission_time = function(D) {
  D = collect(D)
  names(D) = c("TRIP_ID", "TRAVEL_TIME")
  write.table(D, "reports/submission/submission_time.csv", quote=FALSE, sep=",", row.names=FALSE)
}

# Hokey submission to location contest
TEST_RAW %>% 
  select(TRIP_ID) %>% 
  mutate(
    lat = 41.162142,
    lon = -8.621953
  ) %>% 
  write_submission_loc()

# Hokey submission to time contest
# SELECT count(*) FROM traj WHERE level=9; -> 83423824
# SELECT count(distinct("TRIP_ID")) FROM traj WHERE level=1; -> 1705015
TEST_RAW %>% 
  select(TRIP_ID) %>% 
  mutate(
    time = (83423824 * 15) / 1705015
  ) %>% 
  write_submission_time()
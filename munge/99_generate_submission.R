# Example format:

# TRIP_ID, LATITUDE, LONGITUDE
# T1, 41.146504,-8.611317
# T2, 42.230000,-8.629454
# T10, 42.110000,-8.721111

write_submission_loc = function(D) {
  D = collect(D)
  names(D) = c("TRIP_ID", "LATITUDE", "LONGITUDE")
  write.table(D, "reports/submission/submission_loc.csv", quote=FALSE, sep=",", row.names=FALSE)
}

# Hokey submission
TEST_RAW %>% 
  select(TRIP_ID) %>% 
  mutate(
    lat = 41.162142,
    lon = -8.621953
  ) %>% 
  write_submission_loc()
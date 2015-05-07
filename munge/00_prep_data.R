prep_data = function(D) {
  D %>%
    mutate_each( funs(factor), CALL_TYPE, ORIGIN_CALL, ORIGIN_STAND, TAXI_ID, DAY_TYPE) %>% 
    mutate(
      MISSING_DATA = MISSING_DATA == "True"
    )
}

TEST = prep_data(TEST_RAW)
TRAIN = prep_data(TRAIN_RAW)
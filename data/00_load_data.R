TEST_RAW = read.csv("kaggledata/test.csv", stringsAsFactors=FALSE) %>% 
  tbl_df
cache("TEST_RAW")

TRAIN_RAW = read.csv("kaggledata/train.csv", stringsAsFactors=FALSE) %>% 
  tbl_df
cache("TRAIN_RAW")
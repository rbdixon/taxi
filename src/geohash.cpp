// From: http://mertensu.github.io/technical/2015/04/01/geohash/

#include <Rcpp.h>
#include <stdio.h>
#include <string>
using namespace Rcpp;


// [[Rcpp::export]]
std::string geohash_encode(double latitude, double longitude, int precision=12){
  
  double lat_min = -90, lat_max = 90;
  double lon_min = -180, lon_max = 180;
  
  std::string __base32  ("0123456789bcdefghjkmnpqrstuvwxyz");
  std::string geohash = "";
  int bits[5] = {16, 8, 4, 2, 1 };
  int bit = 0;
  int ch = 0;
  double mid = 0;
  bool even = true;
  
  while (geohash.size() < precision){
    
    if (even){ //
      mid = (lon_min + lon_max)/2;
      if (longitude > mid)
      {
        ch |= bits[bit];
        lon_min = mid; 
      }
      else
      {
        lon_max = mid;
      }
    }
    else{ // uneven
      mid = (lat_min + lat_max)/2;
      if (latitude > mid)
      {
        ch |= bits[bit];
        lat_min = mid;
      }
      else
      {
        lat_max = mid;
      }
    }
    even = not even;
    if (bit < 4)
    {
      bit += 1;
    }
    else
    {
      geohash += __base32[ch];
      bit = 0;
      ch = 0;
    }
    
    
  }
  return geohash;
}
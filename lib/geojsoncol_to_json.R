geojsoncol_to_fc = function(jgc) {
  feature_template = '{ "type": "Feature", "geometry": %s, "properties": {} }'
  feature_collection_template = '{ "type": "FeatureCollection", "features": [ %s ] }'
  
  sprintf( feature_collection_template,
           paste(sprintf(feature_template, jgc), collapse=", ")
  )
}
flutter pub run pigeon \
  --input pigeon_generate/viewAnnotation/viewAnnotation.dart \
  --dart_out pigeon_generate/viewAnnotation/output/viewAnnotation.g.dart \
  --objc_header_out pigeon_generate/viewAnnotation/output/viewAnnotation.g.h \
  --objc_source_out pigeon_generate/viewAnnotation/output/viewAnnotation.g.m \
  --objc_prefix 'FLT' \
  --java_out pigeon_generate/viewAnnotation/output/FLTViewAnnotation.java \
  --java_package "com.mapbox.maps.pigeons"
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapModel extends Equatable {
  final List<Placemark> placeMark;
  final Completer<GoogleMapController> completer;
  final Set<Marker> markers;
  final CameraPosition cameraPosition;

  const MapModel({
    required this.cameraPosition,
    required this.completer,
    required this.markers,
    required this.placeMark,
  });

  @override
  List<Object?> get props => [cameraPosition, completer, markers, placeMark];
}

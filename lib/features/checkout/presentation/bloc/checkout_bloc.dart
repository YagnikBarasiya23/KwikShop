import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kwikshop/features/checkout/domain/entity/map_model.dart';

import '../../../../injection_container.dart';
import '../../domain/usecase/checkout_usecase.dart';


part 'checkout_event.dart';

part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    on<OnLoadLocation>(
      (event, emit) => CheckoutLoad(
        mapModel: MapModel(
          cameraPosition: const CameraPosition(target: LatLng(0, 0)),
          completer: Completer(),
          markers: const {},
          placeMark: const [],
        ),
      ),
    );
    on<CurrentLocationEvent>((event, emit) async {
      double latitude = 0;

      double longitude = 0;

      List<Placemark>? placeMark;

      final Completer<GoogleMapController> completer = Completer();

      final Set<Marker> markers = {};

      Future<Position> determinePosition() async {
        LocationPermission permission;
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            return Future.error('Give permission');
          }
        }
        return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation);
      }

      Position position = await determinePosition();
      latitude = position.latitude;
      longitude = position.longitude;

      placeMark = await placemarkFromCoordinates(latitude, longitude);

      markers.add(
        Marker(
          markerId: const MarkerId('1'),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(latitude, longitude),
        ),
      );

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 19,
        tilt: 37,
      );
      final GoogleMapController googleMapController = await completer.future;
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      checkoutInjection.get<CheckoutLocationDetailsUseCase>().call(
            params: LocationDetails(
                placeMark: placeMark, latitude: latitude, longitude: longitude),
          );
      emit(
        CheckoutLoad(
          mapModel: MapModel(
            cameraPosition: cameraPosition,
            completer: completer,
            markers: markers,
            placeMark: placeMark,
          ),
        ),
      );
    });
  }
}

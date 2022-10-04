import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GeoLocatorController extends GetxController {

  Rxn<Position> myPos = Rxn<Position>();

  Position givenPos = Position.fromMap({'latitude' : 37.090200, 'longitude' :  -95.712900});

}
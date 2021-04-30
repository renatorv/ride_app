import 'package:flutter/material.dart';
import 'package:ride_app/models/address.dart';

class AppData extends ChangeNotifier {
  Address pickUpLocation;

  void updatePickUpLocationAddress(Address pickUpAddress) {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }
}

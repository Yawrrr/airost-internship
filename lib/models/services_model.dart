// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class ServiceModel {
  String name;
  String iconpath;

  ServiceModel({
    required this.name,
    required this.iconpath,
  });

  static List<ServiceModel> getService() {
    List<ServiceModel> services = [];

    services.add(ServiceModel(name: 'Ride', iconpath: 'assets/icons/ride.png'));
    services.add(
        ServiceModel(name: 'Express', iconpath: 'assets/icons/express.png'));
    services.add(ServiceModel(name: 'Food', iconpath: 'assets/icons/food.png'));

    return services;
  }
}

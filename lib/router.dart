import 'package:flutter/cupertino.dart';
import 'package:ventimetriappclienti/screen/home.dart';

class Routes {
  static Map<String, StatefulWidget Function(dynamic context)> routes = {
    Home.routeName: (context) => const Home(),
  };
}
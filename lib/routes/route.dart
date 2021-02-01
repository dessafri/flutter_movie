import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieku/pages/home.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Homepage());
    }
  }
}

import 'package:flamenco_remote/views/home.dart';
import 'package:flamenco_remote/views/job_details.dart';
import 'package:flamenco_remote/views/login.dart';
import 'package:flutter/material.dart';

class RouterApp {
  static getInitialRoute() => "/login";
  static Map<String, Widget Function(BuildContext)> genRoutes() => {
    "/login": (context) => LoginView(), 
    "/home": (context) => HomeView(), 
    "/project": (context) => JobDetailView(), 
  };
}

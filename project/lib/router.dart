import 'package:flutter/material.dart';
import 'package:project/widget/authen.dart';
import 'package:project/widget/my_service.dart';
import 'package:project/widget/register.dart';


final Map<String ,WidgetBuilder> routes = {
  '/authen': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => Register(),
  '/myService': (BuildContext context) => MyService(),
};
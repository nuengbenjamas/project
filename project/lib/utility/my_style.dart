import 'package:flutter/material.dart';

class Mystyle{

  Color darkColor = Color(0xffec407a);
  Color primaryColor = Color(0xfff06292);
  Color lightColor = Color(0xfff48fb1);

  BoxDecoration boxDecoration () => BoxDecoration(
          borderRadius: BorderRadius.circular(20), 
          color: Colors.white10
          );

  get backgroundColor => null;

  TextStyle redBoldStyle() => TextStyle(
      color: Colors.pink.shade700,
      fontWeight: FontWeight.bold,     
  );


Widget showLogo() => Image.asset('images/logo.png');

Widget titleH1(String string) => Text(
  string,style: TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  color: darkColor,
  ),
);

Widget titleH2(String string) => Text(
  string,style: TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: darkColor,
  ),
);

Widget titleH3(String string) => Text(
  string,style: TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: darkColor,
  ),
);

Widget titleH2White(String string) => Text(
  string,style: TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  ),
);

Widget titleH3White(String string) => Text(
  string,style: TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.white60,
  ),
);

  Mystyle();
}
import 'package:flutter/material.dart';
import 'package:project/utility/my_style.dart';


Future<Null> normalDialog(BuildContext context,String string) async {
  showDialog(context: context, 
  builder: (context) => SimpleDialog(title: ListTile(
    leading: Image.asset('images/logo.png'),
    title: Text(
      'Normal Dialog',
      style: Mystyle().redBoldStyle(),
      ),
    subtitle: Text(string),
    ),
    children: [
      TextButton(
        onPressed: () =>  Navigator.pop(context) , 
        child: Text('OK')
        )
    ],
  ),

);

}
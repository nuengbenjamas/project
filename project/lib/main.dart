import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/router.dart';

String initialRoute = '/authen';
Future<Null>main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    // ignore: await_only_futures
    await FirebaseAuth.instance.authStateChanges().listen((event) { 
      if(event != null){
        initialRoute = '/myService';
      }
      runApp(MyApp());
    });
  });
} 


class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      initialRoute: initialRoute,
    );
  }
}
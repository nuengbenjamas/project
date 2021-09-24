import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/utility/dialog.dart';
import 'package:project/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  late double screen;
  bool statusRedEye = true;
  late String user, password;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    print('screen = $screen');
    return Scaffold(
      floatingActionButton: buildRegister(),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
              radius: 1.0,
              colors: <Color>[Colors.white10, Mystyle().lightColor]),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildLogo(),
                Mystyle().titleH1('borrowing of books'),
                buildUser(),
                buildPassword(),
                buildLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  TextButton buildRegister() => TextButton(
        onPressed: () => Navigator.pushNamed(context, '/register'),
        child: Text(
        'No have Account ? Create Account',
           
          style: TextStyle(fontSize: 18, color: Colors.blue),
          ),
    );

  Container buildLogin() {
    return Container(
        margin: EdgeInsets.only(top: 16),
        width: screen * 0.75,
        child: ElevatedButton(
          onPressed: () {
            if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
              normalDialog(context, 'Have Space ? Please Fill Every Blank');
            } else {
              checkAuthen();
            }
          },
          child: Text('Login'),
          style: ElevatedButton.styleFrom(
            primary: Mystyle().darkColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ));
  }

  Container buildUser() {
    var textField = TextField(
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => user = value.trim(),
      style: TextStyle(color: Mystyle().darkColor),
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Mystyle().darkColor),
        hintText: 'User:',
        prefixIcon: Icon(
          Icons.perm_identity_sharp,
          color: Mystyle().darkColor,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Mystyle().darkColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Mystyle().lightColor)),
      ),
    );
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white10),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: textField,
    );
  }

  Container buildPassword() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), 
          color: Colors.white10
          ),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: statusRedEye,
        style: TextStyle(color: Mystyle().darkColor),
        decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: statusRedEye
                  ? Icon(Icons.remove_red_eye_sharp)
                  : Icon(Icons.remove_red_eye_outlined),
              onPressed: () {
                setState(() {
                  statusRedEye = !statusRedEye;
                });
                print('statusRedEye = $statusRedEye');
              }),
          hintStyle: TextStyle(color: Mystyle().darkColor),
          hintText: 'Password:',
          prefixIcon: Icon(
            Icons.lock_outline_sharp,
            color: Mystyle().darkColor,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Mystyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Mystyle().lightColor)),
        ),
      ),
    );
  }

  Container buildLogo() {
    return Container(
      width: screen * 0.4,
      child: Mystyle().showLogo(),
    );
  }

  // ignore: missing_return
  trim(String value) async {}

  Future<Null> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: password)
          .then((value) => Navigator.pushNamedAndRemoveUntil(
              context, '/myService', (route) => false))
          .catchError((value) => normalDialog(context, value.message));
    });
  }
}

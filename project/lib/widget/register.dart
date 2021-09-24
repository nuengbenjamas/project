import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/utility/dialog.dart';
import 'package:project/utility/my_style.dart';

class Register extends StatefulWidget {


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
    late double screen;
    bool redEye = true;
    late String studentId, name, user, password, confirmpassword;

  Container buildStudentID() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white10),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: TextField(keyboardType: TextInputType.number,
        onChanged: (value) => studentId = value.trim(),
        style: TextStyle(color: Mystyle().darkColor),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Mystyle().darkColor),
          hintText: 'StudentID :',
          prefixIcon: Icon(
            Icons.attribution_sharp,
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


  Container buildName() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white10),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: TextField(keyboardType: TextInputType.name,
        onChanged: (value) => name = value.trim(),
        style: TextStyle(color: Mystyle().darkColor),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Mystyle().darkColor),
          hintText: 'Name :',
          prefixIcon: Icon(
            Icons.fingerprint_sharp,
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


  Container buildUser() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white10),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: TextField(keyboardType: TextInputType.emailAddress,
        onChanged: (value) => user = value.trim(),
        style: TextStyle(color: Mystyle().darkColor),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Mystyle().darkColor),
          hintText: 'User :',
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
      ),
    );
  }


  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: redEye,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              redEye
                  ? Icons.remove_red_eye_outlined
                  : Icons.remove_red_eye_sharp,
              color: Mystyle().primaryColor,
            ),
            onPressed: () {
              setState(() {
                redEye = !redEye;
              });
            },
          ),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Mystyle().primaryColor,
          ),
          labelStyle: TextStyle(color: Mystyle().darkColor),
          labelText: 'Password :',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Mystyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Mystyle().primaryColor)),
        ),
      ),
    );
  }

  
  Container buildConfirmPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: TextField(
        onChanged: (value) => confirmpassword = value.trim(),
        obscureText: redEye,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              redEye
                  ? Icons.remove_red_eye_outlined
                  : Icons.remove_red_eye_sharp,
              color: Mystyle().primaryColor,
            ),
            onPressed: () {
              setState(() {
                redEye = !redEye;
              });
            },
          ),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Mystyle().primaryColor,
          ),
          labelStyle: TextStyle(color: Mystyle().darkColor),
          labelText: 'Confirm-Password :',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Mystyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Mystyle().primaryColor)),
        ),
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(),
      appBar: AppBar(backgroundColor: Mystyle().primaryColor,
        title: Text('Register'),
      ),body: Center(
        child: Column(
          children: [
            buildStudentID(),
            buildName(),
            buildUser(),
            buildPassword(),
            buildConfirmPassword(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Mystyle().primaryColor,
      onPressed: () {
        print(
                'studentId = $studentId , name = $name ,  user = $user , password = $password , confirmpassword = $confirmpassword');
        if ((studentId.isEmpty ?? true) ||
                (name?.isEmpty ?? true) ||
                (user?.isEmpty ?? true) ||
                (password?.isEmpty ?? true) ||
                (confirmpassword?.isEmpty ?? true)) {
              print('Have Space');
              normalDialog(context, 'Have Space ? Please Fill Every Blank');
             
            } else {
              print('No Space');
              registerFirebase();
            }
          },
      
      child: Icon(Icons.cloud_upload_rounded),
      );
  }

  Future<Null> registerFirebase() async {
    await Firebase.initializeApp().then((value) async {
      print('#### Firebase Initialize Success ####');
      await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: user, password: password)
      .then((value) async {
        print('Register Success');
        // ignore: deprecated_member_use
        await value.user!.updateProfile(
          displayName: name);
       /*  .then((value) => Navigator.pushNamedAndRemoveUntil(
          context,
           '/myService', 
          (route) => false)
          );  */
      }).catchError((value) {
        normalDialog(context, value.message);
      });
    });
  }

}
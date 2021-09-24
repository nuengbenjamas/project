import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/utility/my_style.dart';
import 'package:flutter/material.dart';

class Informationprofile extends StatefulWidget {
  @override
  _InformationprofileState createState() => _InformationprofileState();
}

class _InformationprofileState extends State<Informationprofile> {
  late String displayName;
  late Title information;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    findDisplayName();
  }

  Future<Null> findDisplayName() async {
    await Firebase.initializeApp().then((value) async {
      // ignore: await_only_futures
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          displayName = event!.displayName!;
        });
        print('### displayName = $displayName');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      body: Center(
        child: Container(
          width: 300,
          child: ListTile(
            trailing: IconButton(
                onPressed: () {
                  print('You click edit');
                  editThread();
                },
                icon: Icon(
                  Icons.edit_outlined,
                  size: 36,
                  color: Mystyle().primaryColor,
                )),
            leading: Icon(
              Icons.account_box_outlined,
              size: 50,
              color: Mystyle().primaryColor,
            ),
            title:
                // ignore: unnecessary_null_comparison
                Mystyle().titleH2(displayName == null ? 'Non ?' : displayName),
            subtitle: Text('Display Name User'),
          ),
        ),
      ),
    );
  }

  // ignore: missing_return
  Future<Null> editThread() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title:  ListTile(
          leading: Mystyle().showLogo(),
          title: Text('Edit DisplayName'),
          subtitle: Text('Please Fill New Display Name in Blank'),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: Mystyle().boxDecoration(),
                width: 200,
                child: TextFormField(
                  onChanged: (value) => displayName = value.trim(),
                  initialValue: displayName,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_box_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () async {
                    print('current displayName = $displayName');
                    await Firebase.initializeApp().then((value) async {
                      // ignore: await_only_futures
                      await FirebaseAuth.instance
                          .authStateChanges()
                          .listen((event) async {
                        event!
                            // ignore: deprecated_member_use
                            .updateProfile(displayName: displayName)
                            .then((value) {
                          findDisplayName();
                          Navigator.pop(context);
                        });
                      });
                    });
                  },
                  child: Text('Edit Displayname')),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red.shade700),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/widget/informationbook.dart';
import 'package:flutter/material.dart';
import 'package:project/utility/my_style.dart';
import 'package:project/widget/informationprofile.dart';
import 'package:project/widget/show_book_list.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  late String name, email;
  Widget currentWidget = ShowBookList();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    findNameAnEmail();
  }

  Future<Null> findNameAnEmail() async {
    await Firebase.initializeApp().then((value) async {
      // ignore: await_only_futures
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          name = event!.displayName!;
          email = event.email!;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Book New'),
          backgroundColor: Mystyle().primaryColor),
      drawer: buildDrawer(),
      body: currentWidget,
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              buildUserAccountsDrawerHeader(),
              buildListTileShowBookList(),
              buildListTileInformation(),
              buildListTileInformationProfile(),
            ],
          ),
          buildSignOut(),
        ],
      ),
    );
  }

//กดปุ่มเพื่อให้เข้าไปยังหน้าถัดไป
  ListTile buildListTileShowBookList() {
    return ListTile(
      leading: Icon(
        Icons.book_online_sharp,
        size: 36,
      ),
      title: Text('Show Book'),
      subtitle: Text('Show All Book'),
      onTap: () {
        setState(() {
          currentWidget = ShowBookList();
        });
        Navigator.pop(context);
      },
    );
  }

/*  Widget buildInformation(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book New')),
    );
  } */

  ListTile buildListTileInformation() {
    return ListTile(
      leading: Icon(
        Icons.bookmark,
        size: 36,
      ),
      title: Text('Information'),
      subtitle: Text('Information of Book'),
      onTap: () {
        setState(() {
          currentWidget = Informationbook();
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildListTileInformationProfile() {
    return ListTile(
      leading: Icon(
        Icons.bookmark,
        size: 36,
      ),
      title: Text('Information'),
      subtitle: Text('Information of Profile'),
      onTap: () {
        setState(() {
          currentWidget = Informationprofile();
        });
        Navigator.pop(context);
      },
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/bn.png'), fit: BoxFit.fill),
      ),
      // ignore: unnecessary_null_comparison
      accountName: Mystyle().titleH2White(name == null ? 'Name' : name),
      // ignore: unnecessary_null_comparison
      accountEmail: Mystyle().titleH2White(email == null ? 'email' : email),
      currentAccountPicture: Image.asset('images/logo.png'),
    );
  }

  Column buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            await Firebase.initializeApp().then((value) async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/authen', (route) => false));
            });
          },
          tileColor: Mystyle().darkColor,
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 36,
          ),
          title: Mystyle().titleH2White('Sign Out'),
          subtitle: Mystyle().titleH3White('Sign Out & Go to Authen'),
        ),
      ],
    );
  }
}

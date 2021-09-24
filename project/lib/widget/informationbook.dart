import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/models/book_model.dart';
import 'package:project/utility/my_style.dart';
import 'package:flutter/material.dart';

class Informationbook extends StatefulWidget {
  @override
  _InformationbookState createState() => _InformationbookState();
}

class _InformationbookState extends State<Informationbook> {
  List<Widget> widgets = [];
  List<BookModel> bookModel = [];

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      print('initialize Success');
      // ignore: await_only_futures
      await FirebaseFirestore.instance
          .collection('Book')
          .orderBy('name')
          .snapshots()
          .listen((event) {
        print('snapshot = ${event.docs}');

        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          print('map = $map');
          BookModel model = BookModel.fromMap(map);
          bookModel.add(model);
          print('name = ${model.name}');
          print('author = ${model.author}');
          print('pagenumber = ${model.pagenumber}');
          setState(() {
            widgets.add(createWidget(model));
          });
        }
      });
    });
  }

  Widget createWidget(BookModel model) => Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100,
                child: Image.network(model.cover),
               
                
              ),
              SizedBox(
                height: 16,
              ),
              Mystyle().titleH2((model.name)),
              Mystyle().titleH2((model.author)),
              Mystyle().titleH2((model.pagenumber)),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.extent(
              maxCrossAxisExtent: 250,
              children: widgets,
            ),
    );
  }
}

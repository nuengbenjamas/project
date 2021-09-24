import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/models/book_model.dart';
import 'package:project/utility/my_style.dart';
import 'package:project/widget/show_detail_book.dart';
import 'package:flutter/material.dart';

class ShowBookList extends StatefulWidget {
  @override
  _ShowBookListState createState() => _ShowBookListState();
}

class _ShowBookListState extends State<ShowBookList> {
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
        int index = 0;
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          print('map = $map');
          BookModel model = BookModel.fromMap(map);
          bookModel.add(model);
          print('name = ${model.name}');
          setState(() {
            widgets.add(createWidget(model, index));
          });
          index++;
        }
      });
    });
  }

  Widget createWidget(BookModel model, int index) => GestureDetector(
        onTap: () {
          print('You Click from index = $index');

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShowDetailBook(
                        bookModel: bookModel[index],
                      )));
        },
        child: Card(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 150, 
                  child: Image.network(model.cover)
                  ),
                SizedBox(
                  height: 16,
                ),
                Mystyle().titleH2(model.name),
              ],
            ),
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

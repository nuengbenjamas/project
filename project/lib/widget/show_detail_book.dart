import 'package:project/models/book_model.dart';
import 'package:project/utility/my_style.dart';
import 'package:flutter/material.dart';
import 'package:pdf_viewer_jk/pdf_viewer_jk.dart';

class ShowDetailBook extends StatefulWidget {
  final BookModel bookModel;

  ShowDetailBook({Key? key, required this.bookModel}) : super(key: key);

  @override
  _ShowDetailBookState createState() => _ShowDetailBookState();
}

class _ShowDetailBookState extends State<ShowDetailBook> {
  late BookModel model;
  late PDFDocument pdfDocument;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    model = widget.bookModel;
    createPDFDocument();
  }

  Future<Null> createPDFDocument() async {
    try {
      var result = await PDFDocument.fromURL(model.pdf);
      setState(() {
        pdfDocument = result;
      });
    } catch (e) {
      print('e ==> ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Mystyle().primaryColor,
        // ignore: unnecessary_null_comparison
        title: Text(model.name == null ? 'Read book' : model.name),
      ),
      // ignore: unnecessary_null_comparison
      body: pdfDocument == null
          ? Center(child: CircularProgressIndicator())
          : PDFViewer(
              document: pdfDocument,
            ),
    );
  }
}

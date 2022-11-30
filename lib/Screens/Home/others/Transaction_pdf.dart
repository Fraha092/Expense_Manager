import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TransactionPDFpage extends StatefulWidget {
  const TransactionPDFpage({Key? key}) : super(key: key);

  @override
  State<TransactionPDFpage> createState() => _TransactionPDFpageState();
}

class _TransactionPDFpageState extends State<TransactionPDFpage> {
 final pdf = pw.Document();
 writeOnPdf(){
   pdf.addPage(
     pw.MultiPage(
       pageFormat: PdfPageFormat.a4,
       margin: pw.EdgeInsets.all(32),

       build: (pw.Context context){
         return <pw.Widget>[
           pw.Header(
             level: 0,
             child: pw.Text('Expense Manager')
           )
         ];
       }
     )
   );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trnasaction PDF'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Pdf tutorial",style: TextStyle(fontSize: 34),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.save),
      ),
    );
  }
}

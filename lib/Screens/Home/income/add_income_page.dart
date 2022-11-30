//import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/Screens/Home/income/components/category.dart';
import 'package:expense_app/constants.dart';
import 'package:expense_app/models/category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../transaction/transaction_filter_page.dart';


class AddIncomePage extends StatefulWidget {
  IncomeCat category;
   AddIncomePage( {Key? key, required this.category,}) : super(key: key);
  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}
class _AddIncomePageState extends State<AddIncomePage> {

  final CollectionReference _addIncome=
  FirebaseFirestore.instance.collection('add_income');


 static final _income=TextEditingController();
  static final _category=TextEditingController();
  static final _dates=TextEditingController();
  static final _times=TextEditingController();
  static final _notes=TextEditingController();

  int iconId = 0;

  @override
  void initState(){
    _income.clear();
    _notes.clear();
    _dates.text="";
    _times.text = "";
    _category.text = widget.category.name;
    iconId = widget.category.icon;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor ,
        title: ( const Text('Add Income',style: TextStyle(fontSize: 18,color: Colors.white),)),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 14),
            child: Form(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _income,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      onSaved: (income){
                      },
                      decoration: const InputDecoration(
                        labelText: 'Income',
                        hintText: "Amount",
                        suffixIcon: Icon(Icons.calculate),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal,width: 2,)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal,width: 2,)
                        ),
                        labelStyle: TextStyle(
                            fontSize: 15,fontWeight: FontWeight.normal,
                            color: Colors.teal
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _category,
                      cursorColor: kPrimaryColor,
                      onSaved: (category){

                      },
                      decoration:  InputDecoration(
                        labelText: 'Category',
                        hintText: "Category",
                        prefixIcon:  iconId==0? null :Icon(IconDataSolid(iconId)),
                        suffixIcon: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return IncomeCategoryScreen();
                                  },
                                ),
                              );
                            },
                            child: Icon(Icons.category)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal,width: 2,)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal,width: 2,)
                        ),
                        labelStyle: TextStyle(
                            fontSize: 15,fontWeight: FontWeight.normal,
                            color: Colors.teal
                        ),

                      ),
                      readOnly: true,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _notes,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,

                      onSaved: (note){

                      },
                      decoration: const InputDecoration(
                        labelText: 'Notes',
                        hintText: "Optional",
                        suffixIcon: Icon(Icons.note_add_sharp),
                        contentPadding: EdgeInsets.all(20),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal,width: 2,)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal,width: 2,)
                        ),
                        labelStyle: TextStyle(
                            fontSize: 15,fontWeight: FontWeight.normal,
                            color: Colors.teal
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _dates,
                      cursorColor: kPrimaryColor,
                      onSaved: (date){
                      },
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        hintText: " Date",
                        suffixIcon: Icon(Icons.calendar_today),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal,width: 2,)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal,width: 2,)
                        ),
                        labelStyle: TextStyle(
                            fontSize: 15,fontWeight: FontWeight.normal,
                            color: Colors.teal
                        ),
                      ),
                      readOnly: true,
                      onTap: () async{
                        DateTime? pickedDate=await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2025)
                        );
                        if(pickedDate!=null){
                          if (kDebugMode) {
                            print(pickedDate);
                          }
                          String formattedDate=DateFormat('yyyy-MM-dd').format(pickedDate);
                          if (kDebugMode) {
                            print(formattedDate);
                          }
                          setState(() {
                            _dates.text=formattedDate;
                          });
                          if (kDebugMode) {
                            print("Date is not selected");
                          }
                        }
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _times,
                      cursorColor: kPrimaryColor,
                      onSaved: (time){
                      },
                      decoration: const InputDecoration(
                        labelText: 'Time',
                        hintText: "Time",
                        suffixIcon: Icon(Icons.timer),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal,width: 2,)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal,width: 2,)
                        ),
                        labelStyle: TextStyle(
                            fontSize: 15,fontWeight: FontWeight.normal,
                            color: Colors.teal
                        ),
                      ),
                      readOnly: true,
                      onTap: () async{
                        var pickedTime=await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now()
                        );
                        if(pickedTime!=null){
                          setState(() {
                            _times.text=pickedTime.format(context);
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15 ,horizontal: 15 ),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Material(color: Colors.teal[600],
                            shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),),
                           child: Center(
                             child: TextButton(
                                style: TextButton.styleFrom(foregroundColor: Colors.white, ),
                                 onPressed: () async{
                                   Map<String,dynamic>data={
                                     "income": double.parse(_income.text),
                                     "category":_category.text,
                                     "notes":_notes.text,
                                     "dates":_dates.text,
                                     "times":_times.text,
                                   //  "payment":_payment,
                                   };
                                   if (kDebugMode) {
                                     print("_addIncome   $data");
                                   }
                                   _addIncome.add(data);

                                   ScaffoldMessenger.of(context)
                                       .showSnackBar(const SnackBar(content: Text("New Income Saved!")));
                                   Navigator.of(context).pop();


                                   Navigator.push(context, MaterialPageRoute(builder: (context) {
                                     return const TransactionPage();
                                   }
                                   )
                                   );

                                 },
                                child: const Text("Save"),

                                 ),
                               ),
                              )
                           ],
                         ),
                      )
                    )
                 ]
              )
            )
        )
      )
    );
  }
}

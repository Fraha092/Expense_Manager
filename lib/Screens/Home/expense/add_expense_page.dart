import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../category/components/category.dart';

class AddExpensePage extends StatefulWidget {

  String categoryTitle = "";
  AddExpensePage({Key? key, required this.categoryTitle}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {

  final CollectionReference _addExpense=
  FirebaseFirestore.instance.collection('add_expense');

  static final _expense=TextEditingController();
  static final _category=TextEditingController();
 // static final _paymentMethod=TextEditingController();
  static final _dates=TextEditingController();
  static final _times=TextEditingController();
  static final _notes=TextEditingController();

  List<String>paymentList = ['Select Payment Method', 'Bank','Card','Cash','Others'
  ];
  String _payment='Select Payment Method';

  @override
  void initState(){
    _dates.text="";
    _times.text = "";
    _category.text = widget.categoryTitle;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor ,
        title: ( const Text('Add Expense',style: TextStyle(fontSize: 18,color: Colors.white),)),
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
                      controller: _expense,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      onSaved: (expense){
                      },
                      decoration: const InputDecoration(
                        labelText: 'Expense',
                        hintText: "Amount",
                        suffixIcon: Icon(Icons.calculate),
                        //contentPadding: EdgeInsets.all(20.0),
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
                    child:
                    TextFormField(
                      controller: _category,
                      // validator: (value){
                      //
                      // },

                      //textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      onSaved: (category){

                      },
                      decoration:  InputDecoration(
                        labelText: 'Category',
                        hintText: "Category",
                        // suffix: GestureDetector(
                        //   onTap:(){},
                        //   child:Text("Your Text"),
                        // ),
                        suffixIcon: GestureDetector( onTap:(){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const CategoryScreen();
                              },
                            ),
                          );
                        },
                            child: const Icon(Icons.category)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal,width: 2,)
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal,width: 2,)
                        ),
                        labelStyle: const TextStyle(
                            fontSize: 15,fontWeight: FontWeight.normal,
                            color: Colors.teal
                        ),

                      ),
                    ),
                  ),
                   Container(
                     alignment: Alignment.center,
                     child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Column(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.teal.shade50,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                isExpanded: true,
                               icon: const Icon(Icons.payments,color: Colors.teal,),
                               // underline: ,
                                hint: const Center(child: Text('Select Payment Method',
                                  style: TextStyle(color: Colors.teal),)),
                                value: _payment,
                                onChanged: (newValue) {
                                  setState(() {
                                    _payment = newValue!;
                                  });
                                },
                                items: paymentList.map((location) {
                                  return DropdownMenuItem(
                                    value: location,
                                    child: Text(location),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                       // contentPadding: EdgeInsets.all(20),
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
                              String formattedDate=DateFormat('yyyy/MM/dd').format(pickedDate);
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
                  const SizedBox(height: 20),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15 ,horizontal: 15 ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Material(
                            color: Colors.teal[600],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white, //backgroundColor: Colors.green,
                                  ),
                                  onPressed:() async{
                                    Map<String,dynamic>data={
                                      "expense":_expense.text,
                                      "category":_category.text,
                                      "notes":_notes.text,
                                      "dates":_dates.text,
                                      "times":_times.text,
                                      "payment":_payment,
                                    };
                                    if (kDebugMode) {
                                      print("_addExpense   $data");
                                    }
                                    _addExpense.add(data);
                                  },
                                  child: const Text("Save"),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
          )
        ),
      ),
    );
  }
}

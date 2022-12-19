import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../models/BudgetModel.dart';
import '../../../models/category.dart';
import '../Budget/BudgetService.dart';
import '../category/components/category.dart';
import '../transaction/transaction_filter_page.dart';



class AddExpensePage extends StatefulWidget {

  Cat category;
  AddExpensePage({Key? key, required this.category}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // getCurrentUser(){
  //   final User? user =_auth.currentUser;
  //   final uid = user!.uid;
  //   //final uemail=user.email;
  //   print("uID $uid");
  //   return uid;
 // }
   final CollectionReference _addExpense =
   FirebaseFirestore.instance.collection('add_expense');
  static final _expense=TextEditingController();
  static final _category=TextEditingController();
  static final _dates=TextEditingController();
  static final _times=TextEditingController();
  static final _notes=TextEditingController();
  //static final _payment=TextEditingController();
   List<BudgetModel> budgetList = [];
   final BudgetService _budgetService = BudgetService();

  static List<String>paymentList = ['Select Payment Method', 'Bank','Card','Cash','Others'
  ];
   String _payment='Select Payment Method';
  int iconId = 0;
 // late String id="";
  @override
  void initState(){
    _dates.text="";
    _times.text = "";
    _category.text= widget.category.name;
    iconId = widget.category.icon;
    _budgetService.retrieveBudget().then((value) {
      if(value != null){
        budgetList = value;
        print("budgetList  $budgetList");
      }
    }
    );
    super.initState();
    //id = getCurrentUser();
   // _addExpense = FirebaseFirestore.instance.collection(id).doc("add_expense").collection(id);
    _expense.clear();
    _notes.clear();
  }

  @override
  void dispose() {
    super.dispose();
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
                    child:
                    TextFormField(
                      controller: _category,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      onSaved: (category){
                      },
                      decoration:  InputDecoration(
                        fillColor: KPrimaryMidLevelColor,
                        labelText: 'Category',
                        hintText: "Category",
                        prefixIcon:  CircleAvatar(
                          backgroundColor: CupertinoColors.systemGrey6,
                          child: iconId==0? Icon(Icons.category,color: Colors.black,size: 16,) :Icon(IconDataSolid(iconId),size: 16,color: Colors.black,),
                        ),
                        suffixIcon: GestureDetector( onTap:(){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CategoryScreen();
                              },
                            ),
                          );
                        },
                            child: const Icon(Icons.category)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor,width: 2,)
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor,width: 2,)
                        ),
                        labelStyle: const TextStyle(
                            fontSize: 15,fontWeight: FontWeight.normal,
                            color: kPrimaryColor
                        ),

                      ),
                      readOnly: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _expense,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      onSaved: (expense){
                      },
                      decoration:  InputDecoration(
                        fillColor: KPrimaryMidLevelColor,
                        labelText: 'Expense',
                        hintText: "Amount",
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset('assets/images/Tk.png',height: 2,width: 6,fit: BoxFit.fill,color: kPrimaryColor,),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor,width: 2,)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor,width: 2,)
                        ),
                        labelStyle: TextStyle(
                            fontSize: 15,fontWeight: FontWeight.normal,
                            color: kPrimaryColor
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
                              color: KPrimaryMidLevelColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                focusColor: KPrimaryMidLevelColor,
                                isExpanded: true,
                               icon: const Icon(Icons.payments,color: kPrimaryColor,),
                               // underline: ,
                                hint: const Center(child: Text('Payment Method',
                                  style: TextStyle(color: kPrimaryColor),)),
                                value: _payment,
                                onChanged: (newValue) {
                                  setState(() {
                                    _payment = newValue!;
                                  });
                                },
                                items: paymentList.map((location) {
                                  return DropdownMenuItem(
                                    value: location,
                                    child: Text(location,style: TextStyle(color: Colors.black),),
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
                        fillColor: KPrimaryMidLevelColor,
                        labelText: 'Notes',
                        hintText: "Optional",
                        suffixIcon: Icon(Icons.note_add_sharp),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor,width: 2,)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor,width: 2,)
                        ),
                        labelStyle: TextStyle(
                            fontSize: 15,fontWeight: FontWeight.normal,
                            color: kPrimaryColor
                        ),
                      ),
                    ),
                  ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _dates,
                          cursorColor: KPrimaryMidLevelColor,
                          onSaved: (date){
                          },
                          decoration: const InputDecoration(
                            fillColor: KPrimaryMidLevelColor,
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
                          cursorColor: KPrimaryMidLevelColor,
                          onSaved: (time){
                          },
                          decoration: const InputDecoration(
                            fillColor: KPrimaryMidLevelColor,
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                                child: MaterialButton(
                                  color: kPrimaryColor,
                                  onPressed:() async{

                                    if(_expense.text !="" && _category != "" && _payment != "" && _dates != "" && _times != ""){

                                      for(var item in budgetList){
                                        if(item.category == _category.text){
                                          if(item.amount >= double.parse(_expense.text)){
                                            Map<String,dynamic>data={
                                              "expense": double.parse(_expense.text),
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
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(content: Text("New Expense Saved!")));
                                            Navigator.of(context).pop();
                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                              return const TransactionPage();
                                            }
                                            )
                                            );
                                          }else{
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(content: Text("Your amount exist")));
                                          }

                                        }
                                      }

                                    }
                                    else{
                                      Fluttertoast.showToast(
                                        msg: "Please Fill all the fields for Add new Transaction. ",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: Colors.indigo.shade100,
                                          textColor: Colors.indigo.shade900,
                                          fontSize: 16.0
                                      );
                                    }
                                  },
                                  child: const Text('Save',style: TextStyle(color: Colors.white),),
                                )
                            ),
                          ),

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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';
import '../../../models/category.dart';
import '../category/components/category.dart';

class AddBudget extends StatefulWidget {
  Cat? category;
   AddBudget({Key? key, this.category}) : super(key: key);

  @override
  State<AddBudget> createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
  final CollectionReference _budget =
  FirebaseFirestore.instance.collection('budget');
  static final _amount=TextEditingController();
  static final _category=TextEditingController();

  @override
  void initState(){

    setState(() {
      _category.text= widget.category?.name ?? " ";
    });
    // iconId = widget.category?.icon


    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Budget'),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [

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
                labelText: "Category",
                hintText: "Category",
                // prefixIcon:  CircleAvatar(
                //   backgroundColor: CupertinoColors.systemGrey6,
                //   // child: iconId==0? Icon(Icons.category,color: Colors.black,size: 16,) :Icon(IconDataSolid(iconId),size: 16,color: Colors.black,),
                // ),
                suffixIcon: GestureDetector( onTap:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CategoryScreen(requestType: "addBudget");
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
              controller: _amount,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (expense){
              },
              decoration:  InputDecoration(
                fillColor: KPrimaryMidLevelColor,
                labelText: 'Budget',
                hintText: "Amount",
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/images/Tk.png',height: 2,width: 6,fit: BoxFit.fill,color: kPrimaryColor,),
                ),
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
            ),
          ),
          Padding(
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
                        onPressed: () async{
                       if(_amount.text !="" && _category != ""){
                            Map<String,dynamic>data={
                        "amount": double.parse(_amount.text),
                             "category":_category.text,
                            };
                               _budget.add(data);
                          Navigator.of(context).pop();
                         }
                       else
                         {
                           Fluttertoast.showToast(
                               msg: "Please Fill all the fields for Add new Budget. ",
                               toastLength: Toast.LENGTH_SHORT,
                               gravity: ToastGravity.TOP,
                               timeInSecForIosWeb: 3,
                               backgroundColor: Colors.indigo.shade100,
                               textColor: Colors.indigo.shade900,
                               fontSize: 16.0
                           );
                         }
                      },
                     child: Text('Save',style: TextStyle(color: Colors.white),)),
                  ),
                ),
              ],
            ),
          )

        ],
      ),

    );
  }
}

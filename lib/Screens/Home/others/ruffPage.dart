// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expense_app/Screens/Home/Budget/CatBudget.dart';
// import 'package:expense_app/constants.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// import '../../../models/BudgetModel.dart';
// import '../../../models/category.dart';
// import '../Budget/BudgetService.dart';
// import '../category/service/CommonService.dart';
//
// class RuffPage extends StatefulWidget {
//   Cat category;
//
//   RuffPage({Key? key,  required this.category}) : super(key: key);
//
//   @override
//   State<RuffPage> createState() => _RuffPageState();
// }
//
// final CommonService _commonService = CommonService();
// final BudgetService _budgetService = BudgetService();
// List<Cat> catList = [];
// List<BudgetModel> budgetList = [];
// int position = 0;
// int iconId=0;
//
// class _RuffPageState extends State<RuffPage> {
//   final CollectionReference _addBudget =
//   FirebaseFirestore.instance.collection('add_budget');
//   static final _budget=TextEditingController();
//   static final _category=TextEditingController();
//   static final _icon=TextEditingController();
//
//   @override
//   void initState(){
//
//     setState(() {
//       _category.text= widget.category.name;
//       //iconId = widget.category.icon;
//       _budgetService.retrieveBudget().then((value) {
//         if(value != null){
//           budgetList = value;
//           print("budgetList  $budgetList");
//         }
//       }
//       );
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Budget'),
//         backgroundColor: kPrimaryColor,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: FloatingActionButton(
//                 backgroundColor: Colors.white,
//                 child: const Icon(
//                   Icons.add,
//                   color: kPrimaryColor,
//                   size: 18,
//                 ),
//                 onPressed: ()=>
//                     showModalBottomSheet(
//                         context: context,
//                         builder: (BuildContext ctx){
//                           return Padding(
//                               padding: EdgeInsets.all(8.0),
//                           child: Form(
//                             child: Column(
//                               children: [
//                                 Center(
//                                   child: Container(
//                                     width: 150,
//                                     height: 70,
//                                     child: const Text('Set Budget',style: TextStyle(color: kPrimaryColor,fontSize: 16),),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: TextFormField(
//                                     controller: _category,
//                                     cursorColor: kPrimaryColor,
//                                     onSaved: (category){
//
//                                     },
//                                     decoration:  InputDecoration(
//                                       fillColor: KPrimaryMidLevelColor,
//                                       labelText: 'Category',
//                                       hintText: "Category",
//                                       prefixIcon:  iconId==0? null :Icon(IconDataSolid(iconId)),
//                                       suffixIcon: GestureDetector(
//                                           onTap: (){
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) {
//                                                   return CatBudget();
//                                                 },
//                                               ),
//                                             );
//                                           },
//                                           child: Icon(Icons.category)),
//                                       enabledBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(color: kPrimaryColor,width: 2,)
//                                       ),
//                                       focusedBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(color: kPrimaryColor,width: 2,)
//                                       ),
//                                       labelStyle: TextStyle(
//                                           fontSize: 15,fontWeight: FontWeight.normal,
//                                           color: kPrimaryColor
//                                       ),
//
//                                     ),
//                                     readOnly: true,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: TextFormField(
//                                     onChanged: (budget) {},
//                                     autofocus: true,
//                                     keyboardType: TextInputType.number,
//                                     textInputAction: TextInputAction.done,
//                                     decoration: InputDecoration(
//                                       hintText: 'Amount',
//                                       // icon: Icon(IconData(iconId)),
//                                     ),
//                                     controller: _budget,
//                                   ),
//                                 ),
//
//                                 Center(
//                                   child: MaterialButton(
//                                     color: kPrimaryColor,
//                                     onPressed:() async{
//                                       if(_budget.text !=""){
//
//                                       Map<String,dynamic>data={
//                                      "budget": double.parse(_budget.text),
//                                        "category": _category.text,
//                                       //  "icon": _icon.text,
//
//                                           };
//                                               _addBudget.add(data);
//                                               ScaffoldMessenger.of(context)
//                                                   .showSnackBar(const SnackBar(content: Text("New budget Saved!")));
//                                               Navigator.of(context).pop();
//                                               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                                 return  RuffPage(category: Cat(id: 0, name: "", icon: 0),);
//                                               }
//                                               )
//                                               );
//                                             }else{
//                                               ScaffoldMessenger.of(context)
//                                                   .showSnackBar(const SnackBar(content: Text("Your amount Exceeds")));
//                                             }
//
//
//                                         },
//                                     child: const Text("Save",style: TextStyle(color: Colors.white),),
//
//                                   ),
//                                 )
//                               ],
//                             ),
//                           )
//                           // FutureBuilder<List<Cat>>(
//                           //   future: _commonService.retrieveCategories(),
//                           //   builder: (context, future){
//                           //     if (!future.hasData) {
//                           //       return Container();
//                           //     } else
//                           //       {
//                           //         catList = future.data!;
//                           //         return ListView.builder(
//                           //             shrinkWrap: true,
//                           //             itemCount: catList.length,
//                           //             itemBuilder: (context, index) {
//                           //               return Card(
//                           //                 child: ListTile(
//                           //                   leading: CircleAvatar(
//                           //                       backgroundColor:
//                           //                       Colors.grey.shade50,
//                           //                       child: Icon(
//                           //                         IconDataSolid(
//                           //                             catList[index].icon),
//                           //                         size: 16,
//                           //                         color: Colors.black,
//                           //                       )),
//                           //                   title: Text(catList[index].name),
//                           //                   onTap: () {
//                           //                     setState(() {
//                           //                    //   print("click $position");
//                           //                       Navigator.pop(context);
//                           //                       // openDailog();
//                           //                       // iconId = index;
//                           //                        position = index;
//                           //                       //openDailog();
//                           //
//                           //                     });
//                           //                   },
//                           //                 ),
//                           //               );
//                           //             });
//                           //       }
//                           //   },
//                           // ),
//                           );
//                         })
//             ),
//           )
//         ],
//       ),
//
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/Screens/Home/others/add_budget.dart';
import 'package:expense_app/models/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
class NewBudget extends StatefulWidget {
  Cat? category;
   NewBudget({Key? key, this.category}) : super(key: key);

  @override
  State<NewBudget> createState() => _NewBudgetState();
}

class _NewBudgetState extends State<NewBudget> {
  final CollectionReference _budget =
  FirebaseFirestore.instance.collection('budget');
  static final _amount=TextEditingController();
  static final _category=TextEditingController();

  @override
  void initState(){
   setState(() {
     _category.text= widget.category?.name ?? " ";
   });
    super.initState();
   _amount.clear();
   _category.clear();
  }

  final TextEditingController _categoryBudget = TextEditingController();
  final TextEditingController _amountBudget = TextEditingController();
  Future<void> _delete(String budgetId) async {
    await _budget.doc(budgetId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a Budget !')));
    //  Navigator.pop(context);
  }
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _categoryBudget.text = documentSnapshot['category'];
      _amountBudget.text = documentSnapshot['amount'].toString();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Updated!")));
    }
    await showModalBottomSheet(
        backgroundColor: Colors.grey.shade100,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('Edit Budget',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kPrimaryColor),),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: IconButton(
                                  onPressed: () async =>
                                      showDialog(
                                          context: context,
                                          builder: (context)=>
                                              AlertDialog(
                                                title: const Text('Delete'),
                                                content: const Text('Do you want to delete this transaction record ?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                      onPressed: (){
                                                        Navigator.of(context, rootNavigator: true).pop(false);
                                                      },
                                                      child: const Text('No')),
                                                  TextButton(
                                                      onPressed: (){
                                                        _delete(documentSnapshot!.id);
                                                        Navigator.of(context,rootNavigator: true).pop(true);
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                          return NewBudget();
                                                        }
                                                        )
                                                        );
                                                      },
                                                      child: const Text('Yes'))
                                                ],
                                              )
                                      ),
                                  icon: const Icon(Icons.delete,color: kPrimaryColor,size: 30,)),
                            )
                          ],
                        ),const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextField(
                            controller: _categoryBudget,
                            keyboardType: TextInputType.none,
                            decoration: const InputDecoration(labelText: 'Category',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: KPrimaryMidLevelColor),
                            cursorColor: Colors.grey.shade200,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextField(
                            controller: _amountBudget,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: 'Budget',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: KPrimaryMidLevelColor),
                            cursorColor: Colors.grey.shade200,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor
                            ),
                            onPressed: () async {
                              final String category = _categoryBudget.text;
                              final double amount =
                              double.parse(_amountBudget.text);
                              //final double? expense=double.tryParse(_expenseExpense.text);
                              if (amount != null) {
                                await _budget
                                    .doc(documentSnapshot!.id)
                                    .update({
                                  "category": category,
                                  "amount": amount
                                });
                                _categoryBudget.text = '';
                                double.parse(_amountBudget.text);
                              }
                              ;
                            },
                            child: const Text('Update',),
                          ),
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('New Budget'),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _budget.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title:
                          Text("${documentSnapshot['category']}\n"),
                          subtitle: Text("Amount: ${documentSnapshot['amount']} "
                              ),
                          onTap: (){
                            _update(documentSnapshot);
                          },
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: kPrimaryColor,
      onPressed: ()
    {
     setState(() {
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(
           builder: (context) {
             return AddBudget();
           },
         ),
       );
     });
    },
    child: Icon(Icons.add,color: Colors.white,),

    ),

    );
  }
}

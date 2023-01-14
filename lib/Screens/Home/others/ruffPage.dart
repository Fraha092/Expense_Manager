
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
            child:
            StreamBuilder(
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

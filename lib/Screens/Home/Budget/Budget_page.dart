
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/Screens/Home/Budget/BudgetService.dart';
import 'package:expense_app/models/BudgetModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../models/category.dart';
import '../category/service/CommonService.dart';

class BudgetPage extends StatefulWidget {
  BudgetPage({Key? key}) : super(key: key);

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

final CollectionReference addBudget =
FirebaseFirestore.instance.collection('add_budget');
// final CollectionReference _addBudget =
// FirebaseFirestore.instance.collection('add_budget');

List<Cat> catList = [];
List<BudgetModel> budgetList = [];
int position = -1;
//int iconId = 0;
final CommonService _commonService = CommonService();
final BudgetService _budgetService = BudgetService();

class _BudgetPageState extends State<BudgetPage> {
  static final _budget=TextEditingController();

  @override
  void initState() {

    _budgetService.retrieveBudget().then((value) {
      if(value != null){
        budgetList = value;
        print("budgetList  $budgetList");
       }
      }
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        toolbarHeight: 80.0,
        title: const Text(
          'Budget',
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.add,
                  color: kPrimaryColor,
                  size: 20,
                ),
                onPressed: () =>
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FutureBuilder<List<Cat>>(
                              future: _commonService.retrieveCategories(),
                              builder: (context, future) {
                                print("future   ${future.data?.length}");
                                if (!future.hasData) {
                                  return Container();
                                } else {
                                  catList = future.data!;
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: catList.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: ListTile(
                                            leading: CircleAvatar(
                                                backgroundColor:
                                                Colors.grey.shade50,
                                                child: Icon(
                                                  IconDataSolid(
                                                      catList[index].icon),
                                                  size: 16,
                                                  color: Colors.black,
                                                )),
                                            title: Text(catList[index].name),
                                            onTap: () {
                                              setState(() {
                                                print("click $position");
                                                Navigator.pop(context);
                                                openDailog();
                                                //iconId = index;
                                                position = index;
                                                //openDailog();

                                              });
                                            },
                                          ),
                                        );
                                      });
                                }
                              },
                            ),
                          );
                        })),
          )
        ],
      ),
      body: SingleChildScrollView(
      child:
        ListView.builder(
         scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: budgetList.length,
        itemBuilder: (BuildContext ctx, index){
          return Card(
            borderOnForeground: true,
            shadowColor: Colors.cyan,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                ListTile(
                  tileColor: Colors.grey.shade50,
                  // leading: CircleAvatar(
                  //   backgroundColor: Colors.grey.shade200,
                  //   //child: Icon(position == -1 ? null : IconDataSolid(catList[position].icon),size: 16,color: Colors.black,),
                  //   child: Icon(position == -1 ? null : IconDataSolid(budgetList[index].icon),
                  //     size: 16,color: Colors.black,),
                  // ),
                  title: Container(
                    width: 75,
                    child:  Center(
                      child: Text(budgetList[index].category
                      ),
                    ),
                  ),
                  trailing: Container(
                    width: 75,
                    child: Center(
                      child: Text(
                        "${budgetList[index].amount}",
                        style: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                   onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context)=>
                          AlertDialog(
                            content: Container(
                              child: Wrap(
                                children: [
                                  TextButton(onPressed: (){
                                    showDialog(context: context,
                                        builder: (context)=> AlertDialog(
                                          title: Center(child: Text("Edit Budget")),
                                          content: TextFormField(
                                            controller: _budget,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              hintText: "Budget",
                                              labelText: "Budget",
                                              fillColor: KPrimaryMidLevelColor,
                                            ),
                                          ),
                                          actions: [
                                            _cancelButton(context),
                                            okButton(context)

                                          ],
                                        )
                                    );
                                  }, child: Center(child: Text("Update"))),
                                  Divider(),
                                  TextButton(onPressed: ()=> showDialog(
                                      context: context,
                                      builder: (context)=>
                                          AlertDialog(
                                            //title: Text('Delete'),
                                            content: Text('Do you want to delete this budget record ?'),
                                            actions: <Widget>[
                                              TextButton(
                                                  onPressed: (){
                                                    Navigator.of(context, rootNavigator: true).pop(false);
                                                  },
                                                  child: Text('No')),
                                              TextButton(
                                                  onPressed: (){
                                                   // _deletee(documentSnapshot!.id);
                                                    Navigator.of(context,rootNavigator: true).pop(true);
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                      return BudgetPage();
                                                    }
                                                    )
                                                    );
                                                  },
                                                  child: Text('Yes'))
                                            ],
                                          )
                                  ),
                                     child: Center(child: Text("Delete"))),
                                ],
                              ),
                            ),
                          )
                    );
                   },
                ),

              ],
            ),
          );
        }
    ),
    ),
      );
  }
 // Future<double?>
  openDailog() =>
      showDialog<double>(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Set Budget'),
              content: TextFormField(
                onChanged: (budget) {},
                autofocus: true,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Amount',
                 // icon: Icon(IconData(iconId)),
                ),
                controller: _budget,
              ),
              actions: <Widget>[
                _cancelButton(context),
                TextButton(
                    onPressed: () {
                      //okButton(context);
                      if (_budget.text != "") {
                        Map<String, dynamic>data = {
                          "budget": double.parse(_budget.text),
                          "category": catList[position].name,
                          "icon": catList[position].icon,
                        };
                        addBudget.add(data);
                      }
                      Navigator.of(context).pop();
                      // save();
                    },
                    child: const Text('OK'),

                ),
              ],

            ),
      );
  _cancelButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancel'));
  }
  okButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          //FirebaseFirestore.instance.collection('add_budget').doc().delete();
         // _delete(budgetList.id);
            Map<String, dynamic>data = {
              "budget": double.parse(_budget.text),
              "category": catList[position].name,
              "icon": catList[position].icon,
            };
            print("budget $data");
            addBudget.add(data);
          },
          // save();

        child: const Text('OK'));
  }

}

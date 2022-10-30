import 'package:expense_app/Screens/Home/income/add_income_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class IncomeCat {
  final int index;
  final String name;
  final IconData icon;

  IncomeCat(this.index, this.name, this.icon);
}


class IncomeCategoryScreen extends StatefulWidget {
  const IncomeCategoryScreen({Key? key}) : super(key: key);

  @override
  State<IncomeCategoryScreen> createState() => _IncomeCategoryScreenState();
}

class _IncomeCategoryScreenState extends State<IncomeCategoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<IncomeCat>incomeCatList=[
    IncomeCat(0, "Allowance", Icons.card_giftcard),
    IncomeCat(1, "Bonus", Icons.paid_outlined),
    IncomeCat(2, "Business", Icons.business),
    IncomeCat(3, "Investment Income", Icons.savings_outlined),
    IncomeCat(4, "Other Income", Icons.credit_card_outlined),
    IncomeCat(6, "Pension", Icons.local_atm_outlined),
    IncomeCat(7, "Salary", Icons.wallet),
  ];


  List<IncomeCat>? incomeCatListSearch;
  final FocusNode _textFocusNode = FocusNode();

  @override
  void dispose() {
    _textFocusNode.dispose();
    _searchController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income Category',),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _searchController,
                focusNode: _textFocusNode,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.search),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal,
                        width: 2,
                      )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal,
                        width: 2,
                      )),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal,
                        width: 2,
                      )),
                ),
                onChanged: (value) {
                  //print(value);
                  setState(() {
                    incomeCatListSearch = incomeCatList
                        .where((element) => element.name
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                        .toList();
                    if (_searchController.text.isNotEmpty &&
                        incomeCatListSearch!.isEmpty) {
                      if (kDebugMode) {
                        print('itemListSearch Length ${incomeCatListSearch!.length}');
                      }
                    }
                  });
                },
              ),
              Expanded(
                  child: _searchController.text.isNotEmpty &&
                      incomeCatListSearch!.isEmpty
                      ? const Center()
                      : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _searchController.text.isNotEmpty
                          ? incomeCatListSearch!.length
                          : incomeCatList.length,
                      itemBuilder: (context, index) {
                        // late String position=index.toString();
                        //  if(_searchController.text.isEmpty){
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              //  print("catListSearch" +  catListSearch![index]! + catList[index]);
                              print("${incomeCatListSearch?[index].name} ${incomeCatListSearch?[index].icon}  "
                                  "${incomeCatList[index].name} ${incomeCatList[index].icon}");
                              //Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AddIncomePage(categoryTitle: incomeCatList[index].name, );
                                  },
                                ),
                              );
                            });
                          },
                          child: Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.orange.shade50,
                                child: Icon(
                                  incomeCatList[index].icon,
                                  size: 22,
                                  color: Colors.brown.shade800,
                                ),
                              ),
                              // title: Text(_searchController.text.isNotEmpty? catListSearch![index]:catList[index])
                              title: Text(
                                incomeCatList[index].name.toString(),
                                //textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.brown),
                              ),
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),











      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     padding: EdgeInsets.symmetric(horizontal: 15,),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children:  <Widget>[
      //         Container(
      //           padding: EdgeInsets.symmetric(horizontal: 15),
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(30),
      //           ),
      //           child: TextFormField(
      //             controller: _searchController,
      //             focusNode: _textFocusNode,
      //             decoration: InputDecoration(
      //               contentPadding: EdgeInsets.all(0),
      //               prefixIcon: Icon(Icons.search,color: Colors.black12,
      //               size: 20),
      //               prefixIconConstraints: BoxConstraints(
      //                   maxHeight: 20,
      //                   maxWidth: 25),
      //               border: InputBorder.none,
      //               hintText: 'Search',
      //               hintStyle: TextStyle(color: Colors.grey)
      //             ),
      //               onChanged: (value) {
      //               setState(() {
      //                 incomeCatListSearch = incomeCatList
      //                    .where((element) => element.name
      //                     .toLowerCase()
      //                     .contains(value.toLowerCase()))
      //                      .toList();
      //                 if (_searchController.text.isNotEmpty &&
      //                       incomeCatListSearch!.isEmpty) {
      //                   if (kDebugMode) {
      //                      print('itemListSearch Length ${incomeCatListSearch!.length}');
      //                   }
      //                 }
      //               }
      //             );
      //           },
      //           ),
      //         ),
      //         Expanded(
      //             child: _searchController.text.isNotEmpty &&
      //                 incomeCatListSearch!.isEmpty
      //                 ? const Center()
      //                 : ListView.builder(
      //                 shrinkWrap: true,
      //                 itemCount: _searchController.text.isNotEmpty
      //                     ? incomeCatListSearch!.length
      //                     : incomeCatList.length,
      //                 itemBuilder: (context, index) {
      //                   // late String position=index.toString();
      //                   //  if(_searchController.text.isEmpty){
      //                   return GestureDetector(
      //                     onTap: () {
      //                       setState(() {
      //                         //  print("catListSearch" +  catListSearch![index]! + catList[index]);
      //                         print("${incomeCatListSearch?[index].name}  ${incomeCatList[index].name}");
      //                         //Navigator.pop(context);
      //                         Navigator.pushReplacement(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) {
      //                               return AddIncomePage(categoryTitle: incomeCatList[index].name,);
      //                             },
      //                           ),
      //                         );
      //                       });
      //                     },
      //                     child: Card(
      //                       child: ListTile(
      //                         leading: CircleAvatar(
      //                           backgroundColor: Colors.orange.shade50,
      //                           child: Icon(
      //                             incomeCatList[index].icon,
      //                             size: 22,
      //                             color: Colors.brown.shade800,
      //                           ),
      //                         ),
      //                         // title: Text(_searchController.text.isNotEmpty? catListSearch![index]:catList[index])
      //                         title: Text(
      //                           '${incomeCatList[index]}',
      //                           //incomeCatList[index].name.toString(),
      //                           //textAlign: TextAlign.center,
      //                           style: const TextStyle(
      //                               fontSize: 18, color: Colors.teal),
      //                         ),
      //                       ),
      //                     ),
      //                   );
      //                 }))
      //        ],
      //     ),
      //
      //   ),
      // ),

    );
  }
}

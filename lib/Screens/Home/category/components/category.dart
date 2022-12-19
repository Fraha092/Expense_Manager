
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/Screens/Home/expense/add_expense_page.dart';
import 'package:expense_app/Screens/Home/others/add_budget.dart';
import 'package:expense_app/Screens/Home/others/ruffPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../constants.dart';
import '../../../../models/category.dart';
import '../service/CommonService.dart';
class CategoryScreen extends StatefulWidget {
  String? requestType = "";
  CategoryScreen({Key? key,  this.requestType}) : super(key: key);
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}
class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final CommonService _commonService = CommonService();

  List<Cat> catList =  [];
  List<Cat>? catListSearch;
  final FocusNode _textFocusNode = FocusNode();

  @override
  void dispose() {
    _textFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

// @override
//   void initState() {
//   print("commonService 2 ${catList.length}");
//   super.initState();
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          "Category",
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _searchController,
            focusNode: _textFocusNode,
            decoration: const InputDecoration(
              fillColor: KPrimaryMidLevelColor,
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
                color: kPrimaryColor,
                width: 2,
              )),
            ),
            onChanged: (value) {
              //print(value);
              setState(() {
                catListSearch = catList
                    .where((element) => element.name
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
                if (_searchController.text.isNotEmpty &&
                    catListSearch!.isEmpty) {
                  if (kDebugMode) {
                    print('itemListSearch Length ${catListSearch!.length}');
                  }
                }
              });
            },
          ),
          Expanded(
            //flex: 3,
              child: _searchController.text.isNotEmpty &&
                      catListSearch!.isEmpty
                  ? const Center()
                  : FutureBuilder<List<Cat>>(
                future: _commonService.retrieveCategories(),
                    builder: (context,future) {
                  print("future   ${future.data?.length}");

                  if(!future.hasData) {
                    return Container();
                  } else {
                    catList = future.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: _searchController.text.isNotEmpty
                            ? catListSearch!.length
                            : catList.length,
                        itemBuilder: (context, index) {
                          // late String position=index.toString();
                          //  if(_searchController.text.isEmpty){
                          return Card(
                            child: ListTile(
                              onTap: () async {
                                if(widget.requestType == "addBudget"){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) {
                                      return AddBudget(
                                          category: _searchController
                                              .text.isNotEmpty
                                              ? catListSearch![index]
                                              : catList[index]
                                      );
                                    },
                                  ),

                                  );
                                }else{
                                  Navigator.pop(context);
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) {
                                      return AddExpensePage(
                                          category: _searchController
                                              .text.isNotEmpty
                                              ? catListSearch![index]
                                              : catList[index]
                                      );
                                    },
                                  ),

                                  );
                                }
                                },
                              leading: CircleAvatar(
                                  backgroundColor: Colors.grey.shade50,
                                  child: Icon(IconDataSolid(
                                      _searchController.text.isNotEmpty
                                          ? catListSearch![index].icon
                                          : catList[index].icon), size: 16,color: Colors.black,)

                              ),
                              title: Text(_searchController.text.isNotEmpty
                                  ? catListSearch![index].name
                                  : catList[index].name),
                            ),
                          );
                        });
                  }
                    },),

          ),

        ],
      ),
    );
  }

}

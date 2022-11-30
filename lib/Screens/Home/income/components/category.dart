import 'package:expense_app/Screens/Home/category/service/CommonServiceIncome.dart';
import 'package:expense_app/Screens/Home/income/add_income_page.dart';
import 'package:expense_app/constants.dart';
import 'package:expense_app/models/category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class IncomeCategoryScreen extends StatefulWidget {
  const IncomeCategoryScreen({Key? key}) : super(key: key);

  @override
  State<IncomeCategoryScreen> createState() => _IncomeCategoryScreenState();
}

class _IncomeCategoryScreenState extends State<IncomeCategoryScreen> {

  final TextEditingController _searchController = TextEditingController();
  final CommonServiceIncome _commonServiceIncome = CommonServiceIncome();


  // final List<IncomeCat>incomeCatList=[
  //   IncomeCat(0, "Allowance", Icons.card_giftcard,KPrimaryMidLevelColor),
  //   IncomeCat(1, "Bonus", Icons.paid_outlined,KPrimaryMidLevelColor),
  //   IncomeCat(2, "Business", Icons.business,KPrimaryMidLevelColor),
  //   IncomeCat(3, "Investment Income", Icons.savings_outlined,KPrimaryMidLevelColor),
  //   IncomeCat(4, "Other Income", Icons.credit_card_outlined,KPrimaryMidLevelColor),
  //   IncomeCat(6, "Pension", Icons.local_atm_outlined,KPrimaryMidLevelColor),
  //   IncomeCat(7, "Salary", Icons.wallet,KPrimaryMidLevelColor),
  // ];

  List<IncomeCat> incomeCatList =  [];
  List<IncomeCat>? incomeCatListSearch;
  final FocusNode _textFocusNode = FocusNode();

  @override
  void dispose() {
    _textFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState

    //  _commonService.retrieveCategories()
    //      .then((value) =>
    //     catList = value,
    // );
    print("CommonServiceIncome 2 ${incomeCatList.length}");
    super.initState();
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
                      : FutureBuilder<List<IncomeCat>>(
                        future: _commonServiceIncome.retrieveCategories(),
                                 builder: (context,future) {
                              print("future   ${future.data?.length}");
                                   if(!future.hasData) {
                                    return Container();
                                   } else {
                                     incomeCatList = future.data!;


                                     return ListView.builder(
                                         shrinkWrap: true,
                                         itemCount: _searchController.text
                                             .isNotEmpty
                                             ? incomeCatListSearch!.length
                                             : incomeCatList.length,
                                         itemBuilder: (context, index) {
                                           return Card(
                                             child: ListTile(

                                                 onTap: () async {
                                                   setState(() {
                                                     print(
                                                         "incomeCatListSearch  ${incomeCatListSearch?[index].name}  ${incomeCatList[index].name}");
                                                     Navigator.pop(context);
                                                     Navigator.pushReplacement(
                                                       context,
                                                       MaterialPageRoute(
                                                         builder: (context) {
                                                           return AddIncomePage(
                                                               category: _searchController.text.isNotEmpty
                                                                   ? incomeCatListSearch![index]
                                                                   : incomeCatList[index]
                                                           );
                                                         },
                                                       ),
                                                     );
                                                   });
                                                 },
                                                 leading: CircleAvatar(
                                                     backgroundColor: KPrimaryMidLevelColor,
                                                     child: Icon(IconDataSolid(
                                                         _searchController.text
                                                             .isNotEmpty
                                                             ? incomeCatListSearch![index]
                                                             .icon
                                                             : incomeCatList[index]
                                                             .icon),size: 16,)

                                                 ),
                                                 // title: Text(_searchController.text.isNotEmpty? catListSearch![index]:catList[index])
                                                 title: Text(
                                                     _searchController.text
                                                         .isNotEmpty
                                                         ? incomeCatListSearch![index]
                                                         .name
                                                         : incomeCatList[index]
                                                         .name)

                                             ),
                                           );
                                         });
                                   }
                                   },)
              )
            ],
          ),
        ),
      ),

    );
  }
}

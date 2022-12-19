import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/BudgetModel.dart';
import '../../../models/category.dart';
import '../category/service/CommonService.dart';
import 'BudgetService.dart';

class CatBudget extends StatefulWidget {
  const CatBudget({Key? key}) : super(key: key);

  @override
  State<CatBudget> createState() => _CatBudgetState();
}

final CommonService _commonService = CommonService();
final BudgetService _budgetService = BudgetService();
List<Cat> catList = [];
List<BudgetModel> budgetList = [];
int position = -1;
class _CatBudgetState extends State<CatBudget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category for budget'),
      ),
      body: FutureBuilder<List<Cat>>(
        future: _commonService.retrieveCategories(),
        builder: (context, future) {
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
                          //   print("click $position");
                          Navigator.pop(context);
                          // openDailog();
                          // iconId = index;
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
  }
}

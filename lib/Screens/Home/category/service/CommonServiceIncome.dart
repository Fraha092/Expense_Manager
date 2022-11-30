
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../models/category.dart';

class CommonServiceIncome{
  final DocumentReference<Map<String, dynamic>> _category =
  FirebaseFirestore.instance.collection('income_category').doc("0");

  Future saveCategoriesIn() async {
    try {
      _category.set({
        "Item": incomeCatList.map<Map>((e) => e.toMap()).toList(),
      });
    } catch (e) {
      return "false";
    }
  }

  Future<List<IncomeCat>> retrieveCategories() async {
    List<IncomeCat> incomeCatList = [];

    try {
      var querySnapshot = await _category.get();
      final Map<String, dynamic>? allData = querySnapshot.data();

      allData?["Item"].forEach((child) {
        IncomeCat incomeCat =  IncomeCat(id: child["id"], name: child["name"], icon: child["icon"]);
        incomeCatList.add(incomeCat);
      });
      print("allData  ${allData?["Item"]}  ${incomeCatList.length} ");

      return incomeCatList;
    } catch (e) {
      print("commonService +error   ${incomeCatList.length}");

      return incomeCatList;
    }
  }

}


final List<IncomeCat>incomeCatList=[
  IncomeCat(id: 0, name: 'Salary', icon: 0xf2b7),
  IncomeCat(id: 1, name: 'Bonus', icon: 0xf53c),
  IncomeCat(id: 2, name: 'Pension', icon: 0xf0d6),
  IncomeCat(id: 4, name: 'Allowance', icon: 0xf79c),
  IncomeCat(id: 5, name: 'Other Income', icon: 0xf067),

];
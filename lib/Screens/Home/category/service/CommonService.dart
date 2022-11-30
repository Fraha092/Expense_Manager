
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../models/category.dart';

class CommonService {
  final DocumentReference<Map<String, dynamic>> _category =
  FirebaseFirestore.instance.collection('category').doc("0");

  Future saveCategories() async {
    try {
      _category.set({
        "Item": catList.map<Map>((e) => e.toMap()).toList(),
      });
    } catch (e) {
      return "false";
    }
  }

  Future<List<Cat>> retrieveCategories() async {
    List<Cat> catList = [];

    try {
      var querySnapshot = await _category.get();
      final Map<String, dynamic>? allData = querySnapshot.data();

      allData?["Item"].forEach((child) {
        Cat cat =  Cat(id: child["id"], name: child["name"], icon: child["icon"]);
        catList.add(cat);
      });
      print("allData  ${allData?["Item"]}  ${catList.length} ");

      return catList;
    } catch (e) {
      print("commonService +error   ${catList.length}");

      return catList;
    }
  }
}


  final List<Cat> catList = [
    Cat(id: 0, name: 'Food', icon: 0xf818),
    Cat(id: 1, name: 'Home', icon: 0xf015),
    Cat(id: 2, name: 'Shopping', icon: 0xf290),
    Cat(id: 3, name: 'Health', icon: 0xf469),
    Cat(id: 4, name: 'Bills', icon: 0xf0d6),
    Cat(id: 5, name: 'Groceries', icon: 0xf290),
    Cat(id: 6, name: 'Telephone', icon: 0xf6b6),
    Cat(id: 7, name: 'Education', icon: 0xf19d),
    Cat(id: 8, name: 'Pet', icon: 0xf80f),
    Cat(id: 8, name: 'Sport', icon: 0xf44e),
    Cat(id: 9, name: 'Others Expense', icon: 0x2b),
     //Cat(index: 0, name: "Food", icon:FontAwesomeIcons.cartShopping),
    // Cat(index: 1, name: "Bills", icon:FontAwesomeIcons.moneyBill ),
    // Cat(index: 2, name: "Transportation", icon:FontAwesomeIcons.bus ),
    // Cat(index: 3, name: "Home", icon:FontAwesomeIcons.house ),
    // Cat(index: 4, name: "Entertainment", icon:FontAwesomeIcons.gamepad ),
    // Cat(index: 5, name: "Shopping", icon:FontAwesomeIcons.bagShopping ),
    // Cat(index: 6, name: "Clothing", icon:FontAwesomeIcons.shirt ),
    //Cat(index: 7, name: "Insurance", icon:FontAwesomeIcons.hammer ),
    // Cat(index: 8, name: "Telephone", icon:FontAwesomeIcons.phone ),
    // Cat(index: 9, name: "Health", icon:FontAwesomeIcons.briefcaseMedical ),
    // Cat(index: 10, name: "Sport", icon:FontAwesomeIcons.football ),
    // Cat(index: 11, name: "Beauty", icon:FontAwesomeIcons.marker ),
     //Cat(id: 12, name: "Education", icon:FontAwesomeIcons.graduationCap ),
    // Cat(index: 13, name: "Gift", icon:FontAwesomeIcons.gift ),
    // Cat(index: 14, name: "Pet", icon:FontAwesomeIcons.dog ),
    // Cat(index: 15, name: "Others Expense", icon:FontAwesomeIcons.plus ),
    // Cat(index: 16, name: "Drinks", icon:FontAwesomeIcons.martiniGlassCitrus ),

  ];























// Future<List<Cat>>getCatList() async{
//   List<Cat>catList=[];
//   var sharedPreferences = await SharedPreferences.getInstance();
//   Set<String>keys=sharedPreferences.getKeys();
//   for(int i=0;i<keys.length;i++){
//     String value=sharedPreferences.getStringList(keys.elementAt(i));
//     catList.add(value);
//   }
//   return catList;
// }
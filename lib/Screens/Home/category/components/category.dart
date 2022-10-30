import 'package:expense_app/Screens/Home/expense/add_expense_page.dart';
import 'package:expense_app/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Cat {
  final int index;
  final String name;
  final IconData icon;

  Cat(this.index, this.name, this.icon);
}

class CategoryScreen extends StatefulWidget {

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
//  String search='';
  final TextEditingController _searchController = TextEditingController();

  final List<Cat> catList = [
    Cat(0, "Food", FontAwesomeIcons.pizzaSlice),
    Cat(1, "Bills", FontAwesomeIcons.moneyBill),
    Cat(2, "Transportation", FontAwesomeIcons.bus),
    Cat(3, "Home", FontAwesomeIcons.house),
    Cat(4, "Entertainment", FontAwesomeIcons.gamepad),
    Cat(5, "Shopping", FontAwesomeIcons.bagShopping),
    Cat(6, "Clothing", FontAwesomeIcons.shirt),
    Cat(7, "Insurance", FontAwesomeIcons.hammer),
    Cat(8, "Telephone", FontAwesomeIcons.phone),
    Cat(9, "Health", FontAwesomeIcons.briefcaseMedical),
    Cat(10, "Sport", FontAwesomeIcons.football),
    Cat(11, "Beauty", FontAwesomeIcons.marker),
    Cat(12, "Education", FontAwesomeIcons.book),
    Cat(13, "Gift", FontAwesomeIcons.gift),
    Cat(14, "Pet", FontAwesomeIcons.dog),
    Cat(14, "Others Expense", FontAwesomeIcons.plus),
    Cat(14, "Drinks", FontAwesomeIcons.martiniGlassCitrus),
  ];
  List<Cat>? catListSearch;
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
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text(
          "Category",
          style: TextStyle(fontSize: 18.0),
        ),
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
                  child: _searchController.text.isNotEmpty &&
                          catListSearch!.isEmpty
                      ? const Center()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _searchController.text.isNotEmpty
                              ? catListSearch!.length
                              : catList.length,
                          itemBuilder: (context, index) {
                            // late String position=index.toString();
                            //  if(_searchController.text.isEmpty){
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  //  print("catListSearch" +  catListSearch![index]! + catList[index]);
                                  print("${catListSearch?[index].name}  ${catList[index].name}");
                                  //Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return AddExpensePage(categoryTitle: catList[index].name,);
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
                                      catList[index].icon,
                                      size: 22,
                                      color: Colors.brown.shade800,
                                    ),
                                  ),
                                  // title: Text(_searchController.text.isNotEmpty? catListSearch![index]:catList[index])
                                  title: Text(
                                    catList[index].name.toString(),
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
    );
  }
}

// import 'package:expense_app/Screens/Home/category/components/grid_search_screen.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'Category',
//     home: Category(),
//     theme: ThemeData(
//         brightness: Brightness.light,
//         primaryColor: Colors.white70,
//     ),
//   )
//   );
// }
// class Category extends StatelessWidget {
//
//   const Category({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.white70,
//       title: Text("Category"),
//       actions: [
//         IconButton(onPressed: ()=> Navigator.of(context).
//         push(MaterialPageRoute(builder: (_)=> GridSearchScreen())),
//             icon: Icon(Icons.search))
//       ],
//       ),
//     );
//   }
// }

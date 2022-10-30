import 'package:expense_app/Screens/Home/category/components/category.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white70,
        title: const Text("Category"),
        // actions: [
        //   IconButton(onPressed: ()=> Navigator.of(context).
        //   push(MaterialPageRoute(builder: (_)=> const GridSearchScreen())),
        //       icon: const Icon(Icons.search))
        // ],
      ),body: CategoryScreen(),
    );

  }
}

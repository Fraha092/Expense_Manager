/*import 'package:expense_app/Screens/Home/home_screen.dart';
import 'package:expense_app/Screens/Home/category/category_chart_page.dart';
import 'package:expense_app/Screens/Home/category/category_page.dart';
import 'package:expense_app/Screens/Home/main_screen.dart';
import 'package:expense_app/Screens/Home/others/f_ques_answer_page.dart';
import 'package:expense_app/Screens/Home/others/logout_page.dart';
import 'package:expense_app/Screens/Home/payment/payment_method_page.dart';
import 'package:expense_app/Screens/Home/others/rate_us_page.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/constants.dart';
import '../Home/expense/add_expense_page.dart';
import 'income/add_income_page.dart';


class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  var currentPage=DrawerSections.home;
  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.home) {
      container = HomeScreen();
    }
    else if (currentPage == DrawerSections.addExpense){
      container=AddExpensePage();
    }
    else if(currentPage==DrawerSections.addIncome){
      container=AddIncomePage();
    }
    else if(currentPage==DrawerSections.category){
      container=CategoryPage();
    }
    else if(currentPage==DrawerSections.categoryChart){
      container=CategoryChartPage();
    }
    else if(currentPage==DrawerSections.FAQ){
      container=QuesAnswerPage();
    }
    else if(currentPage==DrawerSections.rateUs){
      container=RateUsPage();
    }
    else if(currentPage==DrawerSections.logout){
      container=LogoutPage();
    }
    return Scaffold(
      body: container,
      drawer: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              UserAccountsDrawerHeader(accountName: Text("Homiyo"), accountEmail: Text("homiyo@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network('https://i0.wp.com/theubj.com/wp-content/uploads/2022/09/Chainsaw-Man-Season-1.jpg?resize=750%2C375&ssl=1',
                    fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),

                decoration: BoxDecoration(
                  color: kPrimaryColor,
                ),
              )
           
            ],
          ),
        ),
      ),
    );
  }
}*/

/*enum DrawerSections{
  home,
  addExpense,
  addIncome,
  category,
  categoryChart,
  FAQ,
  rateUs,
  logout,
}*/


/*class NavScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Oflutter.com'),
            accountEmail: Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {
            Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) {
            return MainScreen();
            },
            ),
            )
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Income'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddIncomePage();
                  },
                ),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.money_off),
            title: Text('Add Expense'),
            onTap: () => {
    Navigator.pop(context),

    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddExpensePage()),
                  ),
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Category'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CategoryPage();
                  },
                ),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.pie_chart),
            title: Text('Category Chart'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CategoryChartPage();
                  },
                ),
              )

            },
          ),
          ListTile(
            leading: Icon(Icons.payments),
            title: Text('Payment Method'),
            onTap: ()=> {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PaymentMethodPage();
                  },
                ),
              )
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text('FAQ'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return QuesAnswerPage();
                  },
                ),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.star_rate),
            title: Text('Rate Us'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return RateUsPage();
                  },
                ),
              )
            },
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LogoutPage();
                  },
                ),
              )
            },
          ),
        ],
      ),
    );
  }
}*/



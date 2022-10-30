import 'package:expense_app/Screens/Home/category/components/category.dart';
//import 'package:expense_app/Screens/Home/category/components/grid_search_screen.dart';
//import 'package:expense_app/Screens/Home/nav_screen.dart';
import 'package:expense_app/Screens/Home/payment/payment_method_page.dart';
import 'package:expense_app/Screens/Home/transaction/transaction_filter_page.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'category/category_chart_page.dart';
import 'category/category_page.dart';
import 'expense/add_expense_page.dart';
import 'home_screen.dart';
import 'income/add_income_page.dart';
//import 'main_screen.dart';
//import 'main_screen.dart';
import 'others/f_ques_answer_page.dart';
import 'others/logout_page.dart';
import 'others/rate_us_page.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MainScreenPage extends StatefulWidget {
  late  DrawerSections currentPage;

   MainScreenPage({Key? key , required  this.currentPage}) : super(key: key);
  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {


  @override
  Widget build(BuildContext context) {
    var container;
    if (widget.currentPage == DrawerSections.home) {
      container = const HomeScreen();
    } else if (widget.currentPage == DrawerSections.addExpense) {
      container = AddExpensePage(categoryTitle: '');
    } else if (widget.currentPage == DrawerSections.addIncome) {
      container =  AddIncomePage(categoryTitle: '');
    } else if (widget.currentPage == DrawerSections.transactionFilter) {
      container = const TransactionFilterPage();
    } else if (widget.currentPage == DrawerSections.category) {
      container = const CategoryPage();
    } else if (widget.currentPage == DrawerSections.categoryChart) {
      container = const CategoryChartPage();
    } else if (widget.currentPage == DrawerSections.paymentMethod) {
      container = const PaymentMethodPage();
    } else if (widget.currentPage == DrawerSections.FQA) {
      container = const QuesAnswerPage();
    } else if (widget.currentPage == DrawerSections.rateUs) {
      container = const RateUsPage();
    } else if (widget.currentPage == DrawerSections.logOut) {
      container = const LogoutPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Expense Management App"),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserAccountsDrawerHeader(accountName: const Text("Homiyo"),
                accountEmail: const Text("homiyo@gmail.com"),
                currentAccountPicture: CircleAvatar(
                 child: ClipOval(
                  child: Image.network('https://i0.wp.com/theubj.com/wp-content/uploads/2022/09/Chainsaw-Man-Season-1.jpg?resize=750%2C375&ssl=1',
                  fit: BoxFit.cover,width: 90,height: 90,
                  )
                 )
     ),

          decoration: const BoxDecoration(
            color: Colors.teal,
              ),
              ),
              MyDrawerList(),
            ],
          ),
        ),
      ),
    );
  }
  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1,"Home", Icons.home,
              widget.currentPage == DrawerSections.home ? true : false),
          menuItem(2, "Add Expense", Icons.money_off,
              widget.currentPage == DrawerSections.addExpense ? true : false),
          menuItem(3, "Add Income", Icons.add,
              widget.currentPage == DrawerSections.addIncome ? true : false),
          menuItem(4, "Transaction Filter", Icons.list,
              widget.currentPage == DrawerSections.transactionFilter ? true : false),
          menuItem(5, "Category", Icons.category,
              widget.currentPage == DrawerSections.category ? true : false),
          menuItem(6, "Category Chart", Icons.pie_chart,
              widget.currentPage == DrawerSections.categoryChart ? true : false),
          menuItem(7, " Payment Method", Icons.payments,
              widget.currentPage == DrawerSections.rateUs ? true : false),
          const Divider(),
          menuItem(8, "FQA", Icons.question_answer,
              widget.currentPage == DrawerSections.FQA ? true : false),
          menuItem(9, " Rate Us", Icons.star_rate,
              widget.currentPage == DrawerSections.rateUs ? true : false),
          const Divider(),

          menuItem(10, "Logout", Icons.exit_to_app,
              widget.currentPage == DrawerSections.logOut ? true : false),
        ],
      ),
    );
  }
  Widget menuItem(int id, String title, IconData icon, bool selected){
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          // final prefs= await SharedPreferences.getInstance();
          // prefs.setBool(('isLoggedIn'), false);
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              widget.currentPage = DrawerSections.home;
            } else if (id == 2) {
              //widget.currentPage = DrawerSections.addExpense;
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return AddExpensePage(categoryTitle: '');
                  })
              );
            } else if (id == 3) {
              //widget.currentPage = DrawerSections.transactionFilter;
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return AddIncomePage(categoryTitle: '');
                  })
              );
            } else if (id == 4) {
              //widget.currentPage = DrawerSections.addIncome;
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const TransactionFilterPage();

                  })
              );
            } else if (id == 5) {
              //widget.currentPage = DrawerSections.category;
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const CategoryScreen();
                    //return const GridSearchScreen();
                  })
              );
            } else if (id == 6) {
              widget.currentPage = DrawerSections.categoryChart;
            } else if (id == 7) {
             // widget.currentPage = DrawerSections.paymentMethod;
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const PaymentMethodPage();
                    //return const GridSearchScreen();
                  })
              );
            }else if (id == 8) {
              widget.currentPage = DrawerSections.FQA;
            } else if (id == 9) {
              widget.currentPage = DrawerSections.rateUs;
            } else if (id == 10) {
              widget.currentPage = DrawerSections.logOut;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(child: Icon(icon,size: 20,color: Colors.black ,)),
              Expanded(flex: 3,
                  child: Text(title,style: const TextStyle(color: Colors.black,fontSize: 16),))
            ],
          ),
        ),
      ),
    );
  }
}
enum DrawerSections {
  home,
  addExpense,
  addIncome,
  transactionFilter,
  category,
  categoryChart,
  paymentMethod,
  FQA,
  rateUs,
  logOut,
}

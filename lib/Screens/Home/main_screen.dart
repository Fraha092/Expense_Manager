import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/Screens/Home/transaction/transaction_filter_page.dart';
import 'package:expense_app/Screens/Welcome/welcome_screen.dart';
import 'package:expense_app/models/category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'others/ruffPage.dart';
import 'pie_chart/category_chart_page.dart';
import 'expense/add_expense_page.dart';
import 'home_screen.dart';
import 'income/add_income_page.dart';
import 'others/f_ques_answer_page.dart';
import 'others/logout_page.dart';
import 'others/Setting.dart';

class MainScreenPage extends StatefulWidget {
  late  DrawerSections currentPage;

   MainScreenPage({Key? key , required  this.currentPage}) : super(key: key);
  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //var userData= FirebaseFirestore.instance.collection("/userdata").doc("uid").get();
  getCurrentUser(){
    final User? user =_auth.currentUser;
    final uid = user!.uid;
    final uemail=user.email;
    print("uID $uid");
    return uemail;
  }


  final CollectionReference users= FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    var container;
    if (widget.currentPage == DrawerSections.home) {
      container = const HomeScreen();
    } else if (widget.currentPage == DrawerSections.addExpense) {
      container = AddExpensePage(category: Cat(id: 0,name: "", icon: 0));
    } else if (widget.currentPage == DrawerSections.addIncome) {
      container =  AddIncomePage(category: IncomeCat(id: 0,name: "", icon: 0));
    } else if (widget.currentPage == DrawerSections.transactionFilter) {
      container = const TransactionPage();
    }
    else if (widget.currentPage == DrawerSections.budget) {
      container = NewBudget();
    }
    else if (widget.currentPage == DrawerSections.categoryChart) {
      container = const CategoryChartPage();
    }

    else if (widget.currentPage == DrawerSections.FQA) {
      container = const QuesAnswerPage();
    } else if (widget.currentPage == DrawerSections.setting) {
      container = const NotificationPage();
    }

    else if (widget.currentPage == DrawerSections.logOut) {
      container = const LogoutPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Expense Management"),
        toolbarHeight: 80.0,

      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
                 UserAccountsDrawerHeader(
                  accountName: Text(""),
            //       StreamBuilder(
            //         stream: FirebaseAuth.instance.authStateChanges(),
            //        builder: (context,snapshot){
            //       if(snapshot.connectionState!= ConnectionState.active){
            //         return Center(
            //        child: CircularProgressIndicator(),
            //         );
            //       }
            //       final user=snapshot.data;
            //       final uid = user!.uid;
            //       if(user!= null){
            //         print(user);
            //         CollectionReference users= FirebaseFirestore.instance.collection('users');
            //         return FutureBuilder<DocumentSnapshot>(
            //        future: users.doc(uid).get(),
            //        builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
            //          if(snapshot.hasError){
            //            return Text("Something went wrong");
            //          }
            //          if(snapshot.hasData && !snapshot.data!.exists){
            //            return Text("Document does not exist");
            //          }
            //          if(snapshot.connectionState==ConnectionState.done){
            //            Map<String,dynamic>data=snapshot.data!.data() as Map<String,dynamic>;
            //            return  Text("${data['name']}",style: TextStyle(fontSize: 16));
            //          }
            //          return Text("Loading");
            //        },
            //         );
            //       }
            //       else{
            //         return Text("user is not logged in");
            //       }
            //     },
            // ),
                  accountEmail: Text(''),
                  //Text(getCurrentUser(),style: TextStyle(fontSize: 16),),
          decoration: const BoxDecoration(
            color: kPrimaryColor,
              image: DecorationImage(
                  image: AssetImage('assets/images/expense.png'),
                  fit: BoxFit.fitHeight,)
                ),
                ),

              SizedBox(
                height: 10,
                width: 100,
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
          menuItem(5, "Budget", Icons.balance,
              widget.currentPage == DrawerSections.budget ? true : false),
          menuItem(6, "Category Chart", Icons.pie_chart,
              widget.currentPage == DrawerSections.categoryChart ? true : false),

          const Divider(),

          menuItem(7, " Setting", Icons.settings,
              widget.currentPage == DrawerSections.setting ? true : false),

          const Divider(),

          menuItem(8, "Logout", Icons.exit_to_app,
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
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              widget.currentPage = DrawerSections.home;
            } else if (id == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return AddExpensePage(category: Cat(id: 0, name: "", icon: 0));
                  })
              );
            } else if (id == 3) {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return AddIncomePage(category: IncomeCat(id: 0, name: "", icon: 0));
                  })
              );
            } else if (id == 4) {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const TransactionPage();
                  })
              );
            }
            else if (id == 5) {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return NewBudget();
                  })
              );
            }
            else if (id == 6) {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const CategoryChartPage();
                  })
              );
            }

            else if (id == 7) {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const NotificationPage();
                  })
              );
            }
            else if (id == 8) {
              _signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const WelcomeScreen();
                  })
              );
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
  budget,
  categoryChart,
  FQA,
  setting,
  logOut,
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}
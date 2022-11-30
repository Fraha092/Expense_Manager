import 'package:expense_app/Screens/Home/category/service/CommonService.dart';
import 'package:expense_app/Screens/Home/category/service/CommonServiceIncome.dart';
import 'package:expense_app/services/auth.dart';
//import 'package:expense_app/Screens/Home/nav_screen.dart';
import 'package:flutter/material.dart';
import '../../../components/existing_an_account.dart';
import '../../../constants.dart';
import '../../../models/loginuser.dart';
import '../../Home/main_screen.dart';
import '../../Signup/signup_screen.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SecureStorage {
  // Create storage
  final storage = const FlutterSecureStorage();

  final String _keyUserName = 'username';
  final String _keyPassWord = 'password';

  Future setUserName(String username) async {
    await storage.write(key: _keyUserName, value: username);
  }

  Future<String?> getUserName() async {
    return await storage.read(key: _keyUserName);
  }

  Future setPassWord(String password) async {
    await storage.write(key: _keyPassWord, value: password);
  }

  Future<String?> getPassWord() async {
    return await storage.read(key: _keyPassWord);
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();

}

class _LoginFormState extends State<LoginForm> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final SecureStorage _secureStorage=SecureStorage();
  final AuthService _auth = AuthService();
  final CommonService _commonService = CommonService();
  final CommonServiceIncome _commonServiceIncome=CommonServiceIncome();
  @override
  void initState() {
    super.initState();
    fetchSecureStorageData();
  }

  Future<void> fetchSecureStorageData() async {
    _email.text = await _secureStorage.getUserName() ?? '';
    _password.text = await _secureStorage.getPassWord() ?? '';
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      //key: _fo,
      child: Column(
        children: [
          TextFormField(
            controller: _email,
            validator: (value) {
              if (value != null) {
                if (value.contains('@') && value.endsWith('.com')) {
                  return null;
                }
                return 'Enter a Valid Email Address';
              }
            },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email)
            {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _password,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () async {
                await _secureStorage.setUserName(_email.text);
                await _secureStorage.setPassWord(_password.text);
               //  final prefs= await SharedPreferences.getInstance();
               // prefs.setBool('isLoggedIn',true);
                dynamic result = await _auth.signInEmailPassword(LoginUser(email: _email.text,password: _password.text));
                if (result.uid == null) { //null means unsuccessfull authentication
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(result.code),
                        );
                      });
                }else{
                  _commonService.saveCategories();
                  _commonServiceIncome.saveCategoriesIn();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MainScreenPage(currentPage: DrawerSections.home);
                      },
                    ),
                  );
                }
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}







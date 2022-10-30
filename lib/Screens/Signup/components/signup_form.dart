import 'package:expense_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../components/existing_an_account.dart';
import '../../../constants.dart';
import '../../../models/loginuser.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final AuthService _auth = AuthService();
  final _name=TextEditingController();
  final _number=TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
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
                child: Icon(Icons.mail),
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: TextFormField(
            controller: _name,
            validator: (value){
              if(value!.isEmpty) {
                return ("Required Name");
              }
            },

            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (name) {},
            decoration: const InputDecoration(
              hintText: "Your Name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),

          ),


          Padding(padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _number,
              validator: (value){
                if(value!.isEmpty) {
                  return ("Required Valid Number");
                }
              },

              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (number) {},
              decoration: const InputDecoration(
                hintText: "Your Number",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.phone),
                ),
              ),
            ),

          ),


          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _password,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                if (value.trim().length < 8) {
                  return 'Password must be at least 8 characters in length';
                }
                return null;
              } ,
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
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () async {
              dynamic result = await _auth.registerEmailPassword(LoginUser(email: _email.text,password: _password.text));
              dynamic result1 = await _auth.postDetailsToFirestore(_email.text,_name.text,_number.text);
              if (result.uid == null) { //null means unsuccessful authentication
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(result.code),
                      );
                    });
              }
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
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







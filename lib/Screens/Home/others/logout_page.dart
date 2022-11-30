import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: Container(),
    onTap: ()async{
        await FirebaseAuth.instance.signOut();
    }
      ,
    );
  }
}

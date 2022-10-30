import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../constants.dart';


class LoginScreenTopImage extends StatefulWidget {
  const LoginScreenTopImage({Key? key}) : super(key: key);

  @override
  State<LoginScreenTopImage> createState() => _LoginScreenTopImageState();
}

class _LoginScreenTopImageState extends State<LoginScreenTopImage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 5,
              child: Image.asset("assets/images/login.jpg",height: 235,width: 250),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding * 2),
      ],
    );  }
}




import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../constants.dart';

class SignUpScreenTopImage extends StatefulWidget {
  const SignUpScreenTopImage({
    Key? key,

  }) : super(key: key);

  @override
  State<SignUpScreenTopImage> createState() => _SignUpScreenTopImageState();
}

class _SignUpScreenTopImageState extends State<SignUpScreenTopImage> {
 // final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "".toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 3,
              child: Image.asset("assets/images/registration1.png"),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding),
      ],
    );
  }
}




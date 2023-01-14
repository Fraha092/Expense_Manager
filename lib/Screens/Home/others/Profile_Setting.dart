import 'package:expense_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileSettingPage extends StatefulWidget {
  const ProfileSettingPage({Key? key}) : super(key: key);

  @override
  State<ProfileSettingPage> createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
var userData= FirebaseFirestore.instance.collection("/userdata").doc("uid").get();
  getCurrentUser(){
    final User? user =_auth.currentUser;
    final uid = user!.uid;
    final uemail=user.email;
    print("uID $uid");
    return uemail;
  }
  //final CollectionReference users= FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // leading: BackButton(),
        backgroundColor: kPrimaryColor,
        title: const Text('Profile'),
      ),
      body:
      ListView(
        children: <Widget>[
          Container(),
          Container(
            height: 80,width: 100,
            child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context,snapshot){
                if(snapshot.connectionState!= ConnectionState.active){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final user=snapshot.data;
                final uid = user!.uid;
                if(user!= null){
                  print(user);
                  CollectionReference users= FirebaseFirestore.instance.collection('users');
                  return FutureBuilder<DocumentSnapshot>(
                    future: users.doc(uid).get(),
                      builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
                      if(snapshot.hasError){
                        return const Text("Something went wrong");
                      }
                      if(snapshot.hasData && !snapshot.data!.exists){
                        return const Text("Document does not exist");
                      }
                      if(snapshot.connectionState==ConnectionState.done){
                        Map<String,dynamic>data=snapshot.data!.data() as Map<String,dynamic>;
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 25),
                          child: Text("Name:  ${data['name']}",style: const TextStyle(fontSize: 17),),
                        );
                      }
                      return const Text("Loading");
                      },
                  );
                }
                else{
                  return const Text("user is not logged in");
                }
              },

            ),

          ),
          const Divider(
            height: 2,
          ),
          //mail
          Container(
              height: 80,
              width: 100,
              child:
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                child: Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'Mail: ' + getCurrentUser(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 17),
                ),
              )

          ),
          Divider(
            height: 2,
          ),
          //phone
          Container(
            height: 80,
            width: 100,
            child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.active) {
                  return const Center(
                      child: CircularProgressIndicator()); // 👈 user is loading
                }
                final user = snapshot.data;
                final uid = user?.uid; // 👈 get the UID
                if (user != null) {
                  print(user);
                  CollectionReference users =
                  FirebaseFirestore.instance.collection('users');
                  return FutureBuilder<DocumentSnapshot>(
                    future: users.doc(uid).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Something went wrong");
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return const Text("Document does not exist");
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                          child: Text("Phone:  ${data['number']}",style: TextStyle(fontSize: 17),),
                        );
                      }

                      return const Text("loading");
                    },
                  );
                } else {
                  return const Text("user is not logged in");
                }
              },
            ),
          ),
          Divider(
            height: 2,
          ),

        ],
      ),
    );
  }
}

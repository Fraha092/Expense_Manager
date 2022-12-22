
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/Screens/Home/others/Profile_Setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../category/service/Notification_Service.dart';

class Strings {
  static const applockEnable = 'appLockEnabled';
  static const notifyDaily = 'notifyDaily';
  static const alarmTime = 'alarmTime';
  static const userName = 'userName';
  static const profilePhoto = 'profilePhoto';
  static const reminderHour = 'reminderH';
  static const reminderMin = 'reminderM';
}


class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);


  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {


  TextStyle secTitleStyle = const TextStyle(fontWeight: FontWeight.bold,color: kPrimaryColor,fontSize: 16);
  late SharedPreferences prefs;
  bool isNotifiyDaily = false;
  bool isApplockEnable = false;
  TimeOfDay? pickedTime;
  late NotificationService notificationService;

  @override
  void initState() {
    readSettings();
    notificationService = NotificationService();
    super.initState();
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    final int hour = prefs.getInt(Strings.reminderHour) ?? 21; //dafult 9:00 PM
    final int minute = prefs.getInt(Strings.reminderMin) ?? 0;

    setState(() {
      isApplockEnable = prefs.getBool(Strings.applockEnable) ?? false;
      isNotifiyDaily = prefs.getBool(Strings.notifyDaily) ?? false;
      pickedTime = TimeOfDay(hour: hour, minute: minute);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        toolbarHeight: 30.0,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      body: SettingsList(
          contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          platform: DevicePlatform.windows,
          lightTheme: const SettingsThemeData(
            leadingIconsColor: kPrimaryColor,
            titleTextColor: kPrimaryColor,
            trailingTextColor: kPrimaryColor,
          ),
          sections: [
            // SettingsSection(
            //     title: Text(
            //       'Profile',
            //       style: secTitleStyle,
            //     ),
            //     tiles: [
            //       CustomSettingsTile(
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: Material(
            //               child: InkWell(
            //                 onTap: () {
            //                   Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                           builder: (context) =>
            //                           const EditProfile())).whenComplete(() {
            //                     setState(() {
            //                       userName = box.get('userName', defaultValue: '');
            //                       imageString =
            //                           box.get('profilePhoto', defaultValue: '');
            //                     });
            //                   });
            //                 },
            //                 child: Padding(
            //                   padding: const EdgeInsets.symmetric(
            //                       vertical: 10, horizontal: 20),
            //                   child: Builder(builder: (context) {
            //                     return Row(
            //                       children: [
            //                         CircleAvatar(
            //                             radius: 40,
            //                             backgroundColor: Colors.transparent,
            //                             backgroundImage:
            //                             Util.getAvatharImage(imageString)),
            //                         const SizedBox(width: 10),
            //                         Expanded(
            //                           child: Text(
            //                             userName,
            //                             overflow: TextOverflow.ellipsis,
            //                             maxLines: 1,
            //                             style: const TextStyle(
            //                                 fontWeight: FontWeight.bold,
            //                                 fontSize: 15),
            //                           ),
            //                         ),
            //                         const Padding(
            //                           padding: EdgeInsets.all(8),
            //                           child: Icon(
            //                             Icons.edit,
            //                             color: Colors.blue,
            //                           ),
            //                         )
            //                       ],
            //                     );
            //                   }),
            //                 ),
            //               ),
            //             ),
            //           )),
            //     ]),
            /* SettingsSection(
                title: Text(
                  'Security',
                  style: secTitleStyle,
                ),
                tiles: [
                  SettingsTile.switchTile(
                      initialValue: isApplockEnable,
                      activeSwitchColor: Colors.blue,
                      onToggle: (val) async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PasscodeScreen()));
                        setState(() {
                          isApplockEnable = val;
                        });
                        await prefs.setBool(Strings.applockEnable, val);
                      },
                      title: const Text('Applock'),
                      leading: const Icon(Icons.lock)),
                  SettingsVisibility(
                    visibe: isApplockEnable,
                    child: SettingsTile(
                      title: Text(
                        'Change Password',
                        style: TextStyle(
                            color:
                                isApplockEnable ? Colors.black : Colors.grey),
                      ),
                      leading: const Icon(Icons.key),
                      enabled: isApplockEnable,
                      onPressed: (context) {},
                    ),
                  ),
                ]),*/
            SettingsSection(
                title: Text(
                  'Notification',
                  style: secTitleStyle,
                ),
                margin: EdgeInsetsDirectional.all(8.0),
                tiles: [
                  SettingsTile.switchTile(
                    initialValue: isNotifiyDaily,
                    activeSwitchColor: kPrimaryColor,
                    onToggle: (enable) async {
                      if (enable) {
                        enableNotification();
                      } else {
                        notificationService.cancelNotification(1);
                      }
                      setState(() {
                        isNotifiyDaily = enable;
                      });
                      await prefs.setBool(Strings.notifyDaily, enable);
                    },
                    title: const Text('Daily Reminder'),
                    leading: const Icon(Icons.notifications_active_outlined,color: kPrimaryColor,),
                  ),
                  SettingsTile(
                    title: Text(
                      'Notification Time',
                      style: TextStyle(
                          color: isNotifiyDaily ? Colors.black : Colors.grey,),
                    ),
                    leading: Icon(Icons.alarm,
                        color: isNotifiyDaily ? kPrimaryColor : Colors.grey),
                    enabled: isNotifiyDaily,
                    onPressed: (context) {
                      pickTime(context);
                    },
                    value: Text(
                        pickedTime != null ? pickedTime!.format(context) : '',
                        style: TextStyle(
                            color: isNotifiyDaily ? kPrimaryColor : Colors.grey,
                            fontWeight: FontWeight.bold)),
                  ),
                ]),
            SettingsSection(
                title: Text(
                  'Others',
                  style: secTitleStyle,
                ),
                margin: EdgeInsetsDirectional.all(8.0),
                tiles: [
                  // SettingsTile(
                  //     title: const Text('Profile'),
                  //     leading: const Icon(Icons.restore),
                  //     onPressed: (context) {
                  //       Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //         return const ProfileSettingPage();
                  //       }
                  //       )
                  //       );
                  //     }),
                  SettingsTile(
                      title: const Text('Reset Data'),
                      leading: const Icon(Icons.restore),
                      onPressed: (context) {
                        confirmReset(context);

                      }),
                  SettingsTile(
                      title: const Text('FQA'),
                      leading: const Icon(Icons.feedback_outlined),
                      onPressed: (context) {
                        //confirmReset(context);
                      }),
                  SettingsTile(
                    title: const Text('About'),
                    leading: const Icon(Icons.info_outline),
                    onPressed: (context) {
                      showAboutDialog(
                        context: context,
                        applicationIcon: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Image.asset('',
                                width: 50)),
                        applicationName: 'Expense Management',
                        applicationVersion: 'version 1.0.1',
                        children: <Widget>[
                          const Text('Developed by Farha Faeja Emu')
                        ],
                      );
                    },
                  )


                ]
            )
          ]),
    );
  }
  Future<dynamic> confirmReset(BuildContext ctx) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Warning'),
          content: const Text(
            "This will permanently delete the app's data including your transactions and preferences",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No')),
            TextButton(
                onPressed: () {
                  FirebaseFirestore.instance.collection('budget').get().then((snapshot) {
                    for (DocumentSnapshot doc in snapshot.docs) {
                      doc.reference.delete();
                    }
                  });
                  FirebaseFirestore.instance.collection('add_expense').get().then((snapshot) {
                    for (DocumentSnapshot doc in snapshot.docs) {
                      doc.reference.delete();
                    }
                  });
                  FirebaseFirestore.instance.collection('add_income').get().then((snapshot) {
                    for (DocumentSnapshot doc in snapshot.docs) {
                      doc.reference.delete();
                    }
                  });

                  // resetData(ctx);
                },
                child: const Text('Yes'))
          ],
        ));
  }
  pickTime(BuildContext context) async {
    TimeOfDay? pickedT = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        helpText: 'SELECT REMINDER TIME');

    if (pickedT != null) {
      setState(() {
        pickedTime = pickedT;
      });
      prefs.setInt(Strings.reminderHour, pickedT.hour);
      prefs.setInt(Strings.reminderMin, pickedT.minute);
      enableNotification();
    }
  }
  enableNotification() {
    notificationService.showNotificationDaily(
        id: 1,
        title: 'Expense Manager',
        body: 'Have you recorded your transactions today?',
        scheduleTime: pickedTime!);
  }


}
class SettingsVisibility extends AbstractSettingsTile {
  final bool visibe;
  final Widget child;
  const SettingsVisibility(
      {Key? key, required this.visibe, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(visible: visibe, child: child);
  }
}


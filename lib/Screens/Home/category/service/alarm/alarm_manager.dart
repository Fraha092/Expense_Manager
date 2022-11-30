//
// import 'dart:ffi';
//
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import '../notification_service.dart';
// import 'notification_service.dart';
//
// class SetAlarm {
//   static NotificationService notificationService = NotificationService();
//
//   static const String appName = "Alarm Manager Example";
//   static const String durationSeconds = "Seconds";
//   static const durationMinutes = "Minutes";
//   static const String durationHours = "Hours";
//   static const String oneShotAlarm = "oneShot";
//   static const String oneShotAtAlarm = "oneShotAt";
//   static const String periodicAlarm = "periodic";
//
//   final int _periodicTaskId = 3;
//
//   //
//   void cancelAlarm(){
//     AndroidAlarmManager.cancel(_periodicTaskId);
//   }
//
//   static void _periodicTaskCallback() {
//     print("Periodic Task Running");
//     notificationService.showNotifications();
//   }
//   schedulePeriodicAlarm(int dateTime) async {
//     Duration duration = await _chooseDuration(dateTime);
//     await AndroidAlarmManager.periodic(duration, _periodicTaskId, _periodicTaskCallback);
//     print('Duration $duration');
//   }
//   Future<Duration> _chooseDuration(int dateTime) async {
//
//     //String duration = "20";
//     String durationString = durationSeconds;
//
//     if (dateTime != null) {
//     //  int time = int.parse(duration);
//       if (durationString == durationSeconds) {
//         return Duration(seconds: dateTime);
//       }
//     }
//     return const Duration(seconds: 0);
//   }
//
// }

// import 'package:expense_app/Screens/Home/category/service/alarm/alarm_manager.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:settings_ui/settings_ui.dart';
//
// class Strings {
//   static const applockEnable = 'appLockEnabled';
//   static const notifyDaily = 'notifyDaily';
//   static const alarmTime = 'alarmTime';
//   static const reminderHour = 'reminderH';
//   static const reminderMin = 'reminderM';
// }
//
//
// class NotificationPage extends StatefulWidget {
//   const NotificationPage({Key? key}) : super(key: key);
//
//   @override
//   State<NotificationPage> createState() => _NotificationPageState();
// }
//
// class _NotificationPageState extends State<NotificationPage> {
//
// //SharedPreferences prefs = SharedPreferences.getInstance();
// late SharedPreferences prefs;
//
//   TextStyle secTitleStyle = const TextStyle(fontWeight: FontWeight.bold);
//   bool isNotifiyDaily = true;
//   bool isApplockEnable = false;
//   TimeOfDay? pickedTime;
//   //SetAlarm setAlarm = SetAlarm();
//
//
//
//  // SetAlarm alarm = SetAlarm();
//
//   enableNotification() {
//     //alarm.scheduleOneShotAlarm(true);
//     int datetime = (pickedTime?.minute ?? 0 * 60);
//     alarm.schedulePeriodicAlarm(datetime);
//     print("Datetime $datetime");
//   }
// // readSettings() async {
// //
// //   setState(() {
// //     pickedTime = ;
// //   });
// // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Text('Settings',
//         ),
//         centerTitle: true,
//       ),
//       body:
//       SettingsList(
//         contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 15),
//         platform: DevicePlatform.android,
//         lightTheme: const SettingsThemeData(
//             leadingIconsColor: Colors.teal,
//             titleTextColor: Colors.teal,
//             trailingTextColor: Colors.teal
//         ),
//         sections: [
//           SettingsSection(
//               title: Text(
//                 'Notification',
//
//               ),
//               tiles: [
//                 SettingsTile.switchTile(
//                   initialValue: isNotifiyDaily,
//                   onToggle: (enable) async {
//                     if (enable) {
//                       enableNotification();
//                     }
//                     else {
//                       //notificationService.cancelNotification(1);
//                       alarm.cancelAlarm();
//                     }
//                     setState(() {
//                       isNotifiyDaily = enable;
//                     });
//                     //prefs.setBool(Strings.notifyDaily, enable);
//                   },
//                   title: const Text('Daily Reminder'),
//                   leading: const Icon(Icons.notification_add_outlined),
//                 ),
//                 SettingsTile(
//                   title: Text('Notification Time',
//                     style: TextStyle(
//                         color: isNotifiyDaily ? Colors.black : Colors.grey),
//                   ),
//                   leading: Icon(Icons.alarm,
//                     color: isNotifiyDaily ? Colors.teal : Colors.grey,),
//                   enabled: isNotifiyDaily,
//                   onPressed: (context) {
//                     pickTime(context);
//
//                   },
//                   value: Text(
//                     pickedTime != null ? pickedTime!.format(context) : '',
//                     style: TextStyle(
//                         color: isNotifiyDaily ? Colors.teal : Colors.grey,
//                         fontWeight: FontWeight.bold
//                     ),
//                   ),
//                 )
//               ]
//           ),
//           SettingsSection(
//               title: Text('Others',
//                 // style: secTitleStyle,
//               ),
//               tiles: [
//                 SettingsTile(
//                   title: const Text('Reset Data'),
//                   leading: const Icon(Icons.restore),
//                   onPressed: (context) {
//                     confirmReset(context);
//                   },
//                 ),
//                 SettingsTile(
//                   title: const Text('FQA'),
//                   leading: const Icon(Icons.feedback_outlined),
//                   onPressed: (context) {
//
//                   },
//                 ),
//                 SettingsTile(
//                   title: const Text('About'),
//                   leading: const Icon(Icons.info_outline),
//                   onPressed: (context) {
//
//                   },
//                 )
//               ]
//           )
//         ],
//       ),
//
//
//     );
//   }
//
//   Future<dynamic> confirmReset(BuildContext ctx) {
//     return showDialog(
//         context: context,
//         builder: (context) =>
//             AlertDialog(
//               title: const Text('warning'),
//               content: const Text(
//                 "This will permanently delete the apps data including your transactions and preferences.",
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               actions: [
//                 TextButton(onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                     child: Text('No')),
//                 TextButton(onPressed: () {
//                   // resetData(ctx);
//                 },
//                     child: Text('Yes')),
//               ],
//             ));
//   }
//
//   pickTime(BuildContext context) async {
//     TimeOfDay? pickedT = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//         helpText: 'Select Reminder Time'
//     );
//     if (pickedT != null) {
//       setState(() {
//         pickedTime = pickedT;
//
//       });
//
//     }
//   }
// }

//package
// <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
// <uses-permission android:name="android.permission.WAKE_LOCK"/>
//
// <!-- For apps with targetSDK=31 (Android 12) -->
// <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>


//(/activity)
//<service
//            android:name="dev.fluttercommunity.plus.androidalarmmanager.AlarmService"
//            android:permission="android.permission.BIND_JOB_SERVICE"
//            android:exported="false"/>
//        <receiver
//            android:name="dev.fluttercommunity.plus.androidalarmmanager.AlarmBroadcastReceiver"
//            android:exported="false"/>
//        <receiver
//            android:name="dev.fluttercommunity.plus.androidalarmmanager.RebootBroadcastReceiver"
//            android:enabled="false"
//            android:exported="false">
//            <intent-filter>
//                <action android:name="android.intent.action.BOOT_COMPLETED" />
//            </intent-filter>
//        </receiver>
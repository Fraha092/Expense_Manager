//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {

  List<String>paymentList = ['Select Payment Method', 'Bank','Card','Cash','Others'
  ];
  String _payment='Select Payment Method';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
      ),
      body: Center(
        child: DropdownButton(
          hint: const Text('Select Payment Method'), // Not necessary for Option 1
          value: _payment,
          onChanged: (newValue) {
            setState(() {
              _payment = newValue!;
            });
          },
          items: paymentList.map((location) {
            return DropdownMenuItem(
              value: location,
              child: Text(location),
            );
          }).toList(),
        ),
      ),
    );
  // final sugars = ['candy', 'chocolate', 'snicker'];
  // String? _currentSugars = 'candy';
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Payment Method'),
  //     ),
  //     body: Center(
  //       child: DropdownButtonFormField<String>(
  //         value: _currentSugars,
  //         items: sugars.map((sugar) {
  //           return DropdownMenuItem(
  //             value: sugar,
  //             child: Text('$sugar sugars'),
  //           );
  //         }).toList(),
  //         onChanged: (val) => setState(() => _currentSugars = val),
  //       ),
  //     ),
  //   );
  }
}

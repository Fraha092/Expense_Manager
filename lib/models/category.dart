import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//for expense category list
class Cat {
   int id;
   String name;
   int icon;

  Cat({required this.id, required this.name, required this.icon});

   factory Cat.fromMap(map) {
     return Cat(
       id: map['id'],
       name: map['name'],
       icon: map['icon'],
     );
   }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon':icon,
    };
  }
}


//for income category List
class IncomeCat {
  final int id;
  final String name;
  final int icon;

  IncomeCat({required this.id, required this.name, required this.icon});
  factory IncomeCat.fromMap(map) {
    return IncomeCat(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
    };
  }
}
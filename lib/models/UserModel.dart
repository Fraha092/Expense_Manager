class UserModel {
  String? email;
  String? name;
  String? number;
 // String? address;

  UserModel({this.email, this.name, this.number});// this.address});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      email: map['email'],
      name: map['name'],
      number: map['number'],
     // address: map['address'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
     'number': number,
   // 'address': address,
    };
  }
}
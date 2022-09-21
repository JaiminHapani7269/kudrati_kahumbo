// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

class UserModel {
  String? uid;
  String? mobile;
  String? c_name;

  UserModel({
    this.uid,
    this.mobile,
    this.c_name,
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      mobile: map['mobile'],
      c_name: map['c_name'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'mobile': mobile,
      'c_name': c_name,
    };
  }
}

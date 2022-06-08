class UserData {
  String email;
  String uid;

  UserData({
    required this.email,
    required this.uid,
  });

  UserData.fromMap(Map<String, dynamic> map)
      : email = map['email'] ?? "",
        uid = map['uid'] ?? "";

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uid': uid,
    };
  }
}

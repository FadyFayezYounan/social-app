class UserModel {
  final String? uId;
  final String? imagePath;
  final String? imageUrl;
  final String? name;
  final String? email;
  final String? bio;
  final String? phone;
  //final bool isDarkModeOn;

  const UserModel({
     this.uId,
     this.imagePath,
     this.imageUrl,
     this.name,
     this.email,
     this.bio,
    this.phone,
    //required this.isDarkModeOn,
  });

  UserModel copy({
    String? uId,
    String? imagePath,
    String? imageUrl,
    String? name,
    String? email,
    String? bio,
    String? phone,
    bool? isDarkModeOn,
  }) {
    return UserModel(
      uId: uId ?? this.uId,
      imagePath: imagePath ?? this.imagePath,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      phone: phone ?? this.phone,
      //isDarkModeOn: isDarkModeOn ?? this.isDarkModeOn,
    );
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'],
      imagePath: json['imagePath'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      email: json['email'],
      bio: json['bio'],
      phone: json['phone'],
      //isDarkModeOn: json['isDarkModeOn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uId':uId,
      'imagePath': imagePath,
      'imageUrl': imageUrl,
      'name': name,
      'email': email,
      'bio': bio,
      'phone':phone,
      //'isDarkModeOn': isDarkModeOn,
    };
  }
}





// class User {
//   final String imagePath;
//   final String name;
//   final String email;
//   final String bio;
//   final bool isDarkModeOn;
//
//   const User({
//     required this.imagePath,
//     required this.name,
//     required this.email,
//     required this.bio,
//     required this.isDarkModeOn,
//   });
//
//   User copy({
//     String? imagePath,
//     String? name,
//     String? email,
//     String? bio,
//     bool? isDarkModeOn,
//   }) {
//     return User(
//       imagePath: imagePath ?? this.imagePath,
//       name: name ?? this.name,
//       email: email ?? this.email,
//       bio: bio ?? this.bio,
//       isDarkModeOn: isDarkModeOn ?? this.isDarkModeOn,
//     );
//   }
//
//   static User fromJson(Map<String, dynamic> json) {
//     return User(
//       imagePath: json['imagePath'],
//       name: json['name'],
//       email: json['email'],
//       bio: json['bio'],
//       isDarkModeOn: json['isDarkModeOn'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'imagePath': imagePath,
//       'name': name,
//       'email': email,
//       'bio': bio,
//       'isDarkModeOn': isDarkModeOn,
//     };
//   }
// }

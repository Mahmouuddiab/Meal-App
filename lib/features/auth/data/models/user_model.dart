import 'package:meal_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.name, 
    required super.imageURL, 
    required super.phone,
    required super.pass,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      pass: map["user_metadata"]["password"] ?? "",
      name: map["user_metadata"]['name'] ?? '',
      imageURL:map["user_metadata"]['imageURL'] ?? '', 
      phone:map["user_metadata"]['phone'] ?? '',
    );
  }

  factory UserModel.fromEntity(User user){
    return UserModel(
      id: user.id, 
      email: user.email,
      name: user.name,
      imageURL: user.imageURL, 
      phone: user.phone, 
      pass: user.pass,
    );
  }

  User toEntity(){
    return User(
      id: id, 
      email: email,
      name: name,
      imageURL: imageURL, 
      phone: phone,
      pass: pass
    );
  }




}

// import 'package:json_serializable/builder.dart';
// import 'package:json_serializable/json_serializable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'address.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {

  String name;
  String email;
  String? phone;
  Address? address;
  int? age;

  User(this.name, this.email);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

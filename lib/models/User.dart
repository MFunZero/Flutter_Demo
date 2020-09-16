import 'package:json_annotation/json_annotation.dart';

// flutter packages pub run build_runner build 命令执行后生成
// user.g.dart 将在我们运行生成命令后自动生成
part 'User.g.dart';

@JsonSerializable()
class User {
//   //显式关联JSON字段名与Model属性的对应关系 
// @JsonKey(name: 'registration_date_millis')
// final int registrationDateMillis;

  final String name;
  final String email;

  User(this.name, this.email);

  // User.fromJson(Map<String, dynamic> json)
  //     : name = json['name'],
  //       email = json['email'];

  // Map<String, dynamic> toJson() => <String, dynamic>{
  //       'name': name,
  //       'email': email,
  //     };

   //不同的类使用不同的mixin即可
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);  

}


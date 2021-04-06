import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  int id;
  int dsDistributorId;
  String name;
  String workNumber;
  String inviteCode;
  String phone;
  int level;
  String password;
  String salt;
  String version;
  String avatarUrl;
  String gmtCreate;
  String gmtModified;
  String creator;
  String modifier;
  int isDeleted;
  int status;

  User({
    this.id,
    this.dsDistributorId,
    this.name,
    this.workNumber,
    this.inviteCode,
    this.phone,
    this.level,
    this.password,
    this.salt,
    this.version,
    this.avatarUrl,
    this.gmtCreate,
    this.gmtModified,
    this.creator,
    this.modifier,
    this.isDeleted,
    this.status,
  });
  factory User.fromJson(Map<String, dynamic> json) => _fromJson(json);
  static User _fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] as int,
      name: json["name"] as String,
      workNumber: json["workNumber"] as String,
      phone: json["phone"] as String,
      dsDistributorId: json["dsDistributorId"] as int,
      inviteCode: json["inviteCode"] as String,
      password: json["password"] as String,
      avatarUrl: json["avatarUrl"] as String,
      salt: json["salt"] as String,
      version: json["version"] as String,
      gmtCreate: json["gmtCreate"] as String,
      gmtModified: json["gmtModified"] as String,
      creator: json["creator"] as String,
      modifier: json["modifier"] as String,
      isDeleted: json["isDeleted"] as int,
      status: json["status"] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> model = new Map<String, dynamic>();
    return model;
  }
}

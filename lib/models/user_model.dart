class UserModel {
  String? name;
  String email;
  String? photo;

  UserModel({
    this.name,
    required this.email,
    this.photo,
  });

  UserModel.fromJson(Map<String, dynamic> json) : email = json['email'] {
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['photo'] = this.photo;
    return data;
  }
}

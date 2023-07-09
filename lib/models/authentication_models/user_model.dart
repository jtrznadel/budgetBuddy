class UserModel {
  String? email;
  String? password;
  String? confirmPassword;
  String? firstName;
  String? lastName;

  UserModel(
      {this.email, this.password, this.confirmPassword, this.firstName, this.lastName});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    return data;
  }
}

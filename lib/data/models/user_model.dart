class UserModel {
  String? sId;
  String? email;
  String? password;
  String? userProfile;
  String? username;
  String? createdOn;
  int? iV;

  UserModel(
      {this.sId,
        this.email,
        this.password,
        this.userProfile,
        this.username,
        this.createdOn,
        this.iV});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    userProfile = json['userProfile'];
    username = json['username'];
    createdOn = json['createdOn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['userProfile'] = this.userProfile;
    data['username'] = this.username;
    data['createdOn'] = this.createdOn;
    data['__v'] = this.iV;
    return data;
  }
}
class UserModel {
  String? name;
  String? email;

  UserModel(this.email,this.name);

  Map<String,dynamic> toJson(UserModel data){
    return {
      "name" : name,
      "email" : email,
    };
  }

  UserModel.fromJson(Map<String, dynamic> json){
    name = json["name"];
    email = json["email"];
  }
}
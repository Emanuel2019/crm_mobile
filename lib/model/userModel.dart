class UserModel {
  String id;
  String name;
  String email;
  String password;
  String phone;
  String city;
  String country;
  String gender;
  UserModel(
      {
       required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.phone,
      required this.city,
      required this.country,
      required this.gender});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
      city: json['city'] as String, 
      country: json['country'] as String,
      gender: json['gender'] as String,
    );
  }
  Map<String, dynamic> toJsonAdd() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "city": city,
      "country": country,
      "gender": gender,
    };
  }
  Map<String, dynamic> toJsonUpdate() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "city": city,
      "country": country,
      "gender": gender,
    };
  }
}

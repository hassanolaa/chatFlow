class user {
  String? imageUrl;
  String? username;
  String? bio;
  String? phone;
  int? age;
  String? gender;

  // constructor
  user(
      {this.imageUrl,
      this.username,
      this.bio,
      this.phone,
      this.age,
      this.gender});
  // to json
  Map<String, dynamic> toJson() => {
        'imageUrl': imageUrl,
        'username': username,
        'bio': bio,
        'phone': phone,
        'age': age,
        'gender': gender
      };
  // from json
  user.fromJson(Map<String, dynamic> json)
      : imageUrl = json['imageUrl'],
        username = json['username'],
        bio = json['bio'],
        phone = json['phone'],
        age = json['age'],
        gender = json['gender'];

 


}

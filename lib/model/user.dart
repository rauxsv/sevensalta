class User {
  String? name;
  String? phone;
  String? email;
  String? country;
  String? story;

  User({
    this.name,
    this.phone,
    this.email,
    this.country,
    this.story,
  });

  // factory method to create a User instance from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      country: map['country'],
      story: map['story'],
    );
  }

  // method to convert User instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'country': country,
      'story': story,
    };
  }
}

class User {
  final String name;
  final String email;
  final String picture;

  User({
    required this.name,
    required this.email,
    required this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final name = json['name']['first'] + ' ' + json['name']['last'];
    final email = json['email'];
    final picture = json['picture']['medium'];

    return User(
      name: name,
      email: email,
      picture: picture,
    );
  }
}
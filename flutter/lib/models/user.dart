class User {
  final String id;
  final String email;
  final String? name;

  User({required this.email, this.name, required this.id});

  User copyyWith({String? id, String? email, String? name}) {
    return User(
        email: email ?? this.email, id: id ?? this.id, name: name ?? this.name);
  }

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
        email: data['user']['email'],
        id: data['user']['_id'],
        name: data['user']['name']);
  }
}

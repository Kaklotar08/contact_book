class User {
  String? id;
  String? name;
  String? email;
  String? password;
  String? contact;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.contact,
  });

  @override
  String toString() {
    return '{"id": "$id", "name": "$name", "email": "$email", "password": "$password", "contact": "$contact"}';
  }
}

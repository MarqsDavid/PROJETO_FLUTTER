class User {
  final int? id; // The id can be an integer or null
  final String email;
  final String? password; // The password is optional
  final String nameUser; // Added field for the name

  User({
    this.id,
    required this.email,
    this.password, // The password is optional
    required this.nameUser, // The name is required
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Includes the id if not null
      'email': email,
      'password': password, // Includes the password if not null
      'nameUser': nameUser, // Includes the name
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? int.tryParse(map['id'].toString()) : null,
      email: map['email'] ?? '', // If email is null, assign an empty string
      password: map['password'], // The password can be null
      nameUser: map['nameUser'] ?? '', // If name is null, assign an empty string
    );
  }
}

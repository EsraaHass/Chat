class MyUser {
  static const routeName = 'myUsers';

  String? id;
  String? firstName;
  String? lastName;
  String? email;

  MyUser({this.id, this.firstName, this.lastName, this.email});

  MyUser.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          firstName: data['firstName'],
          lastName: data['lastName'],
          email: data['email'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}

class Contact {
  String firstName;
  String? middleName;
  String? lastName;
  String phone;
  String? email;

  Contact({
    required this.firstName,
    this.middleName,
    this.lastName,
    required this.phone,
    this.email,
  });

  String get fullName => "$firstName ${middleName ?? ''} ${lastName ?? ''}".trim();
}

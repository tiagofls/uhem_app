class Patient {
  final String name;
  final String sns;
  final String email;
  final String birthdate;
  final String phone;
  final String address;
  final String zipcode;

  Patient(this.name, this.sns, this.email, this.phone, this.address, this.zipcode, this.birthdate);

  Patient.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? "",
        sns = json['sns'] ?? "",
        email = json['email'] ?? "",
        birthdate = json['birth_date'] ?? "",
        phone = json['phone'] ?? "",
        address = json['address'] ?? "",
        zipcode = json['zipcode'] ?? "";
  

  Map<String, dynamic> toJson() => {
        'name': name,
        'sns' : sns,
        'email': email,
        'phone' : phone,
        'address' : address,
        'zipcode' : zipcode,
        'birth_date' : birthdate
  };
}
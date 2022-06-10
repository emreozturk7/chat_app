class Meet {
  String? email;
  String? date;
  String? hour;
  String? name;
  String? status;

  Meet({
    this.email,
    this.date,
    this.hour,
    this.name,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'date': date,
      'hour': hour,
      'name': name,
      'status': status,
    };
  }

  factory Meet.fromMap(Map map) {
    return Meet(
      email: map['email'],
      date: map['date'],
      hour: map['hour'],
      name: map['name'],
      status: map['status'],
    );
  }
}

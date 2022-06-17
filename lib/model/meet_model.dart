class Meet {
  String? senderEmail;
  String? receiverEmail;
  String? date;
  String? hour;
  String? senderName;
  String? receiverName;
  String? status;

  Meet({
    this.senderEmail,
    this.receiverEmail,
    this.date,
    this.hour,
    this.receiverName,
    this.senderName,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderEmail': senderEmail,
      'receiverEmail': receiverEmail,
      'senderName': senderName,
      'receiverName': receiverName,
      'date': date,
      'hour': hour,
      'status': status,
    };
  }

  factory Meet.fromMap(Map map) {
    return Meet(
      senderEmail: map['senderEmail'],
      receiverEmail: map['receiverEmail'],
      date: map['date'],
      hour: map['hour'],
      senderName: map['senderName'],
      receiverName: map['receiverName'],
      status: map['status'],
    );
  }
}

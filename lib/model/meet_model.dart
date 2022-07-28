class Meet {
  String? senderEmail;
  String? receiverEmail;
  String? date;
  String? hour;
  String? senderName;
  String? receiverName;
  String? status;
  String? senderPhotoUrl;
  String? receiverPhotoUrl;

  Meet({
    this.senderEmail,
    this.receiverEmail,
    this.date,
    this.hour,
    this.receiverName,
    this.senderName,
    this.status,
    this.receiverPhotoUrl,
    this.senderPhotoUrl,
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
      'senderPhotoUrl': senderPhotoUrl,
      'receiverPhotoUrl': receiverPhotoUrl,
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
      senderPhotoUrl: map['senderPhotoUrl'],
      receiverPhotoUrl: map['receiverPhotoUrl'],
    );
  }
}

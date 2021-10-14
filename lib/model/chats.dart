import 'dart:convert';

class Chats {
  Chats chatsFromJson(String str) => Chats.fromJson(json.decode(str));
  String chatsToJson(Chats data) => json.encode(data.toJson());

  List<String>? connections;
  List<Chat>? chat;

  Chats({this.connections, this.chat});

  factory Chats.fromJson(Map<String, dynamic> json) => Chats(
        connections: List<String>.from(json["connections"].map((x) => x)),
        chat: List<Chat>.from(json["chat"].map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "connections": List<dynamic>.from(connections!.map((x) => x)),
        "chat": List<dynamic>.from(chat!.map((x) => x.toJson())),
      };
}

class Chat {
  Chat({
    this.sender,
    this.receiver,
    this.message,
    this.time,
    this.isRead,
  });

  String? sender;
  String? receiver;
  String? message;
  String? time;
  bool? isRead;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        sender: json["sender"],
        receiver: json["receiver"],
        message: json["message"],
        time: json["time"],
        isRead: json["isRead"],
      );

  Map<String, dynamic> toJson() => {
        "pengirim": sender,
        "penerima": receiver,
        "pesan": message,
        "time": time,
        "isRead": isRead,
      };
}

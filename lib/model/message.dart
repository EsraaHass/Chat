class Message {
  static const String routeName = 'message';

  String? id;

  String? messageContant;

  String? senderName;

  String? senderId;

  int? dateTime;

  Message(
      {this.id,
      this.messageContant,
      this.senderName,
      this.senderId,
      this.dateTime});

  Message.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          messageContant: data['messageContant'],
          senderId: data['senderId'],
          senderName: data['senderName'],
          dateTime: data['dateTime'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'messageContant': messageContant,
      'senderId': senderId,
      'senderName': senderName,
      'dateTime': dateTime,
    };
  }
}

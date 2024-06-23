class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage({
    required this.text,
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['text'],
      messageType: _parseMessageType(json['type']),
      messageStatus: _parseMessageStatus(json['status']),
      isSender: json['isSender'],
    );
  }

  static ChatMessageType _parseMessageType(String type) {
    switch (type) {
      case 'text':
        return ChatMessageType.text;
      case 'audio':
        return ChatMessageType.audio;
      case 'image':
        return ChatMessageType.image;
      case 'video':
        return ChatMessageType.video;
      default:
        throw Exception('Unknown message type: $type');
    }
  }

  static MessageStatus _parseMessageStatus(String status) {
    switch (status) {
      case 'notSent':
        return MessageStatus.notSent;
      case 'notViewed':
        return MessageStatus.notViewed;
      case 'viewed':
        return MessageStatus.viewed;
      default:
        throw Exception('Unknown message status: $status');
    }
  }
}

enum ChatMessageType { text, audio, image, video }
enum MessageStatus { notSent, notViewed, viewed }

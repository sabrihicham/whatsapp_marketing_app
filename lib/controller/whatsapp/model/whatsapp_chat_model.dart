class WhatsappChatModel {
  String? id;
  String? name;
  bool? isGroup;

  WhatsappChatModel({this.id, this.name, this.isGroup});

  WhatsappChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isGroup = json['isGroup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['isGroup'] = isGroup;
    return data;
  }
}

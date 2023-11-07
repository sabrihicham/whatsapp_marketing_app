class QrModel {
  String? value;
  bool? isOld;

  QrModel({this.value, this.isOld});

  QrModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    isOld = json['isOld'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['value'] = value;
    data['isOld'] = isOld;
    return data;
  }
}

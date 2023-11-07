class SendMessageParams {
  List<String>? to;
  String? message;
  String? mediaUrl;
  Location? location;

  SendMessageParams(
      {this.to, this.message, this.mediaUrl, this.location});

  SendMessageParams.fromJson(Map<String, dynamic> json) {
    to = json['to'].cast<String>();
    message = json['message'];
    mediaUrl = json['mediaUrl'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['to'] = to;
    data['message'] = message;
    data['mediaUrl'] = mediaUrl;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }

  SendMessageParams copyWith({
    List<String>? to,
    String? message,
    String? mediaUrl,
    Location? location,
  }) {
    return SendMessageParams(
      to: to ?? this.to,
      message: message ?? this.message,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      location: location ?? this.location,
    );
  }
}

class Location {
  double? lat;
  double? long;

  Location({this.lat, this.long});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}

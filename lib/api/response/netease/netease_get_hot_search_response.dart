class NeteaseGetHotSearchResponse {
  int code;
  Result result;

  NeteaseGetHotSearchResponse({this.code, this.result});

  NeteaseGetHotSearchResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  List<Hots> hots;

  Result({this.hots});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['hots'] != null) {
      hots = new List<Hots>();
      json['hots'].forEach((v) {
        hots.add(new Hots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hots != null) {
      data['hots'] = this.hots.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hots {
  String first;
  int second;
  int iconType;

  Hots({this.first, this.second, this.iconType});

  Hots.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    second = json['second'];
    iconType = json['iconType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['second'] = this.second;
    data['iconType'] = this.iconType;
    return data;
  }
}

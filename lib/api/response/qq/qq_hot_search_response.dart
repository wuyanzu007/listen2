class QQHotSearchResult {
  int code;
  Data data;
  int subcode;

  QQHotSearchResult({this.code, this.data, this.subcode});

  QQHotSearchResult.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    subcode = json['subcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['subcode'] = this.subcode;
    return data;
  }
}

class Data {
  List<Hotkey> hotkey;
  String specialKey;
  String specialUrl;

  Data({this.hotkey, this.specialKey, this.specialUrl});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['hotkey'] != null) {
      hotkey = new List<Hotkey>();
      json['hotkey'].forEach((v) {
        hotkey.add(new Hotkey.fromJson(v));
      });
    }
    specialKey = json['special_key'];
    specialUrl = json['special_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hotkey != null) {
      data['hotkey'] = this.hotkey.map((v) => v.toJson()).toList();
    }
    data['special_key'] = this.specialKey;
    data['special_url'] = this.specialUrl;
    return data;
  }
}

class Hotkey {
  String k;
  int n;

  Hotkey({this.k, this.n});

  Hotkey.fromJson(Map<String, dynamic> json) {
    k = json['k'];
    n = json['n'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['k'] = this.k;
    data['n'] = this.n;
    return data;
  }
}

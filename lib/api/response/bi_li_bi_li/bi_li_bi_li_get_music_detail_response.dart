class BiLiBiLiGetMusicDetailResponse {
  int code;
  String msg;
  Data data;

  BiLiBiLiGetMusicDetailResponse({this.code, this.msg, this.data});

  BiLiBiLiGetMusicDetailResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int sid;
  int type;
  String info;
  int timeout;
  int size;
  List<String> cdns;
  String qualities;
  String title;
  String cover;

  Data(
      {this.sid,
        this.type,
        this.info,
        this.timeout,
        this.size,
        this.cdns,
        this.qualities,
        this.title,
        this.cover});

  Data.fromJson(Map<String, dynamic> json) {
    sid = json['sid'];
    type = json['type'];
    info = json['info'];
    timeout = json['timeout'];
    size = json['size'];
    cdns = json['cdns'].cast<String>();
    qualities = json['qualities'];
    title = json['title'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sid'] = this.sid;
    data['type'] = this.type;
    data['info'] = this.info;
    data['timeout'] = this.timeout;
    data['size'] = this.size;
    data['cdns'] = this.cdns;
    data['qualities'] = this.qualities;
    data['title'] = this.title;
    data['cover'] = this.cover;
    return data;
  }
}

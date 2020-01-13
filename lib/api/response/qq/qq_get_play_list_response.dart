class QQGetPlayListResponse {
  int code;
  int subcode;
  String message;
  Data data;

  QQGetPlayListResponse({this.code, this.subcode, this.message, this.data});

  QQGetPlayListResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    subcode = json['subcode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['subcode'] = this.subcode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int uin;
  int categoryId;
  int sortId;
  int sum;
  int sin;
  int ein;
  List<MusicList> list;

  Data(
      {this.uin,
      this.categoryId,
      this.sortId,
      this.sum,
      this.sin,
      this.ein,
      this.list});

  Data.fromJson(Map<String, dynamic> json) {
    uin = json['uin'];
    categoryId = json['categoryId'];
    sortId = json['sortId'];
    sum = json['sum'];
    sin = json['sin'];
    ein = json['ein'];
    if (json['list'] != null) {
      list = new List<MusicList>();
      json['list'].forEach((v) {
        list.add(new MusicList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uin'] = this.uin;
    data['categoryId'] = this.categoryId;
    data['sortId'] = this.sortId;
    data['sum'] = this.sum;
    data['sin'] = this.sin;
    data['ein'] = this.ein;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MusicList {
  String dissid;
  String createtime;
  String commitTime;
  String dissname;
  String imgurl;
  String introduction;
  int listennum;
  double score;
  int version;
  Creator creator;

  MusicList(
      {this.dissid,
      this.createtime,
      this.commitTime,
      this.dissname,
      this.imgurl,
      this.introduction,
      this.listennum,
      this.score,
      this.version,
      this.creator});

  MusicList.fromJson(Map<String, dynamic> json) {
    dissid = json['dissid'];
    createtime = json['createtime'];
    commitTime = json['commit_time'];
    dissname = json['dissname'];
    imgurl = json['imgurl'];
    introduction = json['introduction'];
    listennum = json['listennum'];
    score = json['score'];
    version = json['version'];
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dissid'] = this.dissid;
    data['createtime'] = this.createtime;
    data['commit_time'] = this.commitTime;
    data['dissname'] = this.dissname;
    data['imgurl'] = this.imgurl;
    data['introduction'] = this.introduction;
    data['listennum'] = this.listennum;
    data['score'] = this.score;
    data['version'] = this.version;
    if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
    return data;
  }
}

class Creator {
  int type;
  int qq;
  String encryptUin;
  String name;
  int isVip;
  String avatarUrl;
  int followflag;

  Creator(
      {this.type,
      this.qq,
      this.encryptUin,
      this.name,
      this.isVip,
      this.avatarUrl,
      this.followflag});

  Creator.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    qq = json['qq'];
    encryptUin = json['encrypt_uin'];
    name = json['name'];
    isVip = json['isVip'];
    avatarUrl = json['avatarUrl'];
    followflag = json['followflag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['qq'] = this.qq;
    data['encrypt_uin'] = this.encryptUin;
    data['name'] = this.name;
    data['isVip'] = this.isVip;
    data['avatarUrl'] = this.avatarUrl;
    data['followflag'] = this.followflag;
    return data;
  }
}

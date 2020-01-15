class BiLiBiLiGetPlayListResponse {
  int code;
  String msg;
  Data data;

  BiLiBiLiGetPlayListResponse({this.code, this.msg, this.data});

  BiLiBiLiGetPlayListResponse.fromJson(Map<String, dynamic> json) {
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
  int curPage;
  int pageCount;
  int totalSize;
  int pageSize;
  List<PlayList> data;

  Data(
      {this.curPage, this.pageCount, this.totalSize, this.pageSize, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    pageCount = json['pageCount'];
    totalSize = json['totalSize'];
    pageSize = json['pageSize'];
    if (json['data'] != null) {
      data = new List<PlayList>();
      json['data'].forEach((v) {
        data.add(new PlayList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curPage'] = this.curPage;
    data['pageCount'] = this.pageCount;
    data['totalSize'] = this.totalSize;
    data['pageSize'] = this.pageSize;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlayList {
  int menuId;
  int uid;
  String uname;
  String title;
  String cover;
  String intro;
  int type;
  int off;
  int ctime;
  int curtime;
  Statistic statistic;
  int snum;
  int attr;
  int isDefault;
  int collectionId;

  PlayList(
      {this.menuId,
      this.uid,
      this.uname,
      this.title,
      this.cover,
      this.intro,
      this.type,
      this.off,
      this.ctime,
      this.curtime,
      this.statistic,
      this.snum,
      this.attr,
      this.isDefault,
      this.collectionId});

  PlayList.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    uid = json['uid'];
    uname = json['uname'];
    title = json['title'];
    cover = json['cover'];
    intro = json['intro'];
    type = json['type'];
    off = json['off'];
    ctime = json['ctime'];
    curtime = json['curtime'];
    statistic = json['statistic'] != null
        ? new Statistic.fromJson(json['statistic'])
        : null;
    snum = json['snum'];
    attr = json['attr'];
    isDefault = json['isDefault'];
    collectionId = json['collectionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuId'] = this.menuId;
    data['uid'] = this.uid;
    data['uname'] = this.uname;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['intro'] = this.intro;
    data['type'] = this.type;
    data['off'] = this.off;
    data['ctime'] = this.ctime;
    data['curtime'] = this.curtime;
    if (this.statistic != null) {
      data['statistic'] = this.statistic.toJson();
    }
    data['snum'] = this.snum;
    data['attr'] = this.attr;
    data['isDefault'] = this.isDefault;
    data['collectionId'] = this.collectionId;
    return data;
  }
}

class Statistic {
  int sid;
  int play;
  int collect;
  int comment;
  int share;

  Statistic({this.sid, this.play, this.collect, this.comment, this.share});

  Statistic.fromJson(Map<String, dynamic> json) {
    sid = json['sid'];
    play = json['play'];
    collect = json['collect'];
    comment = json['comment'];
    share = json['share'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sid'] = this.sid;
    data['play'] = this.play;
    data['collect'] = this.collect;
    data['comment'] = this.comment;
    data['share'] = this.share;
    return data;
  }
}

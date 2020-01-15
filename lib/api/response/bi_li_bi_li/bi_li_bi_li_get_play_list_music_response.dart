class BiLiBiLiGetPlayListMusicResponse {
  int code;
  String msg;
  Data data;

  BiLiBiLiGetPlayListMusicResponse({this.code, this.msg, this.data});

  BiLiBiLiGetPlayListMusicResponse.fromJson(Map<String, dynamic> json) {
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
  List<Song> data;

  Data(
      {this.curPage, this.pageCount, this.totalSize, this.pageSize, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    pageCount = json['pageCount'];
    totalSize = json['totalSize'];
    pageSize = json['pageSize'];
    if (json['data'] != null) {
      data = new List<Song>();
      json['data'].forEach((v) {
        data.add(new Song.fromJson(v));
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

class Song {
  int id;
  int uid;
  String uname;
  String author;
  String title;
  String cover;
  String intro;
  String lyric;
  int crtype;
  int duration;
  int passtime;
  int curtime;
  int aid;
  String bvid;
  int cid;
  int msid;
  int attr;
  int limit;
  Null activityId;
  String limitdesc;
  int ctime;
  Statistic statistic;
  Null vipInfo;
  int coinNum;

  Song(
      {this.id,
        this.uid,
        this.uname,
        this.author,
        this.title,
        this.cover,
        this.intro,
        this.lyric,
        this.crtype,
        this.duration,
        this.passtime,
        this.curtime,
        this.aid,
        this.bvid,
        this.cid,
        this.msid,
        this.attr,
        this.limit,
        this.activityId,
        this.limitdesc,
        this.ctime,
        this.statistic,
        this.vipInfo,
        this.coinNum});

  Song.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    uname = json['uname'];
    author = json['author'];
    title = json['title'];
    cover = json['cover'];
    intro = json['intro'];
    lyric = json['lyric'];
    crtype = json['crtype'];
    duration = json['duration'];
    passtime = json['passtime'];
    curtime = json['curtime'];
    aid = json['aid'];
    bvid = json['bvid'];
    cid = json['cid'];
    msid = json['msid'];
    attr = json['attr'];
    limit = json['limit'];
    activityId = json['activityId'];
    limitdesc = json['limitdesc'];
    ctime = json['ctime'];
    statistic = json['statistic'] != null
        ? new Statistic.fromJson(json['statistic'])
        : null;
    vipInfo = json['vipInfo'];
    coinNum = json['coin_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['uname'] = this.uname;
    data['author'] = this.author;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['intro'] = this.intro;
    data['lyric'] = this.lyric;
    data['crtype'] = this.crtype;
    data['duration'] = this.duration;
    data['passtime'] = this.passtime;
    data['curtime'] = this.curtime;
    data['aid'] = this.aid;
    data['bvid'] = this.bvid;
    data['cid'] = this.cid;
    data['msid'] = this.msid;
    data['attr'] = this.attr;
    data['limit'] = this.limit;
    data['activityId'] = this.activityId;
    data['limitdesc'] = this.limitdesc;
    data['ctime'] = this.ctime;
    if (this.statistic != null) {
      data['statistic'] = this.statistic.toJson();
    }
    data['vipInfo'] = this.vipInfo;
    data['coin_num'] = this.coinNum;
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

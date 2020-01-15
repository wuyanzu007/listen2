class QQSearchResponse {
  int code;
  Data data;
  String message;
  String notice;
  int subcode;
  int time;
  String tips;

  QQSearchResponse(
      {this.code,
      this.data,
      this.message,
      this.notice,
      this.subcode,
      this.time,
      this.tips});

  QQSearchResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    notice = json['notice'];
    subcode = json['subcode'];
    time = json['time'];
    tips = json['tips'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['notice'] = this.notice;
    data['subcode'] = this.subcode;
    data['time'] = this.time;
    data['tips'] = this.tips;
    return data;
  }
}

class Data {
  String keyword;
  int priority;
  Semantic semantic;
  Song song;
  int totaltime;
  Zhida zhida;

  Data(
      {this.keyword,
      this.priority,
      this.semantic,
      this.song,
      this.totaltime,
      this.zhida});

  Data.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
    priority = json['priority'];
    semantic = json['semantic'] != null
        ? new Semantic.fromJson(json['semantic'])
        : null;
    song = json['song'] != null ? new Song.fromJson(json['song']) : null;
    totaltime = json['totaltime'];
    zhida = json['zhida'] != null ? new Zhida.fromJson(json['zhida']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keyword'] = this.keyword;
    data['priority'] = this.priority;
    if (this.semantic != null) {
      data['semantic'] = this.semantic.toJson();
    }
    if (this.song != null) {
      data['song'] = this.song.toJson();
    }
    data['totaltime'] = this.totaltime;
    if (this.zhida != null) {
      data['zhida'] = this.zhida.toJson();
    }
    return data;
  }
}

class Semantic {
  int curnum;
  int curpage;
  int totalnum;

  Semantic({this.curnum, this.curpage, this.totalnum});

  Semantic.fromJson(Map<String, dynamic> json) {
    curnum = json['curnum'];
    curpage = json['curpage'];
    totalnum = json['totalnum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curnum'] = this.curnum;
    data['curpage'] = this.curpage;
    data['totalnum'] = this.totalnum;
    return data;
  }
}

class Song {
  int curnum;
  int curpage;
  List<SongList> list;
  int totalnum;

  Song({this.curnum, this.curpage, this.list, this.totalnum});

  Song.fromJson(Map<String, dynamic> json) {
    curnum = json['curnum'];
    curpage = json['curpage'];
    if (json['list'] != null) {
      list = new List<SongList>();
      json['list'].forEach((v) {
        list.add(new SongList.fromJson(v));
      });
    }
    totalnum = json['totalnum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curnum'] = this.curnum;
    data['curpage'] = this.curpage;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['totalnum'] = this.totalnum;
    return data;
  }
}

class SongList {
  int albumid;
  String albummid;
  String albumname;
  String albumnameHilight;
  int alertid;
  int chinesesinger;
  String docid;
  int interval;
  int isonly;
  String lyric;
  String lyricHilight;
  int msgid;
  int nt;
  Pay pay;
  Preview preview;
  int pubtime;
  int pure;
  List<Singer> singer;
  int size128;
  int size320;
  int sizeape;
  int sizeflac;
  int sizeogg;
  int songid;
  String songmid;
  String songname;
  String songnameHilight;
  int stream;
  int t;
  int tag;
  int type;
  int ver;
  String vid;
  String format;
  String songurl;

  SongList(
      {this.albumid,
      this.albummid,
      this.albumname,
      this.albumnameHilight,
      this.alertid,
      this.chinesesinger,
      this.docid,
      this.interval,
      this.isonly,
      this.lyric,
      this.lyricHilight,
      this.msgid,
      this.nt,
      this.pay,
      this.preview,
      this.pubtime,
      this.pure,
      this.singer,
      this.size128,
      this.size320,
      this.sizeape,
      this.sizeflac,
      this.sizeogg,
      this.songid,
      this.songmid,
      this.songname,
      this.songnameHilight,
      this.stream,
      this.t,
      this.tag,
      this.type,
      this.ver,
      this.vid,
      this.format,
      this.songurl});

  SongList.fromJson(Map<String, dynamic> json) {
    albumid = json['albumid'];
    albummid = json['albummid'];
    albumname = json['albumname'];
    albumnameHilight = json['albumname_hilight'];
    alertid = json['alertid'];
    chinesesinger = json['chinesesinger'];
    docid = json['docid'];
    interval = json['interval'];
    isonly = json['isonly'];
    lyric = json['lyric'];
    lyricHilight = json['lyric_hilight'];
    msgid = json['msgid'];
    nt = json['nt'];
    pay = json['pay'] != null ? new Pay.fromJson(json['pay']) : null;
    preview =
        json['preview'] != null ? new Preview.fromJson(json['preview']) : null;
    pubtime = json['pubtime'];
    pure = json['pure'];
    if (json['singer'] != null) {
      singer = new List<Singer>();
      json['singer'].forEach((v) {
        singer.add(new Singer.fromJson(v));
      });
    }
    size128 = json['size128'];
    size320 = json['size320'];
    sizeape = json['sizeape'];
    sizeflac = json['sizeflac'];
    sizeogg = json['sizeogg'];
    songid = json['songid'];
    songmid = json['songmid'];
    songname = json['songname'];
    songnameHilight = json['songname_hilight'];
    stream = json['stream'];
    t = json['t'];
    tag = json['tag'];
    type = json['type'];
    ver = json['ver'];
    vid = json['vid'];
    format = json['format'];
    songurl = json['songurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumid'] = this.albumid;
    data['albummid'] = this.albummid;
    data['albumname'] = this.albumname;
    data['albumname_hilight'] = this.albumnameHilight;
    data['alertid'] = this.alertid;
    data['chinesesinger'] = this.chinesesinger;
    data['docid'] = this.docid;
    data['interval'] = this.interval;
    data['isonly'] = this.isonly;
    data['lyric'] = this.lyric;
    data['lyric_hilight'] = this.lyricHilight;
    data['msgid'] = this.msgid;
    data['nt'] = this.nt;
    if (this.pay != null) {
      data['pay'] = this.pay.toJson();
    }
    if (this.preview != null) {
      data['preview'] = this.preview.toJson();
    }
    data['pubtime'] = this.pubtime;
    data['pure'] = this.pure;
    if (this.singer != null) {
      data['singer'] = this.singer.map((v) => v.toJson()).toList();
    }
    data['size128'] = this.size128;
    data['size320'] = this.size320;
    data['sizeape'] = this.sizeape;
    data['sizeflac'] = this.sizeflac;
    data['sizeogg'] = this.sizeogg;
    data['songid'] = this.songid;
    data['songmid'] = this.songmid;
    data['songname'] = this.songname;
    data['songname_hilight'] = this.songnameHilight;
    data['stream'] = this.stream;
    data['t'] = this.t;
    data['tag'] = this.tag;
    data['type'] = this.type;
    data['ver'] = this.ver;
    data['vid'] = this.vid;
    data['format'] = this.format;
    data['songurl'] = this.songurl;
    return data;
  }
}

class Pay {
  int payalbum;
  int payalbumprice;
  int paydownload;
  int payinfo;
  int payplay;
  int paytrackmouth;
  int paytrackprice;

  Pay(
      {this.payalbum,
      this.payalbumprice,
      this.paydownload,
      this.payinfo,
      this.payplay,
      this.paytrackmouth,
      this.paytrackprice});

  Pay.fromJson(Map<String, dynamic> json) {
    payalbum = json['payalbum'];
    payalbumprice = json['payalbumprice'];
    paydownload = json['paydownload'];
    payinfo = json['payinfo'];
    payplay = json['payplay'];
    paytrackmouth = json['paytrackmouth'];
    paytrackprice = json['paytrackprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payalbum'] = this.payalbum;
    data['payalbumprice'] = this.payalbumprice;
    data['paydownload'] = this.paydownload;
    data['payinfo'] = this.payinfo;
    data['payplay'] = this.payplay;
    data['paytrackmouth'] = this.paytrackmouth;
    data['paytrackprice'] = this.paytrackprice;
    return data;
  }
}

class Preview {
  int trybegin;
  int tryend;
  int trysize;

  Preview({this.trybegin, this.tryend, this.trysize});

  Preview.fromJson(Map<String, dynamic> json) {
    trybegin = json['trybegin'];
    tryend = json['tryend'];
    trysize = json['trysize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trybegin'] = this.trybegin;
    data['tryend'] = this.tryend;
    data['trysize'] = this.trysize;
    return data;
  }
}

class Singer {
  int id;
  String mid;
  String name;
  String nameHilight;

  Singer({this.id, this.mid, this.name, this.nameHilight});

  Singer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mid = json['mid'];
    name = json['name'];
    nameHilight = json['name_hilight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mid'] = this.mid;
    data['name'] = this.name;
    data['name_hilight'] = this.nameHilight;
    return data;
  }
}

class Zhida {
  int albumnum;
  int singerid;
  String singermid;
  String singername;
  int songnum;
  int type;

  Zhida(
      {this.albumnum,
      this.singerid,
      this.singermid,
      this.singername,
      this.songnum,
      this.type});

  Zhida.fromJson(Map<String, dynamic> json) {
    albumnum = json['albumnum'];
    singerid = json['singerid'];
    singermid = json['singermid'];
    singername = json['singername'];
    songnum = json['songnum'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumnum'] = this.albumnum;
    data['singerid'] = this.singerid;
    data['singermid'] = this.singermid;
    data['singername'] = this.singername;
    data['songnum'] = this.songnum;
    data['type'] = this.type;
    return data;
  }
}

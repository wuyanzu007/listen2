class QQGetPlayListMusicResponse {
  int code;
  int subcode;
  int accessedPlazaCache;
  int accessedFavbase;
  String login;
  int cdnum;
  List<Cdlist> cdlist;
  int realcdnum;

  QQGetPlayListMusicResponse(
      {this.code,
      this.subcode,
      this.accessedPlazaCache,
      this.accessedFavbase,
      this.login,
      this.cdnum,
      this.cdlist,
      this.realcdnum});

  QQGetPlayListMusicResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    subcode = json['subcode'];
    accessedPlazaCache = json['accessed_plaza_cache'];
    accessedFavbase = json['accessed_favbase'];
    login = json['login'];
    cdnum = json['cdnum'];
    if (json['cdlist'] != null) {
      cdlist = new List<Cdlist>();
      json['cdlist'].forEach((v) {
        cdlist.add(new Cdlist.fromJson(v));
      });
    }
    realcdnum = json['realcdnum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['subcode'] = this.subcode;
    data['accessed_plaza_cache'] = this.accessedPlazaCache;
    data['accessed_favbase'] = this.accessedFavbase;
    data['login'] = this.login;
    data['cdnum'] = this.cdnum;
    if (this.cdlist != null) {
      data['cdlist'] = this.cdlist.map((v) => v.toJson()).toList();
    }
    data['realcdnum'] = this.realcdnum;
    return data;
  }
}

class Cdlist {
  String disstid;
  int dirShow;
  int owndir;
  int dirid;
  String coveradurl;
  int dissid;
  String login;
  String uin;
  String encryptUin;
  String dissname;
  String logo;
  String picMid;
  String albumPicMid;
  int picDpi;
  int isAd;
  String desc;
  int ctime;
  int mtime;
  String headurl;
  String ifpicurl;
  String nick;
  String nickname;
  int type;
  int singerid;
  String singermid;
  int isvip;
  int isdj;
  int songnum;
  int disstype;
  String dirPicUrl2;
  int songUpdateTime;
  int songUpdateNum;
  int totalSongNum;
  int songBegin;
  int curSongNum;
  List<Songlist> songlist;
  int visitnum;
  int cmtnum;
  int buynum;
  String scoreavage;
  int scoreusercount;

  Cdlist(
      {this.disstid,
      this.dirShow,
      this.owndir,
      this.dirid,
      this.coveradurl,
      this.dissid,
      this.login,
      this.uin,
      this.encryptUin,
      this.dissname,
      this.logo,
      this.picMid,
      this.albumPicMid,
      this.picDpi,
      this.isAd,
      this.desc,
      this.ctime,
      this.mtime,
      this.headurl,
      this.ifpicurl,
      this.nick,
      this.nickname,
      this.type,
      this.singerid,
      this.singermid,
      this.isvip,
      this.isdj,
      this.songnum,
      this.disstype,
      this.dirPicUrl2,
      this.songUpdateTime,
      this.songUpdateNum,
      this.totalSongNum,
      this.songBegin,
      this.curSongNum,
      this.songlist,
      this.visitnum,
      this.cmtnum,
      this.buynum,
      this.scoreavage,
      this.scoreusercount});

  Cdlist.fromJson(Map<String, dynamic> json) {
    disstid = json['disstid'];
    dirShow = json['dir_show'];
    owndir = json['owndir'];
    dirid = json['dirid'];
    coveradurl = json['coveradurl'];
    dissid = json['dissid'];
    login = json['login'];
    uin = json['uin'];
    encryptUin = json['encrypt_uin'];
    dissname = json['dissname'];
    logo = json['logo'];
    picMid = json['pic_mid'];
    albumPicMid = json['album_pic_mid'];
    picDpi = json['pic_dpi'];
    isAd = json['isAd'];
    desc = json['desc'];
    ctime = json['ctime'];
    mtime = json['mtime'];
    headurl = json['headurl'];
    ifpicurl = json['ifpicurl'];
    nick = json['nick'];
    nickname = json['nickname'];
    type = json['type'];
    singerid = json['singerid'];
    singermid = json['singermid'];
    isvip = json['isvip'];
    isdj = json['isdj'];
    songnum = json['songnum'];
    disstype = json['disstype'];
    dirPicUrl2 = json['dir_pic_url2'];
    songUpdateTime = json['song_update_time'];
    songUpdateNum = json['song_update_num'];
    totalSongNum = json['total_song_num'];
    songBegin = json['song_begin'];
    curSongNum = json['cur_song_num'];
    if (json['songlist'] != null) {
      songlist = new List<Songlist>();
      json['songlist'].forEach((v) {
        songlist.add(new Songlist.fromJson(v));
      });
    }
    visitnum = json['visitnum'];
    cmtnum = json['cmtnum'];
    buynum = json['buynum'];
    scoreavage = json['scoreavage'];
    scoreusercount = json['scoreusercount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disstid'] = this.disstid;
    data['dir_show'] = this.dirShow;
    data['owndir'] = this.owndir;
    data['dirid'] = this.dirid;
    data['coveradurl'] = this.coveradurl;
    data['dissid'] = this.dissid;
    data['login'] = this.login;
    data['uin'] = this.uin;
    data['encrypt_uin'] = this.encryptUin;
    data['dissname'] = this.dissname;
    data['logo'] = this.logo;
    data['pic_mid'] = this.picMid;
    data['album_pic_mid'] = this.albumPicMid;
    data['pic_dpi'] = this.picDpi;
    data['isAd'] = this.isAd;
    data['desc'] = this.desc;
    data['ctime'] = this.ctime;
    data['mtime'] = this.mtime;
    data['headurl'] = this.headurl;
    data['ifpicurl'] = this.ifpicurl;
    data['nick'] = this.nick;
    data['nickname'] = this.nickname;
    data['type'] = this.type;
    data['singerid'] = this.singerid;
    data['singermid'] = this.singermid;
    data['isvip'] = this.isvip;
    data['isdj'] = this.isdj;
    data['songnum'] = this.songnum;
    data['disstype'] = this.disstype;
    data['dir_pic_url2'] = this.dirPicUrl2;
    data['song_update_time'] = this.songUpdateTime;
    data['song_update_num'] = this.songUpdateNum;
    data['total_song_num'] = this.totalSongNum;
    data['song_begin'] = this.songBegin;
    data['cur_song_num'] = this.curSongNum;
    if (this.songlist != null) {
      data['songlist'] = this.songlist.map((v) => v.toJson()).toList();
    }
    data['visitnum'] = this.visitnum;
    data['cmtnum'] = this.cmtnum;
    data['buynum'] = this.buynum;
    data['scoreavage'] = this.scoreavage;
    data['scoreusercount'] = this.scoreusercount;
    return data;
  }
}

class Songlist {
  String albumdesc;
  int albumid;
  String albummid;
  String albumname;
  int alertid;
  int belongCD;
  int cdIdx;
  int interval;
  int isonly;
  String label;
  int msgid;
  Pay pay;
  Preview preview;
  int rate;
  List<Singer> singer;
  int size128;
  int size320;
  int size51;
  int sizeape;
  int sizeflac;
  int sizeogg;
  int songid;
  String songmid;
  String songname;
  String songorig;
  int songtype;
  String strMediaMid;
  int stream;
  int type;
  String vid;

  Songlist(
      {this.albumdesc,
      this.albumid,
      this.albummid,
      this.albumname,
      this.alertid,
      this.belongCD,
      this.cdIdx,
      this.interval,
      this.isonly,
      this.label,
      this.msgid,
      this.pay,
      this.preview,
      this.rate,
      this.singer,
      this.size128,
      this.size320,
      this.size51,
      this.sizeape,
      this.sizeflac,
      this.sizeogg,
      this.songid,
      this.songmid,
      this.songname,
      this.songorig,
      this.songtype,
      this.strMediaMid,
      this.stream,
      this.type,
      this.vid});

  Songlist.fromJson(Map<String, dynamic> json) {
    albumdesc = json['albumdesc'];
    albumid = json['albumid'];
    albummid = json['albummid'];
    albumname = json['albumname'];
    alertid = json['alertid'];
    belongCD = json['belongCD'];
    cdIdx = json['cdIdx'];
    interval = json['interval'];
    isonly = json['isonly'];
    label = json['label'];
    msgid = json['msgid'];
    pay = json['pay'] != null ? new Pay.fromJson(json['pay']) : null;
    preview =
        json['preview'] != null ? new Preview.fromJson(json['preview']) : null;
    rate = json['rate'];
    if (json['singer'] != null) {
      singer = new List<Singer>();
      json['singer'].forEach((v) {
        singer.add(new Singer.fromJson(v));
      });
    }
    size128 = json['size128'];
    size320 = json['size320'];
    size51 = json['size5_1'];
    sizeape = json['sizeape'];
    sizeflac = json['sizeflac'];
    sizeogg = json['sizeogg'];
    songid = json['songid'];
    songmid = json['songmid'];
    songname = json['songname'];
    songorig = json['songorig'];
    songtype = json['songtype'];
    strMediaMid = json['strMediaMid'];
    stream = json['stream'];
    type = json['type'];
    vid = json['vid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumdesc'] = this.albumdesc;
    data['albumid'] = this.albumid;
    data['albummid'] = this.albummid;
    data['albumname'] = this.albumname;
    data['alertid'] = this.alertid;
    data['belongCD'] = this.belongCD;
    data['cdIdx'] = this.cdIdx;
    data['interval'] = this.interval;
    data['isonly'] = this.isonly;
    data['label'] = this.label;
    data['msgid'] = this.msgid;
    if (this.pay != null) {
      data['pay'] = this.pay.toJson();
    }
    if (this.preview != null) {
      data['preview'] = this.preview.toJson();
    }
    data['rate'] = this.rate;
    if (this.singer != null) {
      data['singer'] = this.singer.map((v) => v.toJson()).toList();
    }
    data['size128'] = this.size128;
    data['size320'] = this.size320;
    data['size5_1'] = this.size51;
    data['sizeape'] = this.sizeape;
    data['sizeflac'] = this.sizeflac;
    data['sizeogg'] = this.sizeogg;
    data['songid'] = this.songid;
    data['songmid'] = this.songmid;
    data['songname'] = this.songname;
    data['songorig'] = this.songorig;
    data['songtype'] = this.songtype;
    data['strMediaMid'] = this.strMediaMid;
    data['stream'] = this.stream;
    data['type'] = this.type;
    data['vid'] = this.vid;
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
  int timefree;

  Pay(
      {this.payalbum,
      this.payalbumprice,
      this.paydownload,
      this.payinfo,
      this.payplay,
      this.paytrackmouth,
      this.paytrackprice,
      this.timefree});

  Pay.fromJson(Map<String, dynamic> json) {
    payalbum = json['payalbum'];
    payalbumprice = json['payalbumprice'];
    paydownload = json['paydownload'];
    payinfo = json['payinfo'];
    payplay = json['payplay'];
    paytrackmouth = json['paytrackmouth'];
    paytrackprice = json['paytrackprice'];
    timefree = json['timefree'];
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
    data['timefree'] = this.timefree;
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

  Singer({this.id, this.mid, this.name});

  Singer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mid = json['mid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mid'] = this.mid;
    data['name'] = this.name;
    return data;
  }
}

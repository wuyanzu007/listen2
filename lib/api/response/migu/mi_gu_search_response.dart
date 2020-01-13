class MiGuSearchResponse {
  List<Musics> musics;
  int pgt;
  String keyword;
  String pageNo;
  bool success;

  MiGuSearchResponse(
      {this.musics, this.pgt, this.keyword, this.pageNo, this.success});

  MiGuSearchResponse.fromJson(Map<String, dynamic> json) {
    if (json['musics'] != null) {
      musics = new List<Musics>();
      json['musics'].forEach((v) {
        musics.add(new Musics.fromJson(v));
      });
    }
    pgt = json['pgt'];
    keyword = json['keyword'];
    pageNo = json['pageNo'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.musics != null) {
      data['musics'] = this.musics.map((v) => v.toJson()).toList();
    }
    data['pgt'] = this.pgt;
    data['keyword'] = this.keyword;
    data['pageNo'] = this.pageNo;
    data['success'] = this.success;
    return data;
  }
}

class Musics {
  String albumName;
  String albumId;
  String copyrightId;
  String mp3;
  String unuseFlag;
  String songName;
  String mvId;
  String lyrics;
  String mvCopyrightId;
  String id;
  String singerId;
  String title;
  String cover;
  String hasMv;
  String singerName;
  String isHdCrbt;
  String hasSQqq;
  String artist;
  String hasHQqq;

  Musics(
      {this.albumName,
      this.albumId,
      this.copyrightId,
      this.mp3,
      this.unuseFlag,
      this.songName,
      this.mvId,
      this.lyrics,
      this.mvCopyrightId,
      this.id,
      this.singerId,
      this.title,
      this.cover,
      this.hasMv,
      this.singerName,
      this.isHdCrbt,
      this.hasSQqq,
      this.artist,
      this.hasHQqq});

  Musics.fromJson(Map<String, dynamic> json) {
    albumName = json['albumName'];
    albumId = json['albumId'];
    copyrightId = json['copyrightId'];
    mp3 = json['mp3'];
    unuseFlag = json['unuseFlag'];
    songName = json['songName'];
    mvId = json['mvId'];
    lyrics = json['lyrics'];
    mvCopyrightId = json['mvCopyrightId'];
    id = json['id'];
    singerId = json['singerId'];
    title = json['title'];
    cover = json['cover'];
    hasMv = json['hasMv'];
    singerName = json['singerName'];
    isHdCrbt = json['isHdCrbt'];
    hasSQqq = json['hasSQqq'];
    artist = json['artist'];
    hasHQqq = json['hasHQqq'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumName'] = this.albumName;
    data['albumId'] = this.albumId;
    data['copyrightId'] = this.copyrightId;
    data['mp3'] = this.mp3;
    data['unuseFlag'] = this.unuseFlag;
    data['songName'] = this.songName;
    data['mvId'] = this.mvId;
    data['lyrics'] = this.lyrics;
    data['mvCopyrightId'] = this.mvCopyrightId;
    data['id'] = this.id;
    data['singerId'] = this.singerId;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['hasMv'] = this.hasMv;
    data['singerName'] = this.singerName;
    data['isHdCrbt'] = this.isHdCrbt;
    data['hasSQqq'] = this.hasSQqq;
    data['artist'] = this.artist;
    data['hasHQqq'] = this.hasHQqq;
    return data;
  }
}

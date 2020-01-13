class NeteaseGetMusicListDetailResponse {
  int code;
  Null relatedVideos;
  Playlist playlist;
  Null urls;

  NeteaseGetMusicListDetailResponse({this.code, this.relatedVideos, this.playlist, this.urls});

  NeteaseGetMusicListDetailResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    relatedVideos = json['relatedVideos'];
    playlist = json['playlist'] != null
        ? new Playlist.fromJson(json['playlist'])
        : null;
    urls = json['urls'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['relatedVideos'] = this.relatedVideos;
    if (this.playlist != null) {
      data['playlist'] = this.playlist.toJson();
    }
    data['urls'] = this.urls;
    return data;
  }
}

class Playlist {
  bool subscribed;
  List<Tracks> tracks;
  String coverImgUrl;
  int playCount;
  bool ordered;
  List<String> tags;
  String description;
  int status;
  String name;
  int id;
  int shareCount;
  String coverImgIdStr;
  int commentCount;

  Playlist(
      {this.subscribed,
        this.tracks,
        this.coverImgUrl,
        this.playCount,
        this.ordered,
        this.tags,
        this.description,
        this.status,
        this.name,
        this.id,
        this.shareCount,
        this.coverImgIdStr,
        this.commentCount});

  Playlist.fromJson(Map<String, dynamic> json) {
    subscribed = json['subscribed'];
    if (json['tracks'] != null) {
      tracks = new List<Tracks>();
      json['tracks'].forEach((v) {
        tracks.add(new Tracks.fromJson(v));
      });
    }
    coverImgUrl = json['coverImgUrl'];
    playCount = json['playCount'];
    ordered = json['ordered'];
    tags = json['tags'].cast<String>();
    description = json['description'];
    status = json['status'];
    name = json['name'];
    id = json['id'];
    shareCount = json['shareCount'];
    coverImgIdStr = json['coverImgId_str'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscribed'] = this.subscribed;
    if (this.tracks != null) {
      data['tracks'] = this.tracks.map((v) => v.toJson()).toList();
    }
    data['coverImgUrl'] = this.coverImgUrl;
    data['playCount'] = this.playCount;
    data['ordered'] = this.ordered;
    data['tags'] = this.tags;
    data['description'] = this.description;
    data['status'] = this.status;
    data['name'] = this.name;
    data['id'] = this.id;
    data['shareCount'] = this.shareCount;
    data['coverImgId_str'] = this.coverImgIdStr;
    data['commentCount'] = this.commentCount;
    return data;
  }
}

class Tracks {
  String name;
  int id;
  int pst;
  int t;
  List<Ar> ar;
  Al al;

  Tracks({this.name, this.id, this.pst, this.t, this.ar, this.al});

  Tracks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    pst = json['pst'];
    t = json['t'];
    if (json['ar'] != null) {
      ar = new List<Ar>();
      json['ar'].forEach((v) {
        ar.add(new Ar.fromJson(v));
      });
    }
    al = json['al'] != null ? new Al.fromJson(json['al']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['pst'] = this.pst;
    data['t'] = this.t;
    if (this.ar != null) {
      data['ar'] = this.ar.map((v) => v.toJson()).toList();
    }
    if (this.al != null) {
      data['al'] = this.al.toJson();
    }
    return data;
  }
}

class Ar {
  int id;
  String name;

  Ar({this.id, this.name});

  Ar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Al {
  int id;
  String name;
  String picUrl;
  String picStr;
  int pic;

  Al({this.id, this.name, this.picUrl, this.picStr, this.pic});

  Al.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picUrl = json['picUrl'];
    picStr = json['pic_str'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['picUrl'] = this.picUrl;
    data['pic_str'] = this.picStr;
    data['pic'] = this.pic;
    return data;
  }
}

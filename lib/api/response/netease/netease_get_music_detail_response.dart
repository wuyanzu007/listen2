class NeteaseGetMusicDetailResponse {
  List<Songs> songs;
  int code;

  NeteaseGetMusicDetailResponse({this.songs, this.code});

  NeteaseGetMusicDetailResponse.fromJson(Map<String, dynamic> json) {
    if (json['songs'] != null) {
      songs = new List<Songs>();
      json['songs'].forEach((v) {
        songs.add(new Songs.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.songs != null) {
      data['songs'] = this.songs.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Songs {
  String name;
  int id;
  List<Ar> ar;
  Al al;

  Songs({this.name, this.id, this.ar, this.al});

  Songs.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
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

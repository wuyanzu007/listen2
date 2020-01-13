class MiGuGetPicUrlResponse {
  String returnCode;
  String msg;
  String smallPic;
  String mediumPic;
  String largePic;

  MiGuGetPicUrlResponse(
      {this.returnCode,
        this.msg,
        this.smallPic,
        this.mediumPic,
        this.largePic});

  MiGuGetPicUrlResponse.fromJson(Map<String, dynamic> json) {
    returnCode = json['returnCode'];
    msg = json['msg'];
    smallPic = json['smallPic'];
    mediumPic = json['mediumPic'];
    largePic = json['largePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['returnCode'] = this.returnCode;
    data['msg'] = this.msg;
    data['smallPic'] = this.smallPic;
    data['mediumPic'] = this.mediumPic;
    data['largePic'] = this.largePic;
    return data;
  }
}

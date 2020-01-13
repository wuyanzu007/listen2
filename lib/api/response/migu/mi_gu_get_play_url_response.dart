class MiGuGetPlayUrlResponse {
  String returnCode;
  String msg;
  Data data;

  MiGuGetPlayUrlResponse({this.returnCode, this.msg, this.data});

  MiGuGetPlayUrlResponse.fromJson(Map<String, dynamic> json) {
    returnCode = json['returnCode'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['returnCode'] = this.returnCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  BqPlayInfo bqPlayInfo;
  BqPlayInfo hqPlayInfo;
  BqPlayInfo sqPlayInfo;

  Data({this.bqPlayInfo, this.hqPlayInfo, this.sqPlayInfo});

  Data.fromJson(Map<String, dynamic> json) {
    bqPlayInfo = json['bqPlayInfo'] != null
        ? new BqPlayInfo.fromJson(json['bqPlayInfo'])
        : null;
    hqPlayInfo = json['hqPlayInfo'] != null
        ? new BqPlayInfo.fromJson(json['hqPlayInfo'])
        : null;
    sqPlayInfo = json['sqPlayInfo'] != null
        ? new BqPlayInfo.fromJson(json['sqPlayInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bqPlayInfo != null) {
      data['bqPlayInfo'] = this.bqPlayInfo.toJson();
    }
    if (this.hqPlayInfo != null) {
      data['hqPlayInfo'] = this.hqPlayInfo.toJson();
    }
    if (this.sqPlayInfo != null) {
      data['sqPlayInfo'] = this.sqPlayInfo.toJson();
    }
    return data;
  }
}

class BqPlayInfo {
  String playUrl;
  String formatId;
  String salePrice;
  String bizType;
  String bizCode;

  BqPlayInfo(
      {this.playUrl,
        this.formatId,
        this.salePrice,
        this.bizType,
        this.bizCode});

  BqPlayInfo.fromJson(Map<String, dynamic> json) {
    playUrl = json['playUrl'];
    formatId = json['formatId'];
    salePrice = json['salePrice'];
    bizType = json['bizType'];
    bizCode = json['bizCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playUrl'] = this.playUrl;
    data['formatId'] = this.formatId;
    data['salePrice'] = this.salePrice;
    data['bizType'] = this.bizType;
    data['bizCode'] = this.bizCode;
    return data;
  }
}

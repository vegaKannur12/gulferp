class RegistrationData {
  String? cid;
  String? type;
  String? apptype;

  String? fp;
  String? os;
  List<CD>? c_d;
  String? msg;
  String? sof;
  RegistrationData({this.cid,this.type,this.apptype, this.fp, this.os, this.c_d, this.msg,this.sof});

  RegistrationData.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    type = json['type'];
    apptype = json['apptype'];


    fp = json['fp'];
    os = json['os'];
    if (json['c_d'] != null) {
      c_d = <CD>[];
      json['c_d'].forEach((v) {
        c_d!.add(new CD.fromJson(v));
      });
    }
    msg = json['msg'];
    sof = json['sof'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['type'] = this.type;
    data['apptype'] = this.apptype;


    data['fp'] = this.fp;
    data['os'] = this.os;
    if (this.c_d != null) {
      data['c_d'] = this.c_d!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['sof'] = this.sof;
    return data;
  }
}

class CD {
  String? cid;
  String? cpre;
  String? ctype;
  String? hoid;
  String? cnme;
  String? ad1;
  String? ad2;
  String? ad3;
  String? pcode;
  String? land;
  String? mob;
  String? em;
  String? gst;
  String? ccode;
  String? scode;

  CD(
      {this.cid,
      this.cpre,
      this.ctype,
      this.hoid,
      this.cnme,
      this.ad1,
      this.ad2,
      this.ad3,
      this.pcode,
      this.land,
      this.mob,
      this.em,
      this.gst,
      this.ccode,
      this.scode});

  CD.fromJson(Map<String, dynamic> json) {
    cid = json["cid"];
    cpre = json["cpre"];
    ctype = json["ctype"];
    hoid = json["hoid"];
    cnme = json["cnme"];
    ad1 = json["ad1"];
    ad2 = json["ad2"];
    ad3 = json["ad3"];
    pcode = json["pcode"];
    land = json["land"];
    mob = json["mob"];
    em = json["em"];
    gst = json["gst"];
    ccode = json["ccode"];
    scode = json["scode"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["cid"] = this.cid;
    data["cpre"] = this.cpre;
    data["ctype"] = this.ctype;
    data["hoid"] = this.hoid;
    data["cnme"] = this.cnme;
    data["ad1"] = this.ad1;
    data["ad2"] = this.ad2;
    data["ad3"] = this.ad3;
    data["pcode"] = this.pcode;
    data["land"] = this.land;
    data["mob"] = this.mob;
    data["em"] = this.em;
    data["gst"] = this.gst;
    data["ccode"] = this.ccode;
    data["scode"] = this.scode;

    return data;
  }
}



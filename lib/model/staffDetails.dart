class StaffDetails {
  String? sid;
  String? sname;
  String? unme;
  String? pwd;
  String? ad1;
  String? ad2;
  String? ad3;
  String? ph;
  String? area;


  StaffDetails(
      {this.sid,
      this.sname,
      this.unme,
      this.pwd,
      this.ad1,
      this.ad2,
      this.ad3,
      this.ph,this.area});

  StaffDetails.fromJson(Map<String, dynamic> json) {
    sid = json['sid'];
    sname = json['snme'];
    unme = json['unme'];
    pwd = json['pwd'];
    ad1 = json['ad1'];
    ad2 = json['ad2'];
    ad3 = json['ad3'];
    ph = json['ph'];
    area = json['area'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sid'] = this.sid;
    data['snme'] = this.sname;
    data['unme'] = this.unme;
    data['pwd'] = this.pwd;
    data['ad1'] = this.ad1;
    data['ad2'] = this.ad2;
    data['ad3'] = this.ad3;
    data['ph'] = this.ph;
    data['area'] = this.area;

    return data;
  }
}

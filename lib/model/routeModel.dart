class RouteModel {
  String? rId;
  String? route;

  RouteModel({this.rId, this.route});

  RouteModel.fromJson(Map<String, dynamic> json) {
    rId = json['r_id'];
    route = json['route'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r_id'] = this.rId;
    data['route'] = this.route;
    return data;
  }
}

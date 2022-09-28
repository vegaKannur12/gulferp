class LoginModel {
  String? userId;
  String? staffName;
  String? branchId;
  String? branchName;
  String? branchPrefix;

  LoginModel(
      {this.userId,
      this.staffName,
      this.branchId,
      this.branchName,
      this.branchPrefix});

  LoginModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    staffName = json['staff_name'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    branchPrefix = json['branch_prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['staff_name'] = this.staffName;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['branch_prefix'] = this.branchPrefix;
    return data;
  }
}
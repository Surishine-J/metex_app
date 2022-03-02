
class AdminLoginResponse {
  AdminLoginResponse({
    required this.message,
     this.err,
    required this.data,
  });
  late final String message;
  late final Null err;
  late final List<Admin> data;
  
  AdminLoginResponse.fromJson(Map<String, dynamic> json){
    message = json['message'];
    err = null;
    data = List.from(json['data']).map((e)=>Admin.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['err'] = err;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Admin {
  Admin({
    required this.adminId,
    required this.adminUserId,
    required this.adminPassword,
    required this.adminName,
    required this.adminLevel,
    required this.adminDatetimeAdd,
    required this.adminActive,
  });
  late final int adminId;
  late final String adminUserId;
  late final String adminPassword;
  late final String adminName;
  late final int adminLevel;
  late final String adminDatetimeAdd;
  late final int adminActive;
  
  Admin.fromJson(Map<String, dynamic> json){
    adminId = json['admin_id'];
    adminUserId = json['admin_user_id'];
    adminPassword = json['admin_password'];
    adminName = json['admin_name'];
    adminLevel = json['admin_level'];
    adminDatetimeAdd = json['admin_datetime_add'];
    adminActive = json['admin_active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['admin_id'] = adminId;
    _data['admin_user_id'] = adminUserId;
    _data['admin_password'] = adminPassword;
    _data['admin_name'] = adminName;
    _data['admin_level'] = adminLevel;
    _data['admin_datetime_add'] = adminDatetimeAdd;
    _data['admin_active'] = adminActive;
    return _data;
  }
}
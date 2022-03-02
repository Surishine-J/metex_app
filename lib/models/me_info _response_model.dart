class MeInfoResponseModel {
  MeInfoResponseModel({
    required this.message,
     this.err,
    required this.data,
  });
  late final String message;
  late final Null err;
  late final Data data;
  
  MeInfoResponseModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    err = null;
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['err'] = err;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.loginUser,
    required this.loginUserProfileArr,
  });
  late final LoginUser loginUser;
  late final List<dynamic> loginUserProfileArr;
  
  Data.fromJson(Map<String, dynamic> json){
    loginUser = LoginUser.fromJson(json['loginUser']);
    loginUserProfileArr = List.castFrom<dynamic, dynamic>(json['loginUserProfileArr']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['loginUser'] = loginUser.toJson();
    _data['loginUserProfileArr'] = loginUserProfileArr;
    return _data;
  }
}

class LoginUser {
  LoginUser({
    required this.userId,
    required this.userUserId,
    required this.userPassword,
    required this.userType,
    required this.userDatetimeAdd,
    required this.userDatetimeEdit,
    required this.userName,
    required this.userIsActive,
  });
  late final int userId;
  late final String userUserId;
  late final String userPassword;
  late final String userType;
  late final String userDatetimeAdd;
  late final String userDatetimeEdit;
  late final String userName;
  late final int userIsActive;
  
  LoginUser.fromJson(Map<String, dynamic> json){
    userId = json['user_id'];
    userUserId = json['user_user_id'];
    userPassword = json['user_password'];
    userType = json['user_type'];
    userDatetimeAdd = json['user_datetime_add'];
    userDatetimeEdit = json['user_datetime_edit'];
    userName = json['user_name'];
    userIsActive = json['user_is_active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    _data['user_user_id'] = userUserId;
    _data['user_password'] = userPassword;
    _data['user_type'] = userType;
    _data['user_datetime_add'] = userDatetimeAdd;
    _data['user_datetime_edit'] = userDatetimeEdit;
    _data['user_name'] = userName;
    _data['user_is_active'] = userIsActive;
    return _data;
  }
}
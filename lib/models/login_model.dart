class LoginModel {
  LoginModel({
    required this.message,
     this.err,
    required this.data,
  });
  late final String message;
  late final Null err;
  late final Data data;
  
  LoginModel.fromJson(Map<String, dynamic> json){
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
    required this.session,
    required this.user,
    required this.token,
  });
  late final Session session;
  late final List<User> user;
  late final String token;
  
  Data.fromJson(Map<String, dynamic> json){
    session = Session.fromJson(json['session']);
    user = List.from(json['user']).map((e)=>User.fromJson(e)).toList();
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['session'] = session.toJson();
    _data['user'] = user.map((e)=>e.toJson()).toList();
    _data['token'] = token;
    return _data;
  }
}

class Session {
  Session({
    required this.cookie,
    required this.loginUser,
  });
  late final Cookie cookie;
  late final int loginUser;
  
  Session.fromJson(Map<String, dynamic> json){
    cookie = Cookie.fromJson(json['cookie']);
    loginUser = json['loginUser'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cookie'] = cookie.toJson();
    _data['loginUser'] = loginUser;
    return _data;
  }
}

class Cookie {
  Cookie({
    required this.originalMaxAge,
    required this.expires,
    required this.secure,
    required this.httpOnly,
    required this.path,
  });
  late final int originalMaxAge;
  late final String expires;
  late final bool secure;
  late final bool httpOnly;
  late final String path;
  
  Cookie.fromJson(Map<String, dynamic> json){
    originalMaxAge = json['originalMaxAge'];
    expires = json['expires'];
    secure = json['secure'];
    httpOnly = json['httpOnly'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['originalMaxAge'] = originalMaxAge;
    _data['expires'] = expires;
    _data['secure'] = secure;
    _data['httpOnly'] = httpOnly;
    _data['path'] = path;
    return _data;
  }
}

class User {
  User({
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
  
  User.fromJson(Map<String, dynamic> json){
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
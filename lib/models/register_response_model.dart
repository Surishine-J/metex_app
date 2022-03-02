class RegisterResponse {
  RegisterResponse({
    required this.message,
     this.err,
    required this.data,
  });
  late final String message;
  late final Null err;
  late final Data data;
  
  RegisterResponse.fromJson(Map<String, dynamic> json){
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
    required this.userId,
  });
  late final int userId;
  
  Data.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    return _data;
  }
}
class WorkAllResponseModel {
  WorkAllResponseModel({
    required this.message,
     this.err,
    required this.data,
  });
  late final String message;
  late final Null err;
  late final List<WorkData> data;
  
  WorkAllResponseModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    err = null;
    data = List.from(json['data']).map((e)=>WorkData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['err'] = err;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class WorkData {
  WorkData({
    required this.workId,
    required this.workName,
    required this.workUserType2Id,
  });
  late final int workId;
  late final String workName;
  late final int? workUserType2Id;
  
  WorkData.fromJson(Map<String, dynamic> json){
    workId = json['work_id'];
    workName = json['work_name'];
    workUserType2Id = json['work_user_type2_id'];
  }

 /* factory WorkData.fromJson(Map<String, dynamic> json) =>WorkData(
    // userProfileGroupUId : json['user_profile_group_u_id'] == null ? '' : json['user_profile_group_u_id'],
    workId : json['work_id'] == null ? '' : json['work_id'],
    workName : json['work_name'] == null? '' : json['work_name'],
    workUserType2Id: json['work_user_type2_id']== null ? '' : json['work_user_type2_id']
  );*/

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['work_id'] = workId;
    _data['work_name'] = workName;
    _data['work_user_type2_id'] = workUserType2Id;
    return _data;
  }
}
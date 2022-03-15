class MemberGroup {
  MemberGroup({
    required this.message,
    this.err,
    required this.data,
  });
  late final String message;
  late final Null err;
  late final List<MemberGroupDataModel> data;

  MemberGroup.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    err = null;
    data = List.from(json['data'])
        .map((e) => MemberGroupDataModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['err'] = err;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class MemberGroupDataModel {
  MemberGroupDataModel({
    required this.userProfileGroupUId,
    required this.userProfileGroupUUId,
    required this.userProfileGroupUGId,
    required this.userProfileGroupId,
    required this.userProfileGroupName,
    required this.userProfileUserId,
    required this.userProfileName,
    required this.userProfileImage,
  });
  late final int userProfileGroupUId;
  late final int userProfileGroupUUId;
  late final int userProfileGroupUGId;
  late final int userProfileGroupId;
  late final String userProfileGroupName;
  late final int userProfileUserId;
  late final String userProfileName;
  late final String userProfileImage;

  

 factory MemberGroupDataModel.fromJson(Map<String, dynamic> json) =>MemberGroupDataModel(
     userProfileGroupUId : json['user_profile_group_u_id'] == null ? '' : json['user_profile_group_u_id'],
    userProfileGroupUUId : json['user_profile_group_u_u_id'] == null ? '' :  json['user_profile_group_u_u_id'],
    userProfileGroupUGId : json['user_profile_group_u_g_id'] == null ? '' : json['user_profile_group_u_g_id'],
    userProfileGroupId : json['user_profile_group_id'] == null ? '' :json['user_profile_group_id'],
    userProfileGroupName : json['user_profile_group_name'] == null ? '' : json['user_profile_group_name'],
    userProfileUserId : json['user_profile_user_id'] == null ? '':json['user_profile_user_id'],
    userProfileName : json['user_profile_name'] == null ? '' : json['user_profile_name'],
    userProfileImage : json['user_profile_image'] == null ? '' : json['user_profile_image']
  );
    
  

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_profile_group_u_id'] = userProfileGroupUId;
    _data['user_profile_group_u_u_id'] = userProfileGroupUUId;
    _data['user_profile_group_u_g_id'] = userProfileGroupUGId;
    _data['user_profile_group_id'] = userProfileGroupId;
    _data['user_profile_group_name'] = userProfileGroupName;
    _data['user_profile_user_id'] = userProfileUserId;
    _data['user_profile_name'] = userProfileName;
    _data['user_profile_image'] = userProfileImage;
    return _data;
  }
}

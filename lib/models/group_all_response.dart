class GroupAllResponseModel {
  GroupAllResponseModel({
    required this.message,
    this.err,
    required this.data,
  });
  late final String message;
  late final Null err;
  late final List<GroupData> data;

  GroupAllResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    err = null;
    data = List.from(json['data']).map((e) => GroupData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['err'] = err;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class GroupData {
  GroupData({
    required this.userProfileGroupId,
    required this.userProfileGroupName,
    required this.userProfileGroupDatetimeAdd,
    required this.userProfileGroupDatetimeEdit,
    required this.userProfileGroupHId,
    required this.userProfileGroupUrlId,
    required this.userProfileGroupImage,
    this.userProfileGroupAbout,
    required this.userProfileGroupViewCount,
    required this.userProfileGroupImageId,
    required this.userProfileGroupImageFilename,
    required this.userProfileGroupImageGId,
    required this.userProfileGroupImageIsProfile,
    required this.userProfileGroupImageOffsetX,
    required this.userProfileGroupImageOffsetY,
  });
  late final int userProfileGroupId;
  late final String userProfileGroupName;
  late final String userProfileGroupDatetimeAdd;
  late final String userProfileGroupDatetimeEdit;
  late final int userProfileGroupHId;
  late final String userProfileGroupUrlId;
  late final String userProfileGroupImage;
  late final String? userProfileGroupAbout;
  late final int userProfileGroupViewCount;
  late final String userProfileGroupImageId;
  late final String userProfileGroupImageFilename;
  late final String userProfileGroupImageGId;
  late final String userProfileGroupImageIsProfile;
  late final String userProfileGroupImageOffsetX;
  late final String userProfileGroupImageOffsetY;

 /* GroupData.fromJson(Map<String, dynamic> json) {
    userProfileGroupId = json['user_profile_group_id'];
    userProfileGroupName = json['user_profile_group_name'];
    userProfileGroupDatetimeAdd = json['user_profile_group_datetime_add'];
    userProfileGroupDatetimeEdit = json['user_profile_group_datetime_edit'];
    userProfileGroupHId = json['user_profile_group_h_id'];
    userProfileGroupUrlId = json['user_profile_group_url_id'];
    userProfileGroupImage = json['user_profile_group_image'];
    userProfileGroupAbout = json['user_profile_group_about'];
    userProfileGroupViewCount = json['user_profile_group_view_count'];
    userProfileGroupImageId = json['user_profile_group_image_id'];
    userProfileGroupImageFilename = json['user_profile_group_image_filename'];
    userProfileGroupImageGId = json['user_profile_group_image_g_id'];
    userProfileGroupImageIsProfile =
        json['user_profile_group_image_is_profile'];
    userProfileGroupImageOffsetX = json['user_profile_group_image_offset_x'];
    userProfileGroupImageOffsetY = json['user_profile_group_image_offset_y'];
  }*/

  factory GroupData.fromJson(Map<String, dynamic> json) =>GroupData(
   
    userProfileGroupId : json['user_profile_group_id'] == null ? '':json['user_profile_group_id'],
    userProfileGroupName : json['user_profile_group_name'] == null ? '':json['user_profile_group_name'],
    userProfileGroupDatetimeAdd : json['user_profile_group_datetime_add']== null ? '' :json['user_profile_group_datetime_add'],
    userProfileGroupDatetimeEdit : json['user_profile_group_datetime_edit'] == null ? '' : json['user_profile_group_datetime_edit'],
    userProfileGroupHId : json['user_profile_group_h_id'] == null ? '' :json['user_profile_group_h_id'],
    userProfileGroupUrlId : json['user_profile_group_url_id'] == null ? '':json['user_profile_group_url_id'],
    userProfileGroupImage : json['user_profile_group_image'] == null ? '' :json['user_profile_group_image'],
    userProfileGroupAbout : json['user_profile_group_about'] == null ? '' :json['user_profile_group_about'],
    userProfileGroupViewCount :  json['user_profile_group_view_count'] == null ? '' :json['user_profile_group_view_count'],
    userProfileGroupImageId : json['user_profile_group_image_id'] == null ? '' :json['user_profile_group_image_id'],
    userProfileGroupImageFilename : json['user_profile_group_image_filename'] == null ? '' :json['user_profile_group_image_filename'],
    userProfileGroupImageGId : json['user_profile_group_image_g_id'] == null ? '':json['user_profile_group_image_g_id'],
    userProfileGroupImageIsProfile :
        json['user_profile_group_image_is_profile'] == null ? '' :json['user_profile_group_image_is_profile'],
    userProfileGroupImageOffsetX : json['user_profile_group_image_offset_x'] == null ? '' :json['user_profile_group_image_offset_x'],
    userProfileGroupImageOffsetY : json['user_profile_group_image_offset_y'] == null ? '' :json['user_profile_group_image_offset_y']
  );
    
  

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_profile_group_id'] = userProfileGroupId;
    _data['user_profile_group_name'] = userProfileGroupName;
    _data['user_profile_group_datetime_add'] = userProfileGroupDatetimeAdd;
    _data['user_profile_group_datetime_edit'] = userProfileGroupDatetimeEdit;
    _data['user_profile_group_h_id'] = userProfileGroupHId;
    _data['user_profile_group_url_id'] = userProfileGroupUrlId;
    _data['user_profile_group_image'] = userProfileGroupImage;
    _data['user_profile_group_about'] = userProfileGroupAbout;
    _data['user_profile_group_view_count'] = userProfileGroupViewCount;
    _data['user_profile_group_image_id'] = userProfileGroupImageId;
    _data['user_profile_group_image_filename'] = userProfileGroupImageFilename;
    _data['user_profile_group_image_g_id'] = userProfileGroupImageGId;
    _data['user_profile_group_image_is_profile'] =
        userProfileGroupImageIsProfile;
    _data['user_profile_group_image_offset_x'] = userProfileGroupImageOffsetX;
    _data['user_profile_group_image_offset_y'] = userProfileGroupImageOffsetY;
    return _data;
  }
}

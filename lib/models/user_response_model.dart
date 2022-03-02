
/*class UserResponseModel {
  UserResponseModel({
    required this.message,
     this.err,
    required this.data,
  });
  late final String message;
  late final Null err;
  late final List<UserData> data;
  
  UserResponseModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    err = null;
    data = List.from(json['data']).map((e)=>UserData?.fromJson(e)).toList();
     if (json['data'] != null) {
      List<UserData> data = [];
      json['data'].forEach((v) {
        data.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['err'] = err;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class UserData {
  UserData({
    required this.userId,
    required this.userUserId,
    required this.userType,
    required this.userName,
    required this.userProfileId,
    required this.userProfileUserId,
    required this.userProfileType,
    required this.userProfileName,
    required this.userProfileIsActive,
    required this.userProfileGender,
    required this.userProfileBirthDate,
    required this.userProfileAbout,
    required this.userProfilePrice,
    required this.userProfilePrice2,
    required this.userProfileIsConfirmImage,
    required this.userProfileIsTopStar,
    required this.userProfileUrlId,
    required this.userProfileLineId,
    required this.userProfileImage,
    required this.userProfileViewCount,
    required this.userProfileCanTeamBuilding,
    required this.userProfileCanLeadership,
    required this.userProfileCanCommunication,
    required this.userProfileCanPerformanceManagement,
    required this.userProfileCanCareerGrowth,
    required this.userProfileCanMindSet,
    required this.userProfileCanUnnUnn,
    required this.userProfileZoneId,
    required this.userProfileStarRate,
    required this.userProfileType2,
    required this.userProfileFacebookId,
    required this.userProfileTel,
  });
  late final int userId;
  late final String userUserId;
  late final String userType;
  late final String userName;
  late final int userProfileId;
  late final int userProfileUserId;
  late final String userProfileType;
  late final String userProfileName;
  late final int userProfileIsActive;
  late final String userProfileGender;
  late final String userProfileBirthDate;
  late final String userProfileAbout;
  late final int userProfilePrice;
  late final int userProfilePrice2;
  late final int userProfileIsConfirmImage;
  late final int userProfileIsTopStar;
  late final String userProfileUrlId;
  late final String userProfileLineId;
  late final String userProfileImage;
  late final int userProfileViewCount;
  late final int userProfileCanTeamBuilding;
  late final int userProfileCanLeadership;
  late final int userProfileCanCommunication;
  late final int userProfileCanPerformanceManagement;
  late final int userProfileCanCareerGrowth;
  late final int userProfileCanMindSet;
  late final int userProfileCanUnnUnn;
  late final int userProfileZoneId;
  late final int userProfileStarRate;
  late final int userProfileType2;
  late final String userProfileFacebookId;
  late final String userProfileTel;
  
  UserData.fromJson(Map<String, dynamic> json){
    userId = json['user_id'];
    userUserId = json['user_user_id'];
    userType = json['user_type'];
    userName = json['user_name'];
    userProfileId = json['user_profile_id'];
    userProfileUserId = json['user_profile_user_id'];
    userProfileType = json['user_profile_type'];
    userProfileName = json['user_profile_name'];
    userProfileIsActive = json['user_profile_is_active'];
    userProfileGender = json['user_profile_gender'];
    userProfileBirthDate = json['user_profile_birth_date'];
    userProfileAbout = json['user_profile_about'];
    userProfilePrice = json['user_profile_price'];
    userProfilePrice2 = json['user_profile_price2'];
    userProfileIsConfirmImage = json['user_profile_is_confirm_image'];
    userProfileIsTopStar = json['user_profile_is_top_star'];
    userProfileUrlId = json['user_profile_url_id'];
    userProfileLineId = json['user_profile_line_id'];
    userProfileImage = json['user_profile_image'];
    userProfileViewCount = json['user_profile_view_count'];
    userProfileCanTeamBuilding = json['user_profile_can_team_building'];
    userProfileCanLeadership = json['user_profile_can_leadership'];
    userProfileCanCommunication = json['user_profile_can_communication'];
    userProfileCanPerformanceManagement = json['user_profile_can_performance_management'];
    userProfileCanCareerGrowth = json['user_profile_can_career_growth'];
    userProfileCanMindSet = json['user_profile_can_mind_set'];
    userProfileCanUnnUnn = json['user_profile_can_unn_unn'];
    userProfileZoneId = json['user_profile_zone_id'];
    userProfileStarRate = json['user_profile_star_rate'];
    userProfileType2 = json['user_profile_type2'];
    userProfileFacebookId = json['user_profile_facebook_id'];
    userProfileTel = json['user_profile_tel'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    _data['user_user_id'] = userUserId;
    _data['user_type'] = userType;
    _data['user_name'] = userName;
    _data['user_profile_id'] = userProfileId;
    _data['user_profile_user_id'] = userProfileUserId;
    _data['user_profile_type'] = userProfileType;
    _data['user_profile_name'] = userProfileName;
    _data['user_profile_is_active'] = userProfileIsActive;
    _data['user_profile_gender'] = userProfileGender;
    _data['user_profile_birth_date'] = userProfileBirthDate;
    _data['user_profile_about'] = userProfileAbout;
    _data['user_profile_price'] = userProfilePrice;
    _data['user_profile_price2'] = userProfilePrice2;
    _data['user_profile_is_confirm_image'] = userProfileIsConfirmImage;
    _data['user_profile_is_top_star'] = userProfileIsTopStar;
    _data['user_profile_url_id'] = userProfileUrlId;
    _data['user_profile_line_id'] = userProfileLineId;
    _data['user_profile_image'] = userProfileImage;
    _data['user_profile_view_count'] = userProfileViewCount;
    _data['user_profile_can_team_building'] = userProfileCanTeamBuilding;
    _data['user_profile_can_leadership'] = userProfileCanLeadership;
    _data['user_profile_can_communication'] = userProfileCanCommunication;
    _data['user_profile_can_performance_management'] = userProfileCanPerformanceManagement;
    _data['user_profile_can_career_growth'] = userProfileCanCareerGrowth;
    _data['user_profile_can_mind_set'] = userProfileCanMindSet;
    _data['user_profile_can_unn_unn'] = userProfileCanUnnUnn;
    _data['user_profile_zone_id'] = userProfileZoneId;
    _data['user_profile_star_rate'] = userProfileStarRate;
    _data['user_profile_type2'] = userProfileType2;
    _data['user_profile_facebook_id'] = userProfileFacebookId;
    _data['user_profile_tel'] = userProfileTel;
    return _data;
  }
}

*/



class UserResponseModel {
  UserResponseModel({
    required this.message,
     this.err,
    required this.data,
  });
  late final String message;
  late final Null err;
  late final List<UserData> data;
  
  UserResponseModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    err = null;
    data = List.from(json['data']).map((e)=>UserData.fromJson(e)).toList();

     if (json['data'] != null) {
      List<UserData> data = [];
      json['data'].forEach((v) {
        data.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['err'] = err;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class UserData {
  UserData({
    required this.userId,
    required this.userUserId,
    required this.userType,
    required this.userName,
  });
  late final int userId;
  late final String userUserId;
  late final String userType;
  late final String userName;
  
  UserData.fromJson(Map<String, dynamic> json){
    userId = json['user_id'];
    userUserId = json['user_user_id'];
    userType = json['user_type'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    _data['user_user_id'] = userUserId;
    _data['user_type'] = userType;
    _data['user_name'] = userName;
    return _data;
  }
}













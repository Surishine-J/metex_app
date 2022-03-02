import 'dart:convert';

class UserProfileResponseModel {
  UserProfileResponseModel({
    required this.message,
    this.err,
    required this.data,
  });
  late final String message;
  late final Null err;
  late final List<UserProfileData> data;
//List<UserProfileData> modelFromJson(String str) => List<UserProfileData>.from(json.decode(str).map((x) => UserProfileData.fromJson(x)));

  UserProfileResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    err = null;
    data = List.from(json['data'])
        .map((e) => UserProfileData.fromJson(e))
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

class UserProfileData {
  UserProfileData({
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

  /*UserProfileData.fromJson(Map<String, dynamic> json) {
    userProfileId = json['user_profile_id'];
    userProfileUserId = json['user_profile_user_id'];
    userProfileType = json['user_profile_type'];
    userProfileName = json['user_profile_name'] as String;
    userProfileIsActive = json['user_profile_is_active'];
    userProfileGender = json['user_profile_gender'] as String;
    userProfileBirthDate = json['user_profile_birth_date'] as String;
    userProfileAbout = json['user_profile_about'] as String;
    userProfilePrice = json['user_profile_price'];
    userProfilePrice2 = json['user_profile_price2'];
    userProfileIsConfirmImage = json['user_profile_is_confirm_image'];
    userProfileIsTopStar = json['user_profile_is_top_star'];
    userProfileUrlId = json['user_profile_url_id'] as String;
    userProfileLineId = json['user_profile_line_id'] as String;
    userProfileImage = json['user_profile_image'] as String;
    userProfileViewCount = json['user_profile_view_count'];
    userProfileCanTeamBuilding = json['user_profile_can_team_building'];
    userProfileCanLeadership = json['user_profile_can_leadership'];
    userProfileCanCommunication = json['user_profile_can_communication'];
    userProfileCanPerformanceManagement =
        json['user_profile_can_performance_management'];
    userProfileCanCareerGrowth = json['user_profile_can_career_growth'];
    userProfileCanMindSet = json['user_profile_can_mind_set'];
    userProfileCanUnnUnn = json['user_profile_can_unn_unn'];
    userProfileZoneId = json['user_profile_zone_id'];
    userProfileStarRate = json['user_profile_star_rate'];
    userProfileType2 = json['user_profile_type2'];
    userProfileFacebookId = json['user_profile_facebook_id'];
    userProfileTel = json['user_profile_tel'] as String;
  }*/
  factory UserProfileData.fromJson(Map<String, dynamic> json) =>UserProfileData(
    userProfileId:
    json['user_profile_id'] == null ? '' : json['user_profile_id'],
    userProfileUserId:
    json['user_profile_user_id'] == null ? '' : json['user_profile_user_id'],
    userProfileType :
        json['user_profile_type'] == null ? '' : json['user_profile_type'],
    userProfileName :
        json['user_profile_name'] == null ? '' : json['user_profile_name'],
    userProfileIsActive :
        json['user_profile_is_active'] == null ? '' : json['user_profile_is_active'],
    userProfileGender :
        json['user_profile_gender'] == null ? '' : json['user_profile_gender'],
    userProfileBirthDate :
        json['user_profile_birth_date'] == null ? '' : json['user_profile_birth_date'],
    userProfileAbout :
        json['user_profile_about'] == null ? '' : json['user_profile_about'],
    userProfilePrice :
        json['user_profile_price'] == null ? '' : json['user_profile_price'],
    userProfilePrice2 :
        json['user_profile_price2'] == null ? '' : json['user_profile_price2'],
    userProfileIsConfirmImage : json['user_profile_is_confirm_image'] == null
        ? ''
        : json['user_profile_is_confirm_image'],
    userProfileIsTopStar :
        json['user_profile_is_top_star'] == null ? '' : json['user_profile_is_top_star'],
    userProfileUrlId :
        json['user_profile_url_id'] == null ? '' : json['user_profile_url_id'],
    userProfileLineId :
        json['user_profile_line_id'] == null ? '' : json['user_profile_line_id'],
    userProfileImage :
        json['user_profile_image'] == null ? '' : json['user_profile_image'],
    userProfileViewCount :
        json['user_profile_view_count'] == null ? '' : json['user_profile_id'],
    userProfileCanTeamBuilding : json['user_profile_can_team_building'] == null
        ? ''
        : json['user_profile_can_team_building'],
    userProfileCanLeadership : json['user_profile_can_leadership'] == null
        ? ''
        : json['user_profile_can_leadership'],
    userProfileCanCommunication : json['user_profile_can_communication'] == null
        ? ''
        : json['user_profile_can_communication'],
    userProfileCanPerformanceManagement :
        json['user_profile_can_performance_management'] == null
            ? ''
            : json['user_profile_can_performance_management'],
    userProfileCanCareerGrowth : json['user_profile_can_career_growth'] == null
        ? ''
        : json['user_profile_can_career_growth'],
    userProfileCanMindSet : json['user_profile_can_mind_set'] == null
        ? ''
        : json['user_profile_can_mind_set'],
    userProfileCanUnnUnn :
        json['user_profile_can_unn_unn'] == null ? '' : json['user_profile_can_unn_unn'],
    userProfileZoneId :
        json['user_profile_zone_id'] == null ? '' : json['user_profile_zone_id'],
    userProfileStarRate :
        json['user_profile_star_rate'] == null ? '' : json['user_profile_star_rate'],
    userProfileType2 :
        json['user_profile_type2'] == null ? '' : json['user_profile_type2'],
    userProfileFacebookId : json['user_profile_facebook_id'] == null
        ? ''
        : json['user_profile_facebook_id'],
    userProfileTel :
        json['user_profile_tel'] == null ? '' : json['user_profile_tel'],
  );
    
  

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
    _data['user_profile_can_performance_management'] =
        userProfileCanPerformanceManagement;
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

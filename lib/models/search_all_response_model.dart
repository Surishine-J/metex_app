/*class SearchAllResponse {
  SearchAllResponse({
    required this.message,
    this.err,
    required this.data,
  });
  late final String message;
  late final Null err;
  late final Data data;

  SearchAllResponse.fromJson(Map<String, dynamic> json) {
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
    required this.page,
    required this.maxPage,
    required this.from,
    required this.to,
    required this.total,
    required this.count,
    required this.expertdetails,
  });
  late final int page;
  late final int maxPage;
  late final int from;
  late final int to;
  late final int total;
  late final int count;
  late final List<ExpertDetails> expertdetails;

  Data.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    maxPage = json['maxPage'];
    from = json['from'];
    to = json['to'];
    total = json['total'];
    count = json['count'];
    expertdetails =
        List.from(json['list']).map((e) => ExpertDetails.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['page'] = page;
    _data['maxPage'] = maxPage;
    _data['from'] = from;
    _data['to'] = to;
    _data['total'] = total;
    _data['count'] = count;
    _data['list'] = expertdetails.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ExpertDetails {
  ExpertDetails({
    required this.userProfileId,
    required this.userProfileUserId,
    required this.userProfileType,
    required this.userProfileName,
    required this.userProfileIsActive,
    required this.userProfileGender,
    this.userProfileBirthDate,
    this.userProfileAbout,
    required this.userProfilePrice,
    required this.userProfilePrice2,
    required this.userProfileIsConfirmImage,
    required this.userProfileIsTopStar,
    required this.userProfileUrlId,
    this.userProfileLineId,
    this.userProfileImage,
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
    this.userProfileFacebookId,
    this.userProfileTel,
    this.userFavoriteId,
    this.userFavoriteUserId,
    this.userFavoriteUserProfileTargetId,
    this.userFavoriteDatetimeAdd,
    this.zoneId,
    this.zoneName,
    this.zoneOrder,
    this.userType2Id,
    this.userType2Name,
  });
  late final int userProfileId;
  late final int userProfileUserId;
  late final String userProfileType;
  late final String userProfileName;
  late final int userProfileIsActive;
  late final String userProfileGender;
  late final String? userProfileBirthDate;
  late final String? userProfileAbout;
  late final int userProfilePrice;
  late final int userProfilePrice2;
  late final int userProfileIsConfirmImage;
  late final int userProfileIsTopStar;
  late final String userProfileUrlId;
  late final String? userProfileLineId;
  late final String? userProfileImage;
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
  late final String? userProfileFacebookId;
  late final String? userProfileTel;
  late final int? userFavoriteId;
  late final int? userFavoriteUserId;
  late final int? userFavoriteUserProfileTargetId;
  late final String? userFavoriteDatetimeAdd;
  late final int? zoneId;
  late final String? zoneName;
  late final int? zoneOrder;
  late final int? userType2Id;
  late final String? userType2Name;

  ExpertDetails.fromJson(Map<String, dynamic> json) {
    userProfileId = json['user_profile_id'];
    userProfileUserId = json['user_profile_user_id'];
    userProfileType = json['user_profile_type'];
    userProfileName = json['user_profile_name'];
    userProfileIsActive = json['user_profile_is_active'];
    userProfileGender = json['user_profile_gender'];
    userProfileBirthDate = json['user_profile_birth_date'];
    userProfileAbout =json['user_profile_about'];
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
    userProfileCanPerformanceManagement =
        json['user_profile_can_performance_management'];
    userProfileCanCareerGrowth = json['user_profile_can_career_growth'];
    userProfileCanMindSet = json['user_profile_can_mind_set'];
    userProfileCanUnnUnn = json['user_profile_can_unn_unn'];
    userProfileZoneId = json['user_profile_zone_id'];
    userProfileStarRate = json['user_profile_star_rate'];
    userProfileType2 = json['user_profile_type2'];
    userProfileFacebookId = json['user_profile_facebook_id'];
    userProfileTel = json['user_profile_tel'];
    userFavoriteId = json['user_favorite_id'];
    userFavoriteUserId =  json['user_favorite_user_id'];
    userFavoriteUserProfileTargetId = json['user_favorite_user_profile_target_id'];
    userFavoriteDatetimeAdd = json['user_favorite_datetime_add'];;
    zoneId = json['zone_id'];
    zoneName = json['zone_name'];
    zoneOrder = json['zone_order'];
    userType2Id = json['user_type2_id'];
    userType2Name = json['user_type2_name'];
  }

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
    _data['user_favorite_id'] = userFavoriteId;
    _data['user_favorite_user_id'] = userFavoriteUserId;
    _data['user_favorite_user_profile_target_id'] =
        userFavoriteUserProfileTargetId;
    _data['user_favorite_datetime_add'] = userFavoriteDatetimeAdd;
    _data['zone_id'] = zoneId;
    _data['zone_name'] = zoneName;
    _data['zone_order'] = zoneOrder;
    _data['user_type2_id'] = userType2Id;
    _data['user_type2_name'] = userType2Name;
    return _data;
  }
}
*/
class SearchAllResponse {
  SearchAllResponse({
    required this.message,
     this.err,
    required this.data,
  });
  late final String message;
  late final Null err;
  late final Data data;
  
  SearchAllResponse.fromJson(Map<String, dynamic> json){
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
    required this.page,
    required this.maxPage,
    required this.from,
    required this.to,
    required this.total,
    required this.count,
    required this.expertdetails,
  });
  late final int page;
  late final int maxPage;
  late final int from;
  late final int to;
  late final int total;
  late final int count;
  late final List<ExpertDetails> expertdetails;
  
  Data.fromJson(Map<String, dynamic> json){
    page = json['page'];
    maxPage = json['maxPage'];
    from = json['from'];
    to = json['to'];
    total = json['total'];
    count = json['count'];
    expertdetails = List.from(json['list']).map((e)=>ExpertDetails.fromJson(e)).toList();
 
    if (json['data'] != null) {
      List<ExpertDetails> data = [];
      json['data'].forEach((v) {
        data.add(new ExpertDetails.fromJson(v));
      });
    }
 
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['page'] = page;
    _data['maxPage'] = maxPage;
    _data['from'] = from;
    _data['to'] = to;
    _data['total'] = total;
    _data['count'] = count;
    _data['list'] = expertdetails.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ExpertDetails {
  ExpertDetails({
    required this.userProfileId,
    required this.userProfileUserId,
    required this.userProfileType,
    required this.userProfileName,
    required this.userProfileIsActive,
    required this.userProfileGender,
     this.userProfileBirthDate,
     this.userProfileAbout,
    required this.userProfilePrice,
    required this.userProfilePrice2,
    required this.userProfileIsConfirmImage,
    required this.userProfileIsTopStar,
    required this.userProfileUrlId,
     this.userProfileLineId,
     this.userProfileImage,
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
     this.userProfileFacebookId,
     this.userProfileTel,
    required this.isFavorite,
     this.zoneId,
     this.zoneName,
     this.zoneOrder,
     this.userType2Id,
     this.userType2Name,
  });
  late final int userProfileId;
  late final int userProfileUserId;
  late final String userProfileType;
  late final String userProfileName;
  late final int userProfileIsActive;
  late final String userProfileGender;
  late final String? userProfileBirthDate;
  late final String? userProfileAbout;
  late final int userProfilePrice;
  late final int userProfilePrice2;
  late final int userProfileIsConfirmImage;
  late final int userProfileIsTopStar;
  late final String userProfileUrlId;
  late final String? userProfileLineId;
  late final String? userProfileImage;
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
  late final String? userProfileFacebookId;
  late final String? userProfileTel;
  late final int isFavorite;
  late final int? zoneId;
  late final String? zoneName;
  late final int? zoneOrder;
  late final int? userType2Id;
  late final String? userType2Name;
  
  ExpertDetails.fromJson(Map<String, dynamic> json){
    userProfileId = json['user_profile_id'];
    userProfileUserId = json['user_profile_user_id'];
    userProfileType = json['user_profile_type'];
    userProfileName = json['user_profile_name'];
    userProfileIsActive = json['user_profile_is_active'];
    userProfileGender = json['user_profile_gender'];
    userProfileBirthDate =json['user_profile_birth_date'];
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
    isFavorite = json['is_favorite'];
    zoneId = json['zone_id'];
    zoneName = json['zone_name'];
    zoneOrder = json['zone_order'];
    userType2Id = json['user_type2_id'];
    userType2Name =json['user_type2_name'];
  }

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
    _data['user_profile_can_performance_management'] = userProfileCanPerformanceManagement;
    _data['user_profile_can_career_growth'] = userProfileCanCareerGrowth;
    _data['user_profile_can_mind_set'] = userProfileCanMindSet;
    _data['user_profile_can_unn_unn'] = userProfileCanUnnUnn;
    _data['user_profile_zone_id'] = userProfileZoneId;
    _data['user_profile_star_rate'] = userProfileStarRate;
    _data['user_profile_type2'] = userProfileType2;
    _data['user_profile_facebook_id'] = userProfileFacebookId;
    _data['user_profile_tel'] = userProfileTel;
    _data['is_favorite'] = isFavorite;
    _data['zone_id'] = zoneId;
    _data['zone_name'] = zoneName;
    _data['zone_order'] = zoneOrder;
    _data['user_type2_id'] = userType2Id;
    _data['user_type2_name'] = userType2Name;
    return _data;
  }
}





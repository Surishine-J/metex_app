class FavoriteResponse {
  FavoriteResponse({
    required this.message,
    this.err,
    required this.data,
  });
  late final String message;
  late final Null err;
  late final List<Favorite> data;

  FavoriteResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    err = null;
    data = List.from(json['data']).map((e) => Favorite.fromJson(e)).toList();
    if (json['data'] != null) {
      List<Favorite> data = [];
      json['data'].forEach((v) {
        data.add(new Favorite.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['err'] = err;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Favorite {
  Favorite({
    required this.userFavoriteId,
    required this.userFavoriteUserId,
    required this.userFavoriteUserProfileTargetId,
    required this.userFavoriteDatetimeAdd,
    required this.userName,
    this.userProfileName,
  });
  late final int userFavoriteId;
  late final int userFavoriteUserId;
  late final int userFavoriteUserProfileTargetId;
  late final String userFavoriteDatetimeAdd;
  late final String userName;
  late final String? userProfileName;

  Favorite.fromJson(Map<String, dynamic> json) {
    userFavoriteId = json['user_favorite_id'];
    userFavoriteUserId = json['user_favorite_user_id'];
    userFavoriteUserProfileTargetId =
        json['user_favorite_user_profile_target_id'];
    userFavoriteDatetimeAdd = json['user_favorite_datetime_add'];
    userName = json['user_name'];
    userProfileName = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_favorite_id'] = userFavoriteId;
    _data['user_favorite_user_id'] = userFavoriteUserId;
    _data['user_favorite_user_profile_target_id'] =
        userFavoriteUserProfileTargetId;
    _data['user_favorite_datetime_add'] = userFavoriteDatetimeAdd;
    _data['user_name'] = userName;
    _data['user_profile_name'] = userProfileName;
    return _data;
  }
}

import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:metex_app/data/data.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/api_respose.dart';
import 'package:metex_app/models/experts_model.dart';
import 'package:metex_app/models/models.dart';
import 'package:metex_app/models/search_all_response_model.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/services/config.dart';
import 'package:metex_app/services/zone_services.dart';
import 'package:metex_app/utils/utils.dart';

class HomeAfterLoginPage extends StatefulWidget {
  // late List<User> userLogin;
  String userId;
  String userName;
  String userType;
  HomeAfterLoginPage(
      {Key? key,
      required this.userId,
      required this.userName,
      required this.userType})
      : super(key: key);

  @override
  _HomeAfterLoginPageState createState() => _HomeAfterLoginPageState();
}

class _HomeAfterLoginPageState extends State<HomeAfterLoginPage> {
  List<ExpertDetails> allExpertlist = [];
  List<ExpertDetails> coachList = [];
  List<ExpertDetails> trainerList = [];
  List<ExpertDetails> consultantList = [];
  List<ExpertDetails> topExpertList = [];
  List<ExpertDetails> favoriteList = [];
  List<ExpertDetails> chooseExpertlist = [];

  late String search = '';
  late int type2 = 0;
  late int can_team_building = 0;
  late int can_leadership = 0;
  late int can_communication = 0;
  late int can_performance_management = 0;
  late int can_career_growth = 0;
  late int can_mind_set = 0;
  late int can_unn_unn = 0;
  late int zone_id = 0;
  TextEditingController searchController = new TextEditingController();

  List<ExpertDetails> subList = [];
  List<ExpertDetails> subListFavorite = [];
  List<ExpertDetails> subListTopStar = [];

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  String addIndex(int idx) {
    int result = 0;
    result = idx + 1;

    return result.toString();
  }

  List<List<ExpertModel>> allCatList = [
    // DataFile.getAllCategoryModel(),
    // DataFile.getBeerCategoryModel(),
    // DataFile.getWineModel(),
    DataFile.getAllExpertModel()
  ];
//  List<SubCategoryModel> subList = [];
  // List<ExpertModel> subList = [];

  List<String> selectionList = [
    // "ทั้งหมด",
    "Coach",
    "Trainer",
    "Consultant",
  ];
  List<String> selectedFilterList = [];
  List<String> filterList = [
    "ไม้สัก",
    "ไม้ยาง",
    "ไม้พะยุง",
    "ไม้ตะเคียนทอง",
    "ไม้ประดู่ป่า",
    "ไผ่",
    "ผักอินทรีย์",
    "ผักปลอดสารพิษ",
    "ผักอนามัย",
    "ผักไฮโดรโปนิกส์",
    "ช่างแอร์",
    "ช่างไฟฟ้า",
    "ช่างทำกุญแจ",
    "ช่างปั้น",
    "ช่างทอผ้า",
    "ช่างเงิน",
    "ช่างจักรสาน",
    "อื่นๆ",
  ];

  late String _selectedValue = 'ชาย';
  List<DropdownMenuItem<String>> items = [
    'ชาย',
    'หญิง',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
    );
  }).toList();

  int selectedCareer = 0;
  int selectedPos = 0;
  // TextEditingController emailController = new TextEditingController();

  TextEditingController emailController = new TextEditingController();

  List<LocationModel> location = [];
  List<LocationModel> locationSelectList = [];
  List<CareerTypeDataModel> careerList = [];
  List<CareerTypeDataModel> selectionCareerList = []; //ตัวเลือก อาชีพ
  List<CareerTypeDataModel> selectFilterCareerList = [];

  getDataZone() async {
    var response = await http.get(
      Uri.parse('http://127.0.0.1:3000/api/zone/all'),
    );
    if (response.statusCode == 200) {
      final ZoneModel zoneModel =
          ZoneModel.fromJson(convert.jsonDecode(response.body));
      setState(() {
        location = zoneModel.data;
        //print(location);
      });
    } else {
      print('Error');
    }
  }

  getDataExpertType() async {
    var response = await http.get(
      Uri.parse('http://localhost:3000/api/user/usertype2/all'),
    );
    if (response.statusCode == 200) {
      final CareerTypeModel careerTypeModel =
          CareerTypeModel.fromJson(convert.jsonDecode(response.body));
      setState(() {
        careerList = careerTypeModel.data;
        selectionCareerList.add(
            CareerTypeDataModel(user_type2_id: 0, user_type2_name: "ทั้งหมด"));
        selectionCareerList.addAll(careerList);
      });
    } else {
      print('Error');
    }
  }

  getDataExpertAll() async {
    /*  var response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/user/search/all'),
    );
    // print('get expert all' + " " + response.statusCode.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      final SearchAllResponse searchModel =
          SearchAllResponse.fromJson(convert.jsonDecode(response.body));

      setState(() {
        allExpertlist = searchModel.data.expertdetails
            .where((element) => element.userProfileType == 'u')
            .toList();
        coachList = allExpertlist
            .where((element) => element.userProfileType2 == 1)
            .toList();
        trainerList = allExpertlist
            .where((element) => element.userProfileType2 == 2)
            .toList();
        consultantList = allExpertlist
            .where((element) => element.userProfileType2 == 3)
            .toList();
        topExpertList = allExpertlist
            .where((element) => element.userProfileIsTopStar == 1)
            .toList();
        favoriteList = allExpertlist.where((element) => element.isFavorite ==1)
            //.where((element) =>
              //  element.userFavoriteUserId == int.parse(widget.userId))
            .toList();

        //print(careerTypeModel.data[0].user_type2_name);
      });
    } else {
      print('Error getDataExpertAll');
    }*/

    var data = {"user_id": widget.userId};
    try {
      //  Uri url = Uri.parse('http://127.0.0.1:3000/api/user/logout'); //url on web
      Uri url =
          Uri.parse(Config.BASE_URL + '/api/user/search/all'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      print(response.statusCode);
      if (response.statusCode == 200) {
        // print(response.body);
        final SearchAllResponse searchModel =
            SearchAllResponse.fromJson(convert.jsonDecode(response.body));

        setState(() {
          allExpertlist = searchModel.data.expertdetails
              .where((element) => element.userProfileType == 'u')
              .toList();
          coachList = allExpertlist
              .where((element) => element.userProfileType2 == 1)
              .toList();
          trainerList = allExpertlist
              .where((element) => element.userProfileType2 == 2)
              .toList();
          consultantList = allExpertlist
              .where((element) => element.userProfileType2 == 3)
              .toList();
          topExpertList = allExpertlist
              .where((element) => element.userProfileIsTopStar == 1)
              .toList();
          favoriteList = allExpertlist
              .where((element) => element.isFavorite == 1)
              //.where((element) =>
              //  element.userFavoriteUserId == int.parse(widget.userId))
              .toList();

          //print(careerTypeModel.data[0].user_type2_name);
        });
      } else {
        print('Error getDataExpertAll');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<ExpertDetails>? checkFilter() {
    if (selectedPos == 0) {
      return allExpertlist;
    }
    if (selectedPos == 1) {
      return coachList;
    }
    if (selectedPos == 2) {
      return trainerList;
    }
    if (selectedPos == 3) {
      return consultantList;
    }
    return null;
  }

  IconButton checkLike() {
    return IconButton(
      icon: Icon(Icons.favorite),
      iconSize: 20,
      color: ConstantData.redColor,
      onPressed: () {
        print('กดยกเลิกหัวใจ');
        print('userid ' + widget.userId);
      },
    );
  }

  sendParamToNextPage() {
    search = searchController.text;
    type2 = selectedPos;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchResultPage(
                  search: search,
                  type2: type2,
                  can_team_building: can_team_building,
                  can_leadership: can_leadership,
                  can_communication: can_communication,
                  can_performance_management: can_performance_management,
                  can_career_growth: can_career_growth,
                  can_mind_set: can_mind_set,
                  can_unn_unn: can_unn_unn,
                  zone_id: zone_id,
                )));
  }

  toCreateFavorite(String userId, String userProfileId) async {
    var data = {
      "user_id": userId,
      "user_profile_id": userProfileId,
    };
    try {
      Uri url = Uri.parse(
          'http://localhost:3000/api/user/favorite/create'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      print('data');
      print(data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        // print(response.body);
        getDataExpertAll();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('ไม่พบผู้ใช้ ')));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  toDeleteFavorite(String userId, String user_profile_id) async {
    var data = {
      "user_id": userId,
      "user_profile_id": user_profile_id
      // "user_favorite_id": userFavoriteId
    };
    try {
      Uri url = Uri.parse(
          'http://127.0.0.1:3000/api/user/favorite/delete'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      print(data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        //  print(response.body);
        getDataExpertAll();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('ไม่พบผู้ใช้ ')));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  sendDataToExpertDetailsPage(String user_profile_id) {
    print('user_profile_id =======>' + user_profile_id);
    setState(() {
      chooseExpertlist = allExpertlist
          .where((element) => element.userProfileId == int.parse(user_profile_id))
          .toList();

      print('chooseExpertlist ===== >' + chooseExpertlist.length.toString());

      if (chooseExpertlist.length > 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    ExpertDetailPage(chooseExpertlist: chooseExpertlist)));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getDataZone();
    getDataExpertType();
    getDataExpertAll();

   
  }

  // List<ZoneModel> _categoryList = <ZoneModel>[];

  LocationModel? dropdownValue;

  //late String _selectedValue = 'ชาย';
  List<DropdownMenuItem<String>> zones = [
    'ชาย',
    'หญิง',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    subList = [];
    subListFavorite = [];
    subListTopStar = [];
    // subList = allCatList[selectedCareer];
    subList = checkFilter()!;
    subListTopStar = topExpertList;
    subListFavorite = favoriteList;
    var cellHeight = SizeConfig.safeBlockHorizontal! * 58;
    double cellMargin2 = 7;
    double cellMargin = 7;

    var _crossAxisSpacing2 = 8.0;
    var _crossAxisSpacing = 8.0;
    var _crossAxisCount2 = 3;

    var bottomDialogTextSizeFilter = SizeConfig.safeBlockVertical! * 55;
    var cellHeight2 =
        ConstantWidget.getPercentSize1(bottomDialogTextSizeFilter, 13);
    var _screenWidth = MediaQuery.of(context).size.width;

    var _crossAxisCount = 2;
    var _width2 =
        (_screenWidth - ((_crossAxisCount2 - 1) * _crossAxisSpacing2)) /
            _crossAxisCount2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var _aspectRatio2 = _width2 / cellHeight2;
    var _aspectRatio = _width / cellHeight;

    // double editTextHeight = MediaQuery.of(context).size.height * 0.06;
    double mainCatWidth = (SizeConfig.safeBlockHorizontal! * 50) -
        (cellMargin * 2 + _crossAxisSpacing);
    double mainCatHeight = cellHeight;
    double topCellHeight = ConstantWidget.getPercentSize(cellHeight, 12);
    double imageSize = SizeConfig.safeBlockVertical! * 6.5;
    double bottomRemainSize = cellHeight - imageSize - topCellHeight;
    double topSliderWidth = SizeConfig.safeBlockHorizontal! * 23;
    double topSliderHeight = SizeConfig.safeBlockHorizontal! * 13;

    double editTextHeight = MediaQuery.of(context).size.height * 0.06;

    return WillPopScope(
      child: new Scaffold(
        /*appBar: AppBar(
            title: new Text('SingleChildScrollView Demo'),
          ),*/
        body: new SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              // color: Colors.yellow,
              margin: EdgeInsets.only(
                // bottom: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                //  left: MediaQuery.of(context).size.width * 0.07,
                // right: MediaQuery.of(context).size.width * 0.07,
              ),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  Center(
                    child: ConstantWidget.getCustomTextWithoutAlign(
                        S.of(context).expertmsg,
                        // Colors.black,
                        ConstantData.primaryColor,
                        FontWeight.w900,
                        26.0),
                  ),
                  Container(
                    // color: Colors.red,
                    height: topSliderHeight * 1.25,

                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(
                          ConstantWidget.getPercentSize1(topSliderWidth, 5)),
                      itemCount: selectionCareerList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedPos = index;
                            });
                          },
                          child: Container(
                            width: topSliderWidth,
                            decoration: BoxDecoration(
                                image: selectionCareerList[index]
                                            .user_type2_id ==
                                        1
                                    ? DecorationImage(
                                        image: AssetImage(
                                            'assets/images/logo/carve.png'),
                                        fit: BoxFit.cover)
                                    : selectionCareerList[index]
                                                .user_type2_id ==
                                            2
                                        ? DecorationImage(
                                            image: AssetImage(
                                                'assets/images/logo/fruit.png'),
                                            fit: BoxFit.cover)
                                        : selectionCareerList[index]
                                                    .user_type2_id ==
                                                3
                                            ? DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/logo/hydro.png'),
                                                fit: BoxFit.cover)
                                            : selectionCareerList[index]
                                                        .user_type2_id ==
                                                    4
                                                ? DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/logo/carbon.png'),
                                                    fit: BoxFit.cover)
                                                : DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/logo/all.jpg'),
                                                    fit: BoxFit.cover),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: (selectedPos == index)
                                    ? ConstantData.primaryColor
                                    : ConstantData.lightPrimaryColors),
                            margin: EdgeInsets.all(
                                ConstantWidget.getPercentSize1(
                                    topSliderWidth, 5)),
                            /* child: Align(
                                  alignment: Alignment.center,
                                  child: ConstantWidget.getCustomText(
                                      selectionCareerList[index]
                                          .user_type2_name
                                          .toString(),
                                      (selectedPos == index)
                                          ? ConstantData.whiteColor
                                          : ConstantData.whiteColor,
                                      1,
                                      TextAlign.right,
                                      FontWeight.bold,
                                      ConstantWidget.getPercentSize1(
                                          topSliderHeight, 25)),
                                ),*/
                            child: Align(
                              //heightFactor:100 ,
                              alignment: Alignment.bottomCenter,
                              child: ConstantWidget.getCustomTextWithoutAlign(
                                  selectionCareerList[index]
                                      .user_type2_name
                                      .toString(),
                                  ConstantData.whiteColor,
                                  FontWeight.w900,
                                  36.0),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: ConstantWidget.getCustomTextWithoutAlign(
                        // "Test",
                        S.of(context).expertmsg2,
                        // Colors.black,
                        ConstantData.primaryColor,
                        FontWeight.w900,
                        20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  Center(
                    child: ConstantWidget.getCustomTextWithoutAlign(
                        S.of(context).expertmsg3,
                        // Colors.black,
                        ConstantData.primaryColor,
                        FontWeight.normal,
                        18.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  GridView.count(
                    //ปุ่ม  filter 7 ปุ่ม
                    shrinkWrap: true,
                    primary: true,
                    mainAxisSpacing: _crossAxisSpacing2,
                    padding: EdgeInsets.symmetric(
                        vertical: cellMargin2,
                        horizontal: cellMargin2 + _crossAxisSpacing2),
                    crossAxisCount: 5, //_crossAxisCount2,
                    crossAxisSpacing: _crossAxisSpacing2,
                    childAspectRatio: _aspectRatio2,
                    children: List.generate(
                      filterList.length,
                      (index) {
                        // print( "sizes===$mainCatWidth==$mainCatHeight--$_aspectRatio");
                        return InkWell(
                          onTap: () {
                            if (selectedFilterList != null &&
                                selectedFilterList
                                    .contains(filterList[index])) {
                              selectedFilterList.remove(filterList[index]);
                            } else {
                              selectedFilterList
                                  .add(filterList[index].toString());
                            }
                            setState(() {
                              if (filterList[index].toString() ==
                                  'Teambuilding') {
                                if (selectedFilterList != null &&
                                    selectedFilterList
                                        .contains(filterList[index])) {
                                  can_team_building = 1;
                                  print('can_team_building 1');
                                  print(selectedFilterList);
                                } else {
                                  can_team_building = 0;
                                  print('can_team_building 0');
                                  print(selectedFilterList);
                                }
                              }
                              if (filterList[index].toString() ==
                                  'Leadership') {
                                if (selectedFilterList != null &&
                                    selectedFilterList
                                        .contains(filterList[index])) {
                                  can_leadership = 1;
                                  print('can_leadership 1');
                                  print(selectedFilterList);
                                } else {
                                  can_leadership = 0;
                                  print('can_leadership 0');
                                  print(selectedFilterList);
                                }
                              }
                              if (filterList[index].toString() ==
                                  'Communication') {
                                if (selectedFilterList != null &&
                                    selectedFilterList
                                        .contains(filterList[index])) {
                                  can_communication = 1;
                                  print('can_communication 1');
                                  print(selectedFilterList);
                                } else {
                                  can_communication = 0;
                                  print('can_communication 0');
                                  print(selectedFilterList);
                                }
                              }
                              if (filterList[index].toString() ==
                                  'Performance Management') {
                                if (selectedFilterList != null &&
                                    selectedFilterList
                                        .contains(filterList[index])) {
                                  can_performance_management = 1;
                                  print('can_performance_management 1');
                                  print(selectedFilterList);
                                } else {
                                  can_performance_management = 0;
                                  print('can_performance_management 0');
                                  print(selectedFilterList);
                                }
                              }
                              if (filterList[index].toString() ==
                                  'career Growth') {
                                if (selectedFilterList != null &&
                                    selectedFilterList
                                        .contains(filterList[index])) {
                                  can_career_growth = 1;
                                  print('can_career_growth 1');
                                  print(selectedFilterList);
                                } else {
                                  can_career_growth = 0;
                                  print('can_career_growth 0');
                                  print(selectedFilterList);
                                }
                              }
                              if (filterList[index].toString() == 'Mind set') {
                                if (selectedFilterList != null &&
                                    selectedFilterList
                                        .contains(filterList[index])) {
                                  can_unn_unn = 1;
                                  print('can_unn_unn 1');
                                  print(selectedFilterList);
                                } else {
                                  can_unn_unn = 0;
                                  print('can_unn_unn 0');
                                  print(selectedFilterList);
                                }
                              }
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: cellHeight2,
                            decoration: BoxDecoration(
                              color: ConstantData.bgColor,
                              //lightPrimaryColors,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              border: Border.all(
                                  color: (selectedFilterList != null &&
                                          selectedFilterList
                                              .contains(filterList[index]))
                                      ? ConstantData.primaryColor //accentColors
                                      : ConstantData
                                          .kGreyTextColor, //Colors.transparent,
                                  width: 1),
                            ),
                            child: Center(
                              child: ConstantWidget.getCustomText(
                                  // filterList[index].name,
                                  filterList[index],
                                  //ConstantData.textColor,
                                  (selectedFilterList != null &&
                                          selectedFilterList
                                              .contains(filterList[index]))
                                      ? ConstantData.primaryColor //accentColors
                                      : ConstantData.kGreyTextColor,
                                  1,
                                  TextAlign.center,
                                  FontWeight.bold,
                                  ConstantWidget.getPercentSize1(
                                      cellHeight2, 25)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        //margin: EdgeInsets.only(bottom: 10, top: 10),
                        height: editTextHeight,
                        width: 300,
                        child: TextField(
                          maxLines: 1,
                          controller: emailController,
                          // controller:  S.of(context).documentNo.toString(),
                          style: TextStyle(
                              fontFamily: ConstantData.fontFamily,
                              color: ConstantData.primaryTextColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),

                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 10.0),
                            // floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5),
                              ),
                            ),
                            // border: InputBorder.none,
                            // labelText: S.of(context).searchbyname,
                            hintText: S.of(context).searchbyname,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        // height: 40.0,
                        height: editTextHeight,
                        // padding: EdgeInsets.only(left: 100, right: 100),
                        width: 305,

                        decoration: BoxDecoration(
                          color: ConstantData.bgColor,
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: ConstantData.kGreyTextColor),
                          /* border: Border.all(
                                color: ConstantData.lightGrey, width: .5),*/
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<LocationModel>(
                            value: dropdownValue,
                            //isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down,
                                color: Colors.grey.withOpacity(0.7)),
                            // items: items,
                            items: location
                                .map<DropdownMenuItem<LocationModel>>(
                                    (LocationModel value) {
                              return DropdownMenuItem<LocationModel>(
                                value: value,
                                child: Text(value.zoneName.toString()),
                              );
                            }).toList(),
                            onChanged: (LocationModel? newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                print('----- value ------');
                                print(dropdownValue!.zoneId.toString() +
                                    " " +
                                    dropdownValue!.zoneName.toString());
                              });
                            },
                            hint: Text(
                              "------- โซน -------",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            // value: _selectedValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    child: Container(
                        width: 300,
                        margin: EdgeInsets.only(top: 20),
                        height: 50,
                        decoration: BoxDecoration(
                            color: ConstantData.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: InkWell(
                          child: Center(
                            child: ConstantWidget.getCustomTextWithoutAlign(
                                S.of(context).search,
                                Colors.white,
                                FontWeight.w900,
                                ConstantData.font15Px),
                          ),
                        )),
                    onTap: () {
                      // PrefData.setIsSignIn(true);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => sendParamToNextPage()));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(child: Divider()),

                      // Expanded(child: Divider()),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.star,
                        size: 36,
                      ),
                      ConstantWidget.getCustomTextWithoutAlign(
                          //'Top Expert',
                          S.of(context).topexpert,
                          // Colors.black,
                          ConstantData.primaryColor,
                          FontWeight.w900,
                          26.0),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 40),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    primary: true,

                    padding: EdgeInsets.symmetric(
                      vertical: cellMargin,
                      horizontal: cellMargin + _crossAxisSpacing,
                    ),
                    mainAxisSpacing: 15.0, // ช่องว่างแนวนอน
                    crossAxisSpacing: 15.0, // ช่องว่างแนวตั้ง
                    crossAxisCount: Responsive.isMobile(context)
                        ? 2
                        : Responsive.isTablet(context)
                            ? 4
                            : Responsive.isDesktop(context)
                                ? 6
                                : 3,
                    childAspectRatio: 0.7,

                    children: List.generate(
                      subListTopStar.length,
                      (index) {
                        // print("sizes===$mainCatWidth==$mainCatHeight--$_aspectRatio");
                        ExpertDetails _subCatModleTopStar =
                            subListTopStar[index];
                        return InkWell(
                          /*onTap: () {
                                  if (selectedFilterList != null &&
                                      selectedFilterList
                                          .contains(filterList[index])) {
                                    selectedFilterList.remove(filterList[index]);
                                  } else {
                                    selectedFilterList.add(filterList[index]);
                                  }
                                  setState(() {});
                                },*/

                          onTap: () {
                            sendDataToExpertDetailsPage(
                                _subCatModleTopStar.userProfileId.toString());
                          },
                          child: Container(
                            width: double.infinity,
                            height: cellHeight2,
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Container(
                                    // color: Colors.green,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // verticalDirection: VerticalDirection.down,
                                      // mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                height: 35,
                                                width: 100,
                                                padding: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                    color: ConstantData
                                                        .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight: Radius
                                                                .circular(30),
                                                            topLeft:
                                                                Radius.circular(
                                                                    7))),
                                                child: Center(
                                                  child: ConstantWidget
                                                      .getCustomText(
                                                          S
                                                                  .of(context)
                                                                  .topstar +
                                                              "  " +
                                                              addIndex(index),
                                                          ConstantData
                                                              .whiteColor,
                                                          1,
                                                          TextAlign.start,
                                                          FontWeight.normal,
                                                          ConstantWidget
                                                              .getPercentSize1(
                                                                  mainCatHeight,
                                                                  8)),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                padding: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                    color:
                                                        ConstantData.whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                /* child: _subCatModleTopStar
                                                            .userFavoriteUserId ==
                                                        int.parse(widget.userId)
                                                    ? IconButton(
                                                        icon: Icon(
                                                          Icons.favorite,
                                                        ),
                                                        iconSize: 20,
                                                        //  color: ConstantData.kGreyTextColor,
                                                        color: ConstantData
                                                            .redColor,
                                                        onPressed: () {},
                                                      )
                                                    : IconButton(
                                                        icon: Icon(
                                                          Icons
                                                              .favorite_border_outlined,
                                                        ),
                                                        iconSize: 20,
                                                        color: ConstantData
                                                            .kGreyTextColor,
                                                        // color: ConstantData.redColor,
                                                        onPressed: () {},
                                                      ),*/
                                                child: _subCatModleTopStar
                                                            .isFavorite ==
                                                        1
                                                    ? IconButton(
                                                        icon: Icon(
                                                          Icons.favorite,
                                                        ),
                                                        iconSize: 20,
                                                        //  color: ConstantData.kGreyTextColor,
                                                        color: ConstantData
                                                            .redColor,
                                                        onPressed: () {
                                                          toDeleteFavorite(
                                                              widget.userId
                                                                  .toString(),
                                                              _subCatModleTopStar
                                                                  .userProfileId
                                                                  .toString());

                                                          print(
                                                              'userFavoriteUserId กดไลค์แล้ว  ======> ');
                                                          print(widget.userId);
                                                          print(_subCatModleTopStar
                                                              .userProfileId);
                                                        },
                                                      )
                                                    : IconButton(
                                                        icon: Icon(
                                                          Icons
                                                              .favorite_border_outlined,
                                                        ),
                                                        iconSize: 20,
                                                        color: ConstantData
                                                            .kGreyTextColor,
                                                        // color: ConstantData.redColor,
                                                        onPressed: () {
                                                          toCreateFavorite(
                                                              widget.userId,
                                                              _subCatModleTopStar
                                                                  .userProfileId
                                                                  .toString());
                                                          print(
                                                              'userFavoriteUserId ยังไม่กดไลค์  ======> ');
                                                          print(widget.userId);
                                                          print(_subCatModleTopStar
                                                              .userProfileId);
                                                        },
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                height: 35,
                                                width: 45,
                                                padding: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                    color:
                                                        ConstantData.whiteColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0),
                                                            topLeft: Radius
                                                                .circular(0))),
                                                child: Center(
                                                  child: ConstantWidget
                                                      .getCustomText(
                                                          // "ชาย",

                                                          //"ชาย",
                                                          (_subCatModleTopStar
                                                                      .userProfileGender
                                                                      .toString() ==
                                                                  'm')
                                                              ? "ชาย"
                                                              : "หญิง",
                                                          ConstantData
                                                              .textColor,
                                                          1,
                                                          TextAlign.start,
                                                          FontWeight.bold,
                                                          ConstantWidget
                                                              .getPercentSize1(
                                                                  mainCatHeight,
                                                                  8)),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                height: 35,
                                                width: 80,
                                                padding: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                    color: ConstantData
                                                        .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight: Radius
                                                                .circular(0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    0))),
                                                child: Center(
                                                  child: ConstantWidget
                                                      .getCustomText(
                                                    // "฿ 20,000 ",
                                                    (_subCatModleTopStar
                                                                .userProfilePrice
                                                                .toString() !=
                                                            "0")
                                                        ? "฿ " +
                                                            _subCatModleTopStar
                                                                .userProfilePrice
                                                                .toString()
                                                        : "฿ ไม่ระบุ",

                                                    ConstantData.whiteColor,
                                                    1,
                                                    TextAlign.start,
                                                    FontWeight.normal,
                                                    /* ConstantWidget
                                                              .getPercentSize1(
                                                                  mainCatHeight,
                                                                  8),*/
                                                    ConstantWidget
                                                        .getPercentSize1(
                                                            cellHeight2, 25),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(7),
                                          topRight: Radius.circular(7)),
                                      color: ConstantData.whiteColor,
                                      border: Border.all(
                                          // color: Colors.blue,
                                          color: ConstantData.whiteColor,
                                          width: 1.0),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/no-image.png'
                                              /*ConstantData.assetsImagePath +
                                                _subCatModle.image[0],*/
                                              ),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: 2.5,
                                  child: Container(
                                    // height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(7),
                                          bottomRight: Radius.circular(7),
                                        ),
                                        color: ConstantData.whiteColor,
                                        border: Border.all(
                                            // color: Colors.yellow,
                                            color: ConstantData.whiteColor,
                                            width: 1.0)),
                                    //child: Text('Item ${index}'),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                        ),
                                        /* ConstantWidget.getSpace(
                                                        ConstantWidget.getPercentSize1(
                                                            mainCatHeight, 2.5)),*/

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: Row(
                                            children: [
                                              ConstantWidget.getCustomText(
                                                // _subCatModle.name,
                                                _subCatModleTopStar
                                                    .userProfileName,
                                                ConstantData.textColor,
                                                1,
                                                TextAlign.start,
                                                FontWeight.bold,
                                                ConstantWidget.getPercentSize1(
                                                    mainCatHeight, 8),
                                              ),
                                              ConstantWidget.getSpace1(),
                                              ConstantWidget.getCustomText(
                                                  // _subCatModle.province,

                                                  (_subCatModleTopStar.zoneName
                                                              .toString() !=
                                                          'null')
                                                      ? _subCatModleTopStar
                                                          .zoneName
                                                          .toString()
                                                      : "ไม่ระบุโซน",
                                                  ConstantData.textColor,
                                                  1,
                                                  TextAlign.start,
                                                  FontWeight.bold,
                                                  ConstantWidget
                                                      .getPercentSize1(
                                                          mainCatHeight, 8)),
                                            ],
                                          ),
                                        ),
                                        /* ConstantWidget.getSpace(
                                                          ConstantWidget
                                                              .getPercentSize1(
                                                                  mainCatHeight, 1.2)),*/
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: ConstantWidget.getCustomText(
                                            S.of(context).age +
                                                // _subCatModle.age.toString() +
                                                "30 " +
                                                S.of(context).year,
                                            // colorOrange,
                                            ConstantData.textColor,
                                            1,
                                            TextAlign.start,
                                            FontWeight.normal,
                                            ConstantWidget.getPercentSize1(
                                                mainCatHeight, 8),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: Row(
                                            children: [
                                              ConstantWidget.getSpace(
                                                  ConstantWidget
                                                      .getPercentSize1(
                                                          mainCatHeight, 1.2)),
                                              ConstantWidget.getCustomText(
                                                //  _subCatModle.expertName
                                                // .toString(),
                                                (_subCatModleTopStar
                                                            .userType2Name
                                                            .toString() !=
                                                        'null')
                                                    ? _subCatModleTopStar
                                                        .userType2Name
                                                        .toString()
                                                    : " ",

                                                // colorOrange,
                                                ConstantData.textColor,
                                                1,
                                                TextAlign.start,
                                                FontWeight.normal,
                                                ConstantWidget.getPercentSize1(
                                                    mainCatHeight, 8),
                                              ),
                                              ConstantWidget.getSpace1(),
                                              ConstantWidget.getCustomText(
                                                  // _subCatModle.reviewDesc,
                                                  "( " +
                                                      _subCatModleTopStar
                                                          .userProfileStarRate
                                                          .toString() +
                                                      " )",
                                                  ConstantData.textColor,
                                                  1,
                                                  TextAlign.center,
                                                  FontWeight.w100,
                                                  ConstantWidget.getPercentSize(
                                                      bottomRemainSize, 9)),
                                              Icon(
                                                Icons.star,
                                                color: _subCatModleTopStar
                                                            .userProfileStarRate >
                                                        0
                                                    ? Colors.amber
                                                    : ConstantData
                                                        .kGreyTextColor,
                                                size: 16,
                                              ),
                                              Icon(
                                                Icons.check_circle,
                                                color: _subCatModleTopStar
                                                            .userProfileIsConfirmImage ==
                                                        1
                                                    ? Colors.green
                                                    : ConstantData
                                                        .kGreyTextColor,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(child: Divider()),

                      // Expanded(child: Divider()),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ConstantWidget.getCustomTextWithoutAlign(
                          //'Top Expert',
                          S.of(context).youfavorite,
                          // Colors.black,
                          ConstantData.primaryColor,
                          FontWeight.w900,
                          26.0),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 40),
                  ),
                  //สร้างการ์ด Favorite
                  subListFavorite.length > 0
                      ? GridView.count(
                          //สรางการ์ด Expert
                          shrinkWrap: true,
                          primary: true,

                          padding: EdgeInsets.symmetric(
                            vertical: cellMargin,
                            horizontal: cellMargin + _crossAxisSpacing,
                          ),
                          mainAxisSpacing: 15.0, // ช่องว่างแนวนอน
                          crossAxisSpacing: 15.0, // ช่องว่างแนวตั้ง
                          crossAxisCount: Responsive.isMobile(context)
                              ? 2
                              : Responsive.isTablet(context)
                                  ? 4
                                  : Responsive.isDesktop(context)
                                      ? 6
                                      : 3,
                          childAspectRatio: 0.7,

                          children: List.generate(
                            subListFavorite.length,
                            (index) {
                              // print("sizes===$mainCatWidth==$mainCatHeight--$_aspectRatio");
                              // ExpertModel _subCatModle = subList[index];
                              ExpertDetails _subCatModleFavorite =
                                  subListFavorite[index];

                              return InkWell(
                                onTap: () {
                                  /* Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ExpertDetailPage(chooseExpertlist: chooseExpertlist)));*/

                                  sendDataToExpertDetailsPage(
                                      _subCatModleFavorite.userProfileId
                                          .toString());
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: cellHeight2,
                                  child: Column(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1.0,
                                        child: Container(
                                          // color: Colors.green,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            // verticalDirection: VerticalDirection.down,
                                            // mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  padding: EdgeInsets.all(0),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ConstantData.whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  /* child: Icon(
                                                    Icons.favorite_border_rounded,
                                                    color: Colors.white,
                                                  ),*/
                                                  /*child: _subCatModleFavorite
                                                              .userFavoriteUserId ==
                                                          int.parse(
                                                              widget.userId)
                                                      ? IconButton(
                                                          icon: Icon(
                                                            Icons.favorite,
                                                          ),
                                                          iconSize: 20,
                                                          //  color: ConstantData.kGreyTextColor,
                                                          color: ConstantData
                                                              .redColor,
                                                          onPressed: () {},
                                                        )
                                                      : IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .favorite_border_outlined,
                                                          ),
                                                          iconSize: 20,
                                                          color: ConstantData
                                                              .kGreyTextColor,
                                                          // color: ConstantData.redColor,
                                                          onPressed: () {},
                                                        ),*/

                                                  child: _subCatModleFavorite
                                                              .isFavorite ==
                                                          1
                                                      ? IconButton(
                                                          icon: Icon(
                                                            Icons.favorite,
                                                          ),
                                                          iconSize: 20,
                                                          //  color: ConstantData.kGreyTextColor,
                                                          color: ConstantData
                                                              .redColor,
                                                          onPressed: () {
                                                            toDeleteFavorite(
                                                                widget.userId
                                                                    .toString(),
                                                                _subCatModleFavorite
                                                                    .userProfileId
                                                                    .toString());

                                                            print(
                                                                'userFavoriteUserId กดไลค์แล้ว  ======> ');
                                                            print(
                                                                widget.userId);
                                                            print(_subCatModleFavorite
                                                                .userProfileId);
                                                          },
                                                        )
                                                      : IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .favorite_border_outlined,
                                                          ),
                                                          iconSize: 20,
                                                          color: ConstantData
                                                              .kGreyTextColor,
                                                          // color: ConstantData.redColor,
                                                          onPressed: () {
                                                            toCreateFavorite(
                                                                widget.userId,
                                                                _subCatModleFavorite
                                                                    .userProfileId
                                                                    .toString());
                                                            print(
                                                                'userFavoriteUserId ยังไม่กดไลค์  ======> ');
                                                            print(
                                                                widget.userId);
                                                            print(_subCatModleFavorite
                                                                .userProfileId);
                                                          },
                                                        ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Container(
                                                      height: 35,
                                                      width: 45,
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      decoration: BoxDecoration(
                                                          color: ConstantData
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomRight:
                                                                      Radius
                                                                          .circular(
                                                                              0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          0))),
                                                      child: Center(
                                                        child: ConstantWidget
                                                            .getCustomText(
                                                          //"ชาย",
                                                          (_subCatModleFavorite
                                                                      .userProfileGender
                                                                      .toString() ==
                                                                  'm')
                                                              ? "ชาย"
                                                              : "หญิง",
                                                          ConstantData
                                                              .textColor,
                                                          1,
                                                          TextAlign.start,
                                                          FontWeight.bold,
                                                          ConstantWidget
                                                              .getPercentSize1(
                                                                  cellHeight2,
                                                                  25),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Container(
                                                      height: 35,
                                                      width: 80,
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      decoration: BoxDecoration(
                                                          color: ConstantData
                                                              .primaryColor,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomRight:
                                                                      Radius
                                                                          .circular(
                                                                              0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          0))),
                                                      child: Center(
                                                        child: ConstantWidget
                                                            .getCustomText(
                                                          // "฿ 20,000 ",
                                                          (_subCatModleFavorite
                                                                      .userProfilePrice
                                                                      .toString() !=
                                                                  "0")
                                                              ? "฿ " +
                                                                  _subCatModleFavorite
                                                                      .userProfilePrice
                                                                      .toString()
                                                              : "฿ ไม่ระบุ",

                                                          ConstantData
                                                              .whiteColor,
                                                          1,
                                                          TextAlign.start,
                                                          FontWeight.normal,
                                                          /* ConstantWidget
                                                              .getPercentSize1(
                                                                  mainCatHeight,
                                                                  8),*/
                                                          ConstantWidget
                                                              .getPercentSize1(
                                                                  cellHeight2,
                                                                  25),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(7),
                                                topRight: Radius.circular(7)),
                                            color: ConstantData.whiteColor,
                                            border: Border.all(
                                                // color: Colors.blue,
                                                color: ConstantData.whiteColor,
                                                width: 1.0),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/no-image.png'
                                                    /* ConstantData.assetsImagePath +
                                                _subCatModle.image[0],*/
                                                    ),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      AspectRatio(
                                        aspectRatio: 2.5,
                                        child: Container(
                                          // height: 150,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(7),
                                                bottomRight: Radius.circular(7),
                                              ),
                                              color: ConstantData.whiteColor,
                                              border: Border.all(
                                                  // color: Colors.yellow,
                                                  color:
                                                      ConstantData.whiteColor,
                                                  width: 1.0)),
                                          //child: Text('Item ${index}'),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 10),
                                              ),
                                              /* ConstantWidget.getSpace(
                                                        ConstantWidget.getPercentSize1(
                                                            mainCatHeight, 2.5)),*/

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, right: 4),
                                                child: Row(
                                                  children: [
                                                    ConstantWidget
                                                        .getCustomText(
                                                      // _subCatModle.name,
                                                      _subCatModleFavorite
                                                          .userProfileName,
                                                      ConstantData.textColor,
                                                      1,
                                                      TextAlign.start,
                                                      FontWeight.bold,
                                                      ConstantWidget
                                                          .getPercentSize1(
                                                              mainCatHeight, 8),
                                                    ),
                                                    ConstantWidget.getSpace1(),
                                                    ConstantWidget
                                                        .getCustomText(
                                                            // _subCatModle.province,
                                                            (_subCatModleFavorite
                                                                        .zoneName
                                                                        .toString() !=
                                                                    'null')
                                                                ? _subCatModleFavorite
                                                                    .zoneName
                                                                    .toString()
                                                                : "ไม่ระบุโซน",
                                                            ConstantData
                                                                .textColor,
                                                            1,
                                                            TextAlign.start,
                                                            FontWeight.bold,
                                                            ConstantWidget
                                                                .getPercentSize1(
                                                                    mainCatHeight,
                                                                    8)),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, right: 4),
                                                child: Row(
                                                  children: [
                                                    ConstantWidget
                                                        .getCustomText(
                                                      S.of(context).age +
                                                          // _subCatModle.age.toString() +
                                                          "30 " +
                                                          /*calculateAge(_subCatModle
                                                              .userProfileBirthDate
                                                              .toString()) +*/
                                                          S.of(context).year,
                                                      // colorOrange,
                                                      ConstantData.textColor,
                                                      1,
                                                      TextAlign.start,
                                                      FontWeight.normal,
                                                      ConstantWidget
                                                          .getPercentSize1(
                                                              mainCatHeight, 8),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, right: 4),
                                                child: Row(
                                                  children: [
                                                    ConstantWidget.getSpace(
                                                        ConstantWidget
                                                            .getPercentSize1(
                                                                mainCatHeight,
                                                                1.2)),
                                                    ConstantWidget
                                                        .getCustomText(
                                                      // _subCatModle.expertName
                                                      //"อาชีพ",
                                                      (_subCatModleFavorite
                                                                  .userType2Name
                                                                  .toString() !=
                                                              'null')
                                                          ? _subCatModleFavorite
                                                              .userType2Name
                                                              .toString()
                                                          : " ",

                                                      // colorOrange,
                                                      // _subCatModle.userType2Name.toString(),
                                                      ConstantData.textColor,
                                                      1,
                                                      TextAlign.start,
                                                      FontWeight.normal,
                                                      ConstantWidget
                                                          .getPercentSize1(
                                                              mainCatHeight, 8),
                                                    ),
                                                    ConstantWidget.getSpace1(),
                                                    ConstantWidget.getCustomText(
                                                        "( " +
                                                            _subCatModleFavorite
                                                                .userProfileStarRate
                                                                .toString() +
                                                            " )",
                                                        ConstantData.textColor,
                                                        1,
                                                        TextAlign.center,
                                                        FontWeight.w100,
                                                        ConstantWidget
                                                            .getPercentSize(
                                                                bottomRemainSize,
                                                                9)),
                                                    Icon(
                                                      Icons.star,
                                                      color: _subCatModleFavorite
                                                                  .userProfileStarRate >
                                                              0
                                                          ? Colors.amber
                                                          : ConstantData
                                                              .kGreyTextColor,
                                                      size: 16,
                                                    ),
                                                    Icon(
                                                      Icons.check_circle,
                                                      color: _subCatModleFavorite
                                                                  .userProfileIsConfirmImage ==
                                                              1
                                                          ? Colors.green
                                                          : ConstantData
                                                              .kGreyTextColor,
                                                      size: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: ConstantWidget.getCustomTextWithoutAlign(
                              // S.of(context).favorite,
                              // Colors.black,
                              'ไม่คนที่คุณถูกใจไว้',
                              ConstantData.primaryColor,
                              FontWeight.normal,
                              18.0),
                        ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(child: Divider()),

                      // Expanded(child: Divider()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ConstantWidget.getCustomTextWithoutAlign(
                          S.of(context).allexpert,
                          // Colors.black,
                          ConstantData.primaryColor,
                          FontWeight.w900,
                          26.0),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  GridView.count(
                    //สรางการ์ด Expert
                    shrinkWrap: true,
                    primary: true,

                    padding: EdgeInsets.symmetric(
                      vertical: cellMargin,
                      horizontal: cellMargin + _crossAxisSpacing,
                    ),
                    mainAxisSpacing: 15.0, // ช่องว่างแนวนอน
                    crossAxisSpacing: 15.0, // ช่องว่างแนวตั้ง
                    crossAxisCount: Responsive.isMobile(context)
                        ? 2
                        : Responsive.isTablet(context)
                            ? 4
                            : Responsive.isDesktop(context)
                                ? 6
                                : 3,
                    childAspectRatio: 0.7,

                    children: List.generate(
                      subList.length,
                      (index) {
                        // print("sizes===$mainCatWidth==$mainCatHeight--$_aspectRatio");
                        // ExpertModel _subCatModle = subList[index];
                        ExpertDetails _subCatModle = subList[index];

                        return InkWell(
                          /*onTap: () {
                            if (selectedFilterList != null &&
                                selectedFilterList
                                    .contains(filterList[index])) {
                              selectedFilterList.remove(filterList[index]);
                            } else {
                              selectedFilterList
                                  .add(filterList[index].toString());
                              print(selectedFilterList);
                            }
                            setState(() {});
                          },*/
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ExpertDetailPage(
                                            chooseExpertlist:
                                                chooseExpertlist)));
                          },
                          child: Container(
                            width: double.infinity,
                            height: cellHeight2,
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Container(
                                    // color: Colors.green,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // verticalDirection: VerticalDirection.down,
                                      // mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            padding: EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                              color: ConstantData.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            /* child: Icon(
                                                    Icons.favorite_border_rounded,
                                                    color: Colors.white,
                                                  ),*/
                                            /* child: _subCatModle
                                                        .userFavoriteUserId ==
                                                    int.parse(widget.userId)
                                                ? IconButton(
                                                    icon: Icon(
                                                      Icons.favorite,
                                                    ),
                                                    iconSize: 20,
                                                    //  color: ConstantData.kGreyTextColor,
                                                    color:
                                                        ConstantData.redColor,
                                                    onPressed: () {
                                                      toDeleteFavorite(
                                                          _subCatModle
                                                              .userFavoriteUserId
                                                              .toString(),
                                                          _subCatModle
                                                              .userFavoriteUserProfileTargetId
                                                              .toString(),
                                                          _subCatModle
                                                              .userFavoriteId
                                                              .toString());

                                                      print(
                                                          'userFavoriteUserId กดไลค์แล้ว  ======> ');
                                                      print(_subCatModle
                                                          .userFavoriteUserId);
                                                      print(_subCatModle
                                                          .userFavoriteId);
                                                    },
                                                  )
                                                : IconButton(
                                                    icon: Icon(
                                                      Icons
                                                          .favorite_border_outlined,
                                                    ),
                                                    iconSize: 20,
                                                    color: ConstantData
                                                        .kGreyTextColor,
                                                    // color: ConstantData.redColor,
                                                    onPressed: () {
                                                      toCreateFavorite(
                                                          widget.userId,
                                                          _subCatModle
                                                              .userProfileId
                                                              .toString());
                                                      print(
                                                          'userFavoriteUserId ยังไม่กดไลค์  ======> ');
                                                      print(widget.userId);
                                                      print(_subCatModle
                                                          .userProfileId);
                                                    },
                                                  ),*/

                                            child: _subCatModle.isFavorite == 1
                                                ? IconButton(
                                                    icon: Icon(
                                                      Icons.favorite,
                                                    ),
                                                    iconSize: 20,
                                                    //  color: ConstantData.kGreyTextColor,
                                                    color:
                                                        ConstantData.redColor,
                                                    onPressed: () {
                                                      toDeleteFavorite(
                                                          widget.userId
                                                              .toString(),
                                                          _subCatModle
                                                              .userProfileId
                                                              .toString());

                                                      print(
                                                          'userFavoriteUserId กดไลค์แล้ว  ======> ');
                                                      print(widget.userId);
                                                      print(_subCatModle
                                                          .userProfileId);
                                                    },
                                                  )
                                                : IconButton(
                                                    icon: Icon(
                                                      Icons
                                                          .favorite_border_outlined,
                                                    ),
                                                    iconSize: 20,
                                                    color: ConstantData
                                                        .kGreyTextColor,
                                                    // color: ConstantData.redColor,
                                                    onPressed: () {
                                                      toCreateFavorite(
                                                          widget.userId,
                                                          _subCatModle
                                                              .userProfileId
                                                              .toString());
                                                      print(
                                                          'userFavoriteUserId ยังไม่กดไลค์  ======> ');
                                                      print(widget.userId);
                                                      print(_subCatModle
                                                          .userProfileId);
                                                    },
                                                  ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                height: 35,
                                                width: 45,
                                                padding: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                    color:
                                                        ConstantData.whiteColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0),
                                                            topLeft: Radius
                                                                .circular(0))),
                                                child: Center(
                                                  child: ConstantWidget
                                                      .getCustomText(
                                                    //"ชาย",
                                                    (_subCatModle
                                                                .userProfileGender
                                                                .toString() ==
                                                            'm')
                                                        ? "ชาย"
                                                        : "หญิง",
                                                    ConstantData.textColor,
                                                    1,
                                                    TextAlign.start,
                                                    FontWeight.bold,
                                                    ConstantWidget
                                                        .getPercentSize1(
                                                            cellHeight2, 25),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                height: 35,
                                                width: 80,
                                                padding: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                    color: ConstantData
                                                        .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight: Radius
                                                                .circular(0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    0))),
                                                child: Center(
                                                  child: ConstantWidget
                                                      .getCustomText(
                                                    // "฿ 20,000 ",
                                                    (_subCatModle
                                                                .userProfilePrice
                                                                .toString() !=
                                                            "0")
                                                        ? "฿ " +
                                                            _subCatModle
                                                                .userProfilePrice
                                                                .toString()
                                                        : "฿ ไม่ระบุ",

                                                    ConstantData.whiteColor,
                                                    1,
                                                    TextAlign.start,
                                                    FontWeight.normal,
                                                    /* ConstantWidget
                                                              .getPercentSize1(
                                                                  mainCatHeight,
                                                                  8),*/
                                                    ConstantWidget
                                                        .getPercentSize1(
                                                            cellHeight2, 25),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(7),
                                          topRight: Radius.circular(7)),
                                      color: ConstantData.whiteColor,
                                      border: Border.all(
                                          // color: Colors.blue,
                                          color: ConstantData.whiteColor,
                                          width: 1.0),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/no-image.png'
                                              /* ConstantData.assetsImagePath +
                                                _subCatModle.image[0],*/
                                              ),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: 2.5,
                                  child: Container(
                                    // height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(7),
                                          bottomRight: Radius.circular(7),
                                        ),
                                        color: ConstantData.whiteColor,
                                        border: Border.all(
                                            // color: Colors.yellow,
                                            color: ConstantData.whiteColor,
                                            width: 1.0)),
                                    //child: Text('Item ${index}'),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                        ),
                                        /* ConstantWidget.getSpace(
                                                        ConstantWidget.getPercentSize1(
                                                            mainCatHeight, 2.5)),*/

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: Row(
                                            children: [
                                              ConstantWidget.getCustomText(
                                                // _subCatModle.name,
                                                _subCatModle.userProfileName,
                                                ConstantData.textColor,
                                                1,
                                                TextAlign.start,
                                                FontWeight.bold,
                                                ConstantWidget.getPercentSize1(
                                                    mainCatHeight, 8),
                                              ),
                                              ConstantWidget.getSpace1(),
                                              ConstantWidget.getCustomText(
                                                  // _subCatModle.province,
                                                  (_subCatModle.zoneName
                                                              .toString() !=
                                                          'null')
                                                      ? _subCatModle.zoneName
                                                          .toString()
                                                      : "ไม่ระบุโซน",
                                                  ConstantData.textColor,
                                                  1,
                                                  TextAlign.start,
                                                  FontWeight.bold,
                                                  ConstantWidget
                                                      .getPercentSize1(
                                                          mainCatHeight, 8)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: Row(
                                            children: [
                                              ConstantWidget.getCustomText(
                                                S.of(context).age +
                                                    // _subCatModle.age.toString() +
                                                    "30 " +
                                                    /*calculateAge(_subCatModle
                                                              .userProfileBirthDate
                                                              .toString()) +*/
                                                    S.of(context).year,
                                                // colorOrange,
                                                ConstantData.textColor,
                                                1,
                                                TextAlign.start,
                                                FontWeight.normal,
                                                ConstantWidget.getPercentSize1(
                                                    mainCatHeight, 8),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: Row(
                                            children: [
                                              ConstantWidget.getSpace(
                                                  ConstantWidget
                                                      .getPercentSize1(
                                                          mainCatHeight, 1.2)),
                                              ConstantWidget.getCustomText(
                                                // _subCatModle.expertName
                                                //"อาชีพ",
                                                (_subCatModle.userType2Name
                                                            .toString() !=
                                                        'null')
                                                    ? _subCatModle.userType2Name
                                                        .toString()
                                                    : " ",

                                                // colorOrange,
                                                // _subCatModle.userType2Name.toString(),
                                                ConstantData.textColor,
                                                1,
                                                TextAlign.start,
                                                FontWeight.normal,
                                                ConstantWidget.getPercentSize1(
                                                    mainCatHeight, 8),
                                              ),
                                              ConstantWidget.getSpace1(),
                                              ConstantWidget.getCustomText(
                                                  // _subCatModle.reviewDesc,
                                                  "( " +
                                                      _subCatModle
                                                          .userProfileStarRate
                                                          .toString() +
                                                      " )",
                                                  ConstantData.textColor,
                                                  1,
                                                  TextAlign.center,
                                                  FontWeight.w100,
                                                  ConstantWidget.getPercentSize(
                                                      bottomRemainSize, 9)),
                                              Icon(
                                                Icons.star,
                                                color: _subCatModle
                                                            .userProfileStarRate >
                                                        0
                                                    ? Colors.amber
                                                    : ConstantData
                                                        .kGreyTextColor,
                                                size: 16,
                                              ),
                                              Icon(
                                                Icons.check_circle,
                                                color: _subCatModle
                                                            .userProfileIsConfirmImage ==
                                                        1
                                                    ? Colors.green
                                                    : ConstantData
                                                        .kGreyTextColor,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Expanded(child: Divider()),
                      Text('© metex')

                      // Expanded(child: Divider()),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                  ),
                ],
              ),
            )),
      ),
      onWillPop: _requestPop,
      /* onWillPop: () async {
            return false;
          }*/
    );
  }
}

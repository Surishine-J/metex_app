import 'package:flutter/material.dart';
import 'package:metex_app/data/data.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/experts_model.dart';
import 'package:metex_app/models/models.dart';
import 'package:metex_app/models/search_all_response_model.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/utils/utils.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class SearchResultPage extends StatefulWidget {
  
  late String search ;
  late int type2 = 0;
  late int can_team_building = 0;
  late int can_leadership = 0;
  late int can_communication = 0;
  late int can_performance_management = 0;
  late int can_career_growth = 0;
  late int can_mind_set = 0;
  late int can_unn_unn = 0;
  late int zone_id = 0;
  SearchResultPage({
    Key? key,
    required this.search,
    required this.type2,
    required this.can_team_building,
    required this.can_leadership,
    required this.can_communication,
    required this.can_performance_management,
    required this.can_career_growth,
    required this.can_mind_set,
    required this.can_unn_unn,
    required this.zone_id,
  }) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  List<List<ExpertModel>> allCatList = [DataFile.getAllExpertModel()];
//  List<SubCategoryModel> subList = [];
  //List<ExpertModel> subList = [];
  List<ExpertDetails> subList = [];
  List<String> selectionList = [
    "Coach",
    "Trainer",
    "Consultant",
  ];
  List<ExpertDetails> allExpertlist = [];
   List<ExpertDetails> filtterExpertlist = [];

  //List<ExpertDetails> coachList = [];
  //List<ExpertDetails> trainerList = [];
  //List<ExpertDetails> consultantList = [];

  getDataExpertAll() async {
    var data = {
      "search": widget.search,
      "type2": widget.type2,
      "can_team_building": widget.can_team_building,
      "can_leadership": widget.can_leadership,
      "can_communication": widget.can_communication,
      "can_performance_management": widget.can_performance_management,
      "can_career_growth": widget.can_career_growth,
      "can_mind_set": widget.can_mind_set,
      "can_unn_unn": widget.can_unn_unn,
      "zone_id": widget.zone_id
    };
    Uri url = Uri.parse('http://127.0.0.1:3000/api/user/search/all');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
       body: convert.jsonEncode(data)
    );
     print(data);
    // print('get expert all' + " " + response.statusCode.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      final SearchAllResponse searchModel =
          SearchAllResponse.fromJson(convert.jsonDecode(response.body));

      setState(() {
        allExpertlist = searchModel.data.expertdetails.toList();
        /*if(){

        }*/

        /* coachList = allExpertlist
            .where((element) => element.userProfileType2 == 1)
            .toList();
        trainerList = allExpertlist
            .where((element) => element.userProfileType2 == 2)
            .toList();
        consultantList = allExpertlist
            .where((element) => element.userProfileType2 == 3)
            .toList();*/

        //print(careerTypeModel.data[0].user_type2_name);
      });
    } else {
      print('Error getDataExpertAll');
    }
  }

  int selectedPos = 0;

  // TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getDataExpertAll();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    subList = [];
    // subList = allCatList[selectedPos];
    subList = allExpertlist;
    var cellHeight = SizeConfig.safeBlockHorizontal! * 58;

    double cellMargin = 7;

    var _crossAxisSpacing = 8.0;

    var bottomDialogTextSizeFilter = SizeConfig.safeBlockVertical! * 55;
    var cellHeight2 =
        ConstantWidget.getPercentSize1(bottomDialogTextSizeFilter, 13);
    var _screenWidth = MediaQuery.of(context).size.width;

    var _crossAxisCount = 2;

    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    var _aspectRatio = _width / cellHeight;

    // double editTextHeight = MediaQuery.of(context).size.height * 0.06;
    double mainCatWidth = (SizeConfig.safeBlockHorizontal! * 50) -
        (cellMargin * 2 + _crossAxisSpacing);
    double mainCatHeight = cellHeight;
    double topCellHeight = ConstantWidget.getPercentSize(cellHeight, 12);
    double imageSize = SizeConfig.safeBlockVertical! * 6.5;
    double bottomRemainSize = cellHeight - imageSize - topCellHeight;

    return WillPopScope(
      onWillPop: _requestPop,
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
              child: allExpertlist.length == 0
                  ? Center(
                      child: CircularProgressIndicator(
                        semanticsLabel: "กรุณารอสักครู",
                      ),
                      /*child: Center(child: Text('ไม่พบข้อมูล')),*/
                    )
                  : new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                        ),
                        Container(
                          child: ConstantWidget.getCustomTextWithoutAlign(
                              // S.of(context).fav,
                              "พบ  " + subList.length.toString() + "  คน",
                              // Colors.black,
                              ConstantData.primaryColor,
                              FontWeight.w900,
                              26.0),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          primary: true,
                          /* mainAxisSpacing: _crossAxisSpacing2,
                      padding: EdgeInsets.symmetric(
                          vertical: cellMargin2,
                          horizontal: cellMargin2 + _crossAxisSpacing2),
                      crossAxisCount: 4, //_crossAxisCount2,
                      crossAxisSpacing: _crossAxisSpacing2,
                      childAspectRatio: _aspectRatio2,*/
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
                              // print( "sizes===$mainCatWidth==$mainCatHeight--$_aspectRatio");
                              ExpertDetails _subCatModle = subList[index];
                              /* return InkWell(
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
                          child: Container(
                            width: double.infinity,
                            height: cellHeight2,
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Container(
                                    // color: Colors.green,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        padding: EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                            color: ConstantData.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        /* child: Icon(
                                            Icons.favorite_border_rounded,
                                            color: Colors.white,
                                          ),*/
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.favorite_border_rounded,
                                          ),
                                          iconSize: 20,
                                          color: ConstantData.kGreyTextColor,
                                          onPressed: () {},
                                        ),
                                      ),
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
                                             'assets/images/no-image.jpg'
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
                                        Row(
                                          children: [
                                            ConstantWidget.getCustomText(
                                              //_subCatModle.gender,
                                              _subCatModle.userProfileGender,
                                              ConstantData.textColor,
                                              1,
                                              TextAlign.start,
                                              FontWeight.bold,
                                              ConstantWidget.getPercentSize1(
                                                  mainCatHeight, 8),
                                            ),
                                            ConstantWidget.getSpace1(),
                                            ConstantWidget.getCustomText(
                                               // _subCatModle.salary + " " + "฿",
                                               _subCatModle.userProfilePrice.toString()
                                                ConstantData.textColor,
                                                1,
                                                TextAlign.start,
                                                FontWeight.bold,
                                                ConstantWidget.getPercentSize1(
                                                    mainCatHeight, 8)),
                                          ],
                                        ),
                                        /* Padding(
                                            padding: EdgeInsets.only(bottom: 20),
                                          ),*/
                                        /* ConstantWidget.getSpace(
                                                        ConstantWidget.getPercentSize1(
                                                            mainCatHeight, 2.5)),*/
                                        Row(
                                          children: [
                                            ConstantWidget.getCustomText(
                                              _subCatModle.name,
                                              ConstantData.textColor,
                                              1,
                                              TextAlign.start,
                                              FontWeight.bold,
                                              ConstantWidget.getPercentSize1(
                                                  mainCatHeight, 8),
                                            ),
                                            ConstantWidget.getSpace1(),
                                            ConstantWidget.getCustomText(
                                                _subCatModle.province,
                                                ConstantData.textColor,
                                                1,
                                                TextAlign.start,
                                                FontWeight.bold,
                                                ConstantWidget.getPercentSize1(
                                                    mainCatHeight, 8)),
                                          ],
                                        ),
                                        /* ConstantWidget.getSpace(
                                                          ConstantWidget
                                                              .getPercentSize1(
                                                                  mainCatHeight, 1.2)),*/
                                        ConstantWidget.getCustomText(
                                          S.of(context).age +
                                              _subCatModle.age.toString() +
                                              S.of(context).year,
                                          // colorOrange,
                                          ConstantData.textColor,
                                          1,
                                          TextAlign.start,
                                          FontWeight.normal,
                                          ConstantWidget.getPercentSize1(
                                              mainCatHeight, 8),
                                        ),
                                        Row(
                                          children: [
                                            ConstantWidget.getSpace(
                                                ConstantWidget.getPercentSize1(
                                                    mainCatHeight, 1.2)),
                                            ConstantWidget.getCustomText(
                                              _subCatModle.expertName
                                                  .toString(),

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
                                                _subCatModle.reviewDesc,
                                                ConstantData.textColor,
                                                1,
                                                TextAlign.center,
                                                FontWeight.w100,
                                                ConstantWidget.getPercentSize(
                                                    bottomRemainSize, 9)),
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 16,
                                            ),
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      
                      */

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
                                              ExpertDetailPage()));
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
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons
                                                          .favorite_border_rounded,
                                                    ),
                                                    iconSize: 20,
                                                    color: ConstantData
                                                        .kGreyTextColor,
                                                    onPressed: () {},
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
                                                          (_subCatModle
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
                                                          (_subCatModle
                                                                      .userProfilePrice
                                                                      .toString() !=
                                                                  "0")
                                                              ? "฿ " +
                                                                  _subCatModle
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
                                                      _subCatModle
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
                                                            (_subCatModle
                                                                        .zoneName
                                                                        .toString() !=
                                                                    'null')
                                                                ? _subCatModle
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
                                                          "อายุ" +
                                                          // _subCatModle.userProfileBirthDate.toString()+
                                                          /*  _subCatModle
                                                                      .userProfileBirthDate
                                                                      .toString() !=
                                                              'null'
                                                          ? calAge(_subCatModle
                                                              .userProfileBirthDate
                                                              .toString())
                                                          : " - " +*/
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
                                                      (_subCatModle
                                                                  .userType2Name
                                                                  .toString() !=
                                                              'null')
                                                          ? _subCatModle
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
                                                    ConstantWidget
                                                        .getCustomText(
                                                            // _subCatModle.reviewDesc,
                                                            "รีวิวสักอย่าง",
                                                            /* convertToDouble(_subCatModle
                                                            .userProfileStarRate),*/

                                                            // ( _subCatModle.userProfileStarRate.toDouble()).toString(),
                                                            // (double.parse(_subCatModle.userProfileStarRate.toString())).toString(),
                                                            ConstantData
                                                                .textColor,
                                                            1,
                                                            TextAlign.center,
                                                            FontWeight.w100,
                                                            ConstantWidget
                                                                .getPercentSize(
                                                                    bottomRemainSize,
                                                                    9)),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      size: 16,
                                                    ),
                                                    Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green,
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:metex_app/data/data.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/experts_model.dart';
import 'package:metex_app/models/models.dart';
import 'package:metex_app/models/search_all_response_model.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/services/config.dart';

import 'package:metex_app/utils/utils.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class SearchResultPage extends StatefulWidget {
 
  SearchResultPage({
    Key? key,
    
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
  List<ExpertDetails> chooseExpertlist = [];

  var search;
  var type2;


  checkFiltterSelect() {
   

  }

  getDataExpertAll() async {
    var data = {
      "user_id": null,
      "search": search,
      "type2": type2,   
      
    };
    Uri url = Uri.parse(Config.BASE_URL + '/api/user/search/all');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(data));
    print(data);
    // print('get expert all' + " " + response.statusCode.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      final SearchAllResponse searchModel =
          SearchAllResponse.fromJson(convert.jsonDecode(response.body));

      setState(() {
        allExpertlist = searchModel.data.expertdetails
            .where((element) => element.userProfileType == 'u')
            .toList();
      });
    } else {
      print('Error getDataExpertAll');
    }
  }

  sendDataToExpertDetailsPage(String user_profile_id) {
  //  print('user_profile_id =======>' + user_profile_id);
    setState(() {
      chooseExpertlist = allExpertlist
          .where(
              (element) => element.userProfileId == int.parse(user_profile_id))
          .toList();

     // print('chooseExpertlist ===== >' + chooseExpertlist.length.toString());

      if (chooseExpertlist.length > 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    ExpertDetailPage(chooseExpertlist: chooseExpertlist)));
      }
    });
  }

  int selectedPos = 0;

  // TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    //checkFiltterSelect();
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
                        semanticsLabel: "???????????????????????????????????????",
                      ),
                      /*child: Center(child: Text('?????????????????????????????????')),*/
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
                              "??????  " + subList.length.toString() + "  ??????",
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
                          mainAxisSpacing: 15.0, // ??????????????????????????????????????????
                          crossAxisSpacing: 15.0, // ?????????????????????????????????????????????
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
                            return InkWell(
                                onTap: () {
                                  sendDataToExpertDetailsPage(
                                      _subCatModle.userProfileId.toString());
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
                                                          //"?????????",
                                                          _subCatModle.gender,

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
                                                          // "??? 20,000 ",
                                                          _subCatModle
                                                                      .userProfilePrice
                                                                      .toString() ,
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
                                           /* image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/no-image.png'
                                                    /* ConstantData.assetsImagePath +
                                                _subCatModle.image[0],*/
                                                    ),
                                                fit: BoxFit.cover),*/

                                                 image: _subCatModle.userProfileImage ==
                                                  '0'
                                              ? DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/no-image.png'),
                                                  fit: BoxFit.cover)
                                              : DecorationImage(
                                                  image: NetworkImage(Config
                                                          .BASE_URL +
                                                      '/public/uploads/user-profile/' +
                                                      _subCatModle.userProfileId
                                                          .toString() +
                                                      '/' +
                                                      _subCatModle
                                                          .userProfileImage),
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
                                                                : "??????????????????????????????",
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

                                                      _subCatModle.age.toString() +
                                                        
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
                                                          _subCatModle.userType2Name,
                                                   

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
                                                            _subCatModle
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
                                                   
                                                      color: _subCatModle
                                                                .userProfileIsTopStar == 1
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
                            Text('?? metex')

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

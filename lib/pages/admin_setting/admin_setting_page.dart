import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:metex_app/data/data.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/experts_model.dart';
import 'package:metex_app/models/models.dart';
import 'package:metex_app/models/search_all_response_model.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AdminSettingPage extends StatefulWidget {
  AdminSettingPage({Key? key}) : super(key: key);

  @override
  _AdminSettingPageState createState() => _AdminSettingPageState();
}

class _AdminSettingPageState extends State<AdminSettingPage> {
  List<ExpertDetails> allExpertlist = [];
  List<ExpertDetails> subList = [];
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    //  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return new Future.value(false);
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
    "ทั้งหมด",
    "เบียร์",
    "ไวน์",
    "สุรา",
    "น้ำดื่ม",
    // "บรั่นดี",
    // "วอดก้า"
  ];
  getDataExpertAll() async {
    var response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/user/search/all'),
    );
    // print('get expert all' + " " + response.statusCode.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      final SearchAllResponse searchModel =
          SearchAllResponse.fromJson(convert.jsonDecode(response.body));

      setState(() {
        allExpertlist = searchModel.data.expertdetails;
      });
    } else {
      print('Error getDataExpertAll');
    }
  }

  getDataAdmin() async {
    var response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/admin/login'),
    );
    // print('get expert all' + " " + response.statusCode.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      final SearchAllResponse searchModel =
          SearchAllResponse.fromJson(convert.jsonDecode(response.body));

      setState(() {
        //allExpertlist = searchModel.data.expertdetails;
        allExpertlist = searchModel.data.expertdetails;
      });
    } else {
      print('Error getDataExpertAll');
    }
  }

  int selectedPos = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataExpertAll();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    subList = [];
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
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  InkWell(
                    child: Container(
                      //  margin: EdgeInsets.only(top: 20),
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          color: ConstantData.dangerColor,
                          borderRadius: BorderRadius.all(Radius.circular(8))),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info,
                            size: 20,
                            color: ConstantData.whiteColor,
                          ),
                          /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                          SizedBox(
                            width: 10,
                          ),
                          ConstantWidget.getCustomTextWithoutAlign(
                              S.of(context).adminbutton,
                              ConstantData.whiteColor,
                              FontWeight.w900,
                              ConstantData.font15Px),
                        ],
                      ),
                    ),
                    /* onTap: () {
                    Navigator.pushNamed(context, '/tabwidget');
                  },*/
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                  ),
                  Row(
                    children: [
                      InkWell(
                        child: Container(
                            //  margin: EdgeInsets.only(top: 20),
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                color: ConstantData.blueColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: InkWell(
                              child: Center(
                                child: ConstantWidget.getCustomTextWithoutAlign(
                                    S.of(context).editprofilebutton,
                                    Colors.white,
                                    FontWeight.w900,
                                    ConstantData.font15Px),
                              ),
                            )),
                        onTap: () {
                          // Navigator.pushNamed(context, '/editprofile');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EditProfileAdminPage()),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      InkWell(
                        child: Container(
                            //  margin: EdgeInsets.only(top: 20),
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                color: ConstantData.blueColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: InkWell(
                              child: Center(
                                child: ConstantWidget.getCustomTextWithoutAlign(
                                    S.of(context).changepasswordbutton,
                                    Colors.white,
                                    FontWeight.w900,
                                    ConstantData.font15Px),
                              ),
                            )),
                        onTap: () {
                          // Navigator.pushNamed(context, '/changepassword');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ChangePasswordPage()),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      InkWell(
                        child: Container(
                            //  margin: EdgeInsets.only(top: 20),
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                color: ConstantData.blueColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: InkWell(
                              child: Center(
                                child: ConstantWidget.getCustomTextWithoutAlign(
                                    S.of(context).logoutbutton,
                                    Colors.white,
                                    FontWeight.w900,
                                    ConstantData.font15Px),
                              ),
                            )),
                        onTap: () {
                          // Navigator.pushNamed(context, '/tabwidget');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavBeforeLoginPage()),
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                  ),
                  InkWell(
                    child: Container(
                        //  margin: EdgeInsets.only(top: 20),
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            color: ConstantData.blueColor,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: InkWell(
                          child: Center(
                            child: ConstantWidget.getCustomTextWithoutAlign(
                                S.of(context).zonebutton,
                                Colors.white,
                                FontWeight.w900,
                                ConstantData.font15Px),
                          ),
                        )),
                    onTap: () {
                      // Navigator.pushNamed(context, '/zone');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ZoneAdminPage()),
                      );
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
                  Center(
                    child: ConstantWidget.getCustomTextWithoutAlign(
                        S.of(context).allexpert,
                        // Colors.black,
                        ConstantData.primaryColor,
                        FontWeight.w900,
                        26.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  /*  GridView.count(
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
                        ExpertModel _subCatModle = subList[index];
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
                          child: Container(
                            width: double.infinity,
                            height: cellHeight2,
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Container(
                                    // color: Colors.green,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomLeft,
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
                                                      "ชาย",
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
                                          alignment: Alignment.bottomRight,
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
                                                      "฿ 20,000 ",
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
                                            // 'assets/images/image.jpg'
                                            ConstantData.assetsImagePath +
                                                _subCatModle.image[0],
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
                      },
                    ),
                  ),
                 */

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
                           /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ExpertDetailPage()));*/
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
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.favorite_border_outlined,
                                              ),
                                              iconSize: 20,
                                              color:
                                                  ConstantData.kGreyTextColor,
                                              // color: ConstantData.redColor,
                                              onPressed: () {},
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
                                                    "อายุ" +
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
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  Center(
                    child: ConstantWidget.getCustomTextWithoutAlign(
                        S.of(context).allcustomer,
                        // Colors.black,
                        ConstantData.primaryColor,
                        FontWeight.w900,
                        26.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  /* GridView.count(
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
                        ExpertModel _subCatModle = subList[index];
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
                          child: Container(
                            width: double.infinity,
                            height: cellHeight2,
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Container(
                                    // color: Colors.green,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Container(
                                            height: 35,
                                            width: 45,
                                            padding: EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                                color: ConstantData.whiteColor,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(0),
                                                    topLeft:
                                                        Radius.circular(0))),
                                            child: Center(
                                              child:
                                                  ConstantWidget.getCustomText(
                                                      "ชาย",
                                                      ConstantData.textColor,
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
                                            // 'assets/images/image.jpg'
                                            ConstantData.assetsImagePath +
                                                _subCatModle.image[0],
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
                      },
                    ),
                  ),
                  
                  */

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
                           /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ExpertDetailPage()));*/
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
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.favorite_border_outlined,
                                              ),
                                              iconSize: 20,
                                              color:
                                                  ConstantData.kGreyTextColor,
                                              // color: ConstantData.redColor,
                                              onPressed: () {},
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
                                                    "อายุ" +
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
    );
  }
}

import 'package:flutter/material.dart';

import 'package:metex_app/data/data.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/experts_model.dart';
import 'package:metex_app/models/models.dart';
import 'package:metex_app/models/search_all_response_model.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/utils/utils.dart';

class ExpertDetailPage extends StatefulWidget {
  List<ExpertDetails> chooseExpertlist = [];
  ExpertDetailPage({
    Key? key,
    required this.chooseExpertlist,
  }) : super(key: key);

  @override
  _ExpertDetailPageState createState() => _ExpertDetailPageState();
}

class _ExpertDetailPageState extends State<ExpertDetailPage> {
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  List<List<ExpertModel>> allCatList = [DataFile.getAllExpertModel()];
//  List<SubCategoryModel> subList = [];
  List<ExpertModel> subList = [];
  List<String> selectionList = [
    "Coach",
    "Trainer",
    "Consultant",
  ];
  int selectedPos = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    subList = [];
    subList = allCatList[selectedPos];
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
                /*Center(
                  child: ConstantWidget.getCustomTextWithoutAlign(
                      // S.of(context).aboutus,
                      // Colors.black,
                      "รายละเอียดผู้เชี่ยวชาญ",
                      ConstantData.primaryColor,
                      FontWeight.w900,
                      32.0),
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 2300,
                      width: 360,
                     // color: Colors.pinkAccent,
                      child: Column(
                        children: [
                          Container(
                            width: 280,
                            height: 280,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              color: ConstantData.whiteColor,
                              border: Border.all(
                                  // color: Colors.blue,
                                  color: ConstantData.whiteColor,
                                  width: 1.0),
                              image: DecorationImage(
                                  /* image: AssetImage(
                                                // 'assets/images/image.jpg'
                                                ConstantData.assetsImagePath +
                                                    _subCatModle.image[0],
                                              ),*/
                                  image: AssetImage('assets/images/no-image.png'
                                      // ConstantData.assetsImagePath +
                                      // "profile/15/15-1615970522.jpg",
                                      ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                          ),
                          ConstantWidget.getCustomTextWithoutAlign(
                              S.of(context).picture,
                              ConstantData.primaryColor,
                              FontWeight.w900,
                              20.0),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                          ),
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              color: ConstantData.whiteColor,
                              border: Border.all(
                                  // color: Colors.blue,
                                  color: ConstantData.whiteColor,
                                  width: 1.0),
                              image: DecorationImage(
                                  /* image: AssetImage(
                                                // 'assets/images/image.jpg'
                                                ConstantData.assetsImagePath +
                                                    _subCatModle.image[0],
                                              ),*/
                                  image: AssetImage('assets/images/no-image.png'
                                      // ConstantData.assetsImagePath +
                                      // "profile/15/15-1615970522.jpg",
                                      ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 2300,
                      width: 850,
                      // color: Colors.blue,
                      child: Column(
                        //  mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ConstantWidget.getCustomTextWithoutAlign(
                                  widget.chooseExpertlist[0].userProfileName,
                                  ConstantData.primaryColor,
                                  FontWeight.w900,
                                  32.0),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                child: Container(
                                    //  margin: EdgeInsets.only(top: 20),
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        // color: ConstantData.blueColor,
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: InkWell(
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.verified,
                                              size: 16,
                                              color: ConstantData.whiteColor,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            ConstantWidget
                                                .getCustomTextWithoutAlign(
                                                    S.of(context).verified,
                                                    Colors.white,
                                                    FontWeight.w900,
                                                    ConstantData.font15Px),
                                          ],
                                        ),
                                      ),
                                    )),
                                onTap: () {},
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
                                      //  color: ConstantData.blueColor,
                                      color: Colors.amber[400],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: InkWell(
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 20,
                                            color: ConstantData.whiteColor,
                                          ),
                                          /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                          SizedBox(
                                            width: 10,
                                          ),
                                          ConstantWidget
                                              .getCustomTextWithoutAlign(
                                                  S.of(context).topexpert,
                                                  Colors.white,
                                                  FontWeight.w900,
                                                  ConstantData.font15Px),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                          ),
                          Row(
                            children: [
                              ConstantWidget.getCustomTextWithoutAlign(
                                  "฿ " +
                                      widget
                                          .chooseExpertlist[0].userProfilePrice
                                          .toString() +
                                      " - " +
                                      "฿ " +
                                      widget
                                          .chooseExpertlist[0].userProfilePrice2
                                          .toString() +
                                      " / งาน",
                                  ConstantData.primaryColor,
                                  FontWeight.w900,
                                  32.0),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ConstantWidget.getCustomTextWithoutAlign(
                                      S.of(context).gender,
                                      ConstantData.primaryColor,
                                      FontWeight.normal,
                                      16.0),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                  ),
                                  ConstantWidget.getCustomTextWithoutAlign(
                                      S.of(context).age,
                                      ConstantData.primaryColor,
                                      FontWeight.normal,
                                      16.0),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                  ),
                                  ConstantWidget.getCustomTextWithoutAlign(
                                      S.of(context).zone,
                                      ConstantData.primaryColor,
                                      FontWeight.normal,
                                      16.0),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                  ),
                                  ConstantWidget.getCustomTextWithoutAlign(
                                      S.of(context).type,
                                      ConstantData.primaryColor,
                                      FontWeight.normal,
                                      16.0),
                                ],
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                children: [
                                  ConstantWidget.getCustomTextWithoutAlign(
                                      /* widget.chooseExpertlist[0]
                                          .userProfileGender,*/
                                      " ชาย",
                                      ConstantData.primaryColor,
                                      FontWeight.normal,
                                      16.0),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                  ),
                                  ConstantWidget.getCustomTextWithoutAlign(
                                      /* widget.chooseExpertlist[0]
                                          .userProfileGender,*/
                                      " 30 ปี",
                                      ConstantData.primaryColor,
                                      FontWeight.normal,
                                      16.0),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                  ),
                                  ConstantWidget.getCustomTextWithoutAlign(
                                      widget.chooseExpertlist[0].zoneName
                                          .toString(),
                                      ConstantData.primaryColor,
                                      FontWeight.normal,
                                      16.0),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                  ),
                                  ConstantWidget.getCustomTextWithoutAlign(
                                      widget.chooseExpertlist[0].userType2Name
                                          .toString(),
                                      ConstantData.primaryColor,
                                      FontWeight.normal,
                                      16.0),
                                ],
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                children: [
                                  ConstantWidget.getCustomTextWithoutAlign(
                                      S.of(context).phone.toString(),
                                      ConstantData.primaryColor,
                                      FontWeight.normal,
                                      16.0),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                  ),
                                  ConstantWidget.getCustomTextWithoutAlign(
                                      S.of(context).lineid.toString(),
                                      ConstantData.primaryColor,
                                      FontWeight.normal,
                                      16.0),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                  ),
                                  ConstantWidget.getCustomTextWithoutAlign(
                                      S.of(context).facebook.toString(),
                                      ConstantData.primaryColor,
                                      FontWeight.normal,
                                      16.0),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                  ),
                                  Icon(Icons.star)
                                ],
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                children: [
                                  ConstantWidget.getCustomTextWithoutAlign(
                                      widget.chooseExpertlist[0].userProfileTel
                                          .toString(),
                                      ConstantData.primaryColor,
                                      FontWeight.normal,
                                      16.0),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                  ),
                                  ConstantWidget.getCustomTextWithoutAlign(
                                      widget
                                          .chooseExpertlist[0].userProfileLineId
                                          .toString(),
                                      ConstantData.primaryColor,
                                      FontWeight.normal,
                                      16.0),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                  ),
                                  ConstantWidget.getCustomTextWithoutAlign(
                                      widget.chooseExpertlist[0]
                                          .userProfileFacebookId
                                          .toString(),
                                      ConstantData.primaryColor,
                                      FontWeight.normal,
                                      16.0),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                  ),
                                  ConstantWidget.getCustomTextWithoutAlign(
                                      widget.chooseExpertlist[0]
                                          .userProfileStarRate
                                          .toString(),
                                      ConstantData.primaryColor,
                                      FontWeight.normal,
                                      16.0),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                child: Container(
                                    //  margin: EdgeInsets.only(top: 20),
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        // color: ConstantData.blueColor,
                                        color: Colors.pink,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: InkWell(
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              size: 16,
                                              color: ConstantData.whiteColor,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            ConstantWidget
                                                .getCustomTextWithoutAlign(
                                                    'ถูกใจ',
                                                    //  S.of(context).verified,
                                                    Colors.white,
                                                    FontWeight.w900,
                                                    ConstantData.font15Px),
                                          ],
                                        ),
                                      ),
                                    )),
                                onTap: () {},
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 40),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ConstantWidget.getCustomTextWithoutAlign(
                                  //  widget.chooseExpertlist[0].userProfileName,
                                  ' เกี่ยวกับ',
                                  ConstantData.primaryColor,
                                  FontWeight.w500,
                                  18.0),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: ConstantWidget.getCustomTextWithoutAlign(
                                    widget.chooseExpertlist[0].userProfileAbout
                                        .toString(),
                                    ConstantData.primaryColor,
                                    FontWeight.w500,
                                    16.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                   // Container(height: 900, width: 425, color: Colors.yellow),
                  ],
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
          ),
        ),
      ),
    );
  }
}

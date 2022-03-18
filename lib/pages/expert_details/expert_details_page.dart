import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:metex_app/data/data.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/experts_model.dart';
import 'package:metex_app/models/models.dart';
import 'package:metex_app/models/search_all_response_model.dart';

import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/services/config.dart';
import 'package:metex_app/utils/utils.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
  List<ExpertDetails> allExpertlist = [];
  List<ExpertDetails> expertlist = [];

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

  toLogout(BuildContext context) async {
    // Create storage
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'loginUserToken');
    var data = {"token": token};
    try {
      Uri url = Uri.parse(Config.BASE_URL + '/api/admin/logout'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      //print(response.statusCode);
      if (response.statusCode == 200) {
        await storage.delete(key: 'loginUserToken');
        //print(response.body);
        /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminLoginPage(),
          ),
        );*/
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Logout ไปแล้ว')));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getDataExpertAll() async {
    var data = {
      "user_id": null,
    };
    Uri url = Uri.parse(Config.BASE_URL + '/api/user/search/all'); //url on web
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // body: convert.jsonEncode(data)
    );

    if (response.statusCode == 200) {
      // print(response.body);
      final SearchAllResponse searchModel =
          SearchAllResponse.fromJson(convert.jsonDecode(response.body));

      setState(() {
        allExpertlist = searchModel.data.expertdetails
            .where((element) =>
                element.userProfileType == 'u' &&
                element.userProfileUserId ==
                    widget.chooseExpertlist[0].userProfileUserId)
            .toList();

        expertlist = allExpertlist;
      });
    } else {
      print('Error getDataExpertAll');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // active = widget.chooseExpertlist[0].userProfileIsActive;

    // print("active ====> $active ");
    getDataExpertAll();
  }

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

            child: allExpertlist.length == 0
                ? Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: "กรุณารอสักครู",
                    ),
                  )
                : new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 50),
                      ),
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
                                    image: expertlist.length == 0
                                        ? DecorationImage(
                                            image: AssetImage(
                                                'assets/images/no-image.png'),
                                            fit: BoxFit.cover)
                                        : DecorationImage(
                                            image: NetworkImage(Config
                                                    .BASE_URL +
                                                '/public/uploads/user-profile/' +
                                                expertlist[0]
                                                    .userProfileId
                                                    .toString() +
                                                '/' +
                                                expertlist[0].userProfileImage),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7.0)),
                                      color: ConstantData.whiteColor,
                                      border: Border.all(
                                          // color: Colors.blue,
                                          color: ConstantData.whiteColor,
                                          width: 1.0),
                                      /* image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/no-image.png'),
                                        fit: BoxFit.cover),*/
                                      image: expertlist.length == 0
                                          ? DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/no-image.png'),
                                              fit: BoxFit.cover)
                                          : DecorationImage(
                                              image: NetworkImage(Config
                                                      .BASE_URL +
                                                  '/public/uploads/user-profile/' +
                                                  expertlist[0]
                                                      .userProfileId
                                                      .toString() +
                                                  '/' +
                                                  expertlist[0]
                                                      .userProfileImage),
                                              fit: BoxFit.cover)),
                                ),
                                /*Container(
                                  child: new GridView.count(
                                    crossAxisCount: 4,
                                    children:
                                        new List<Widget>.generate(16, (index) {
                                      return new GridTile(
                                        child: new Card(
                                            color: Colors.blue.shade200,
                                            child: new Center(
                                              child: new Text('tile $index'),
                                            )),
                                      );
                                    }),
                                  ),
                                )*/
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
                                        expertlist[0].userProfileName,
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
                                    expertlist[0].userProfileIsConfirmImage == 1
                                        ? InkWell(
                                            child: Container(
                                                //  margin: EdgeInsets.only(top: 20),
                                                height: 50,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                    // color: ConstantData.blueColor,
                                                    color: Colors.lightBlue,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8))),
                                                child: InkWell(
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.verified,
                                                          size: 16,
                                                          color: ConstantData
                                                              .whiteColor,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        ConstantWidget
                                                            .getCustomTextWithoutAlign(
                                                                S
                                                                    .of(context)
                                                                    .verified,
                                                                Colors.white,
                                                                FontWeight.w900,
                                                                ConstantData
                                                                    .font15Px),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            onTap: () {},
                                          )
                                        : Container(),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                    ),
                                    expertlist[0].userProfileIsTopStar == 1
                                        ? InkWell(
                                            child: Container(
                                              //  margin: EdgeInsets.only(top: 20),
                                              height: 50,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  //  color: ConstantData.blueColor,
                                                  color: Colors.amber[400],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              child: InkWell(
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        size: 20,
                                                        color: ConstantData
                                                            .whiteColor,
                                                      ),
                                                      /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      ConstantWidget
                                                          .getCustomTextWithoutAlign(
                                                              S
                                                                  .of(context)
                                                                  .topexpert,
                                                              Colors.white,
                                                              FontWeight.w900,
                                                              ConstantData
                                                                  .font15Px),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {},
                                          )
                                        : Container()
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                ),
                                Row(
                                  children: [
                                    ConstantWidget.getCustomTextWithoutAlign(
                                        "฿ " +
                                            expertlist[0]
                                                .userProfilePrice
                                                .toString() +
                                            " - " +
                                            "฿ " +
                                            expertlist[0]
                                                .userProfilePrice2
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                S.of(context).gender,
                                                ConstantData.primaryColor,
                                                FontWeight.normal,
                                                16.0),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                        ),
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                S.of(context).age,
                                                ConstantData.primaryColor,
                                                FontWeight.normal,
                                                16.0),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                        ),
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                S.of(context).zone,
                                                ConstantData.primaryColor,
                                                FontWeight.normal,
                                                16.0),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                        ),
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
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
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                expertlist[0].gender,
                                                ConstantData.primaryColor,
                                                FontWeight.normal,
                                                16.0),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                        ),
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                expertlist[0].age.toString(),
                                                ConstantData.primaryColor,
                                                FontWeight.normal,
                                                16.0),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                        ),
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                expertlist[0]
                                                    .zoneName
                                                    .toString(),
                                                ConstantData.primaryColor,
                                                FontWeight.normal,
                                                16.0),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                        ),
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                expertlist[0]
                                                    .userType2Name
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
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                S.of(context).phone.toString(),
                                                ConstantData.primaryColor,
                                                FontWeight.normal,
                                                16.0),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                        ),
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                S.of(context).lineid.toString(),
                                                ConstantData.primaryColor,
                                                FontWeight.normal,
                                                16.0),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                        ),
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                S
                                                    .of(context)
                                                    .facebook
                                                    .toString(),
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
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                expertlist[0]
                                                    .userProfileTel
                                                    .toString(),
                                                ConstantData.primaryColor,
                                                FontWeight.normal,
                                                16.0),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                        ),
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                expertlist[0].lineId.toString(),
                                                ConstantData.primaryColor,
                                                FontWeight.normal,
                                                16.0),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                        ),
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                expertlist[0]
                                                    .facebookId
                                                    .toString(),
                                                ConstantData.primaryColor,
                                                FontWeight.normal,
                                                16.0),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                        ),
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                expertlist[0]
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
                                    /* InkWell(
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
                                                    color:
                                                        ConstantData.whiteColor,
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
                                                          ConstantData
                                                              .font15Px),
                                                ],
                                              ),
                                            ),
                                          )),
                                      onTap: () {},
                                    ),
                                   
                                   Padding(
                                      padding: EdgeInsets.only(left: 10),),*/
                                    InkWell(
                                      child: Container(
                                          //  margin: EdgeInsets.only(top: 20),
                                          height: 50,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              // color: ConstantData.blueColor,
                                              color: ConstantData.primaryColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: InkWell(
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.shopping_cart,
                                                    size: 20,
                                                    color:
                                                        ConstantData.whiteColor,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  ConstantWidget
                                                      .getCustomTextWithoutAlign(
                                                          'Audit',
                                                          //  S.of(context).verified,
                                                          ConstantData
                                                              .whiteColor,
                                                          FontWeight.w900,
                                                          ConstantData
                                                              .font15Px),
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
                                      child: ConstantWidget
                                          .getCustomTextWithoutAlign(
                                              expertlist[0].about.toString(),
                                              ConstantData.primaryColor,
                                              FontWeight.w500,
                                              16.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          /* Container(
                      height: 2300,
                      width: 400,
                      color: Colors.yellow,
                      child: IntrinsicWidth(
                        child: Column(
                          
                          children: [
                         ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    0, 50) // put the width and height you want
                                ),
                            child: Text("NExxxT"),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    0, 50) // put the width and height you want
                                ),
                            child: Text("NEXxxxxxxT"),
                          )
                      
                         
                        ]),
                      ),
                    ),*/
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

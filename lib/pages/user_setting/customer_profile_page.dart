import 'package:flutter/material.dart';

import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/user_response_model.dart';
import 'package:metex_app/models/userprofile_response.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/pages/user_setting/editpicture_page.dart';
import 'package:metex_app/services/config.dart';
import 'package:metex_app/utils/utils.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class CustomerProfilePage extends StatefulWidget {
  late String userId;
  late String userName;
  late String userType;

  CustomerProfilePage(
      {Key? key,
      required this.userId,
      required this.userName,
      required this.userType})
      : super(key: key);

  @override
  _CustomerProfilePageState createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  late List<UserProfileData> userprofileList = [];

  toCheckGender(String gender) {
    if (gender == 'm') {
      return 'ชาย';
    } else {
      return 'หญิง';
    }
  }

  toGetUserProfileData() async {
    var data = {"user_id": widget.userId};
    try {
      Uri url =
          Uri.parse(Config.BASE_URL +'/api/user/userprofile'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      // print(widget.userId);
      if (response.statusCode == 200) {
        //  print(response.body);
        final UserProfileResponseModel userprofile =
            UserProfileResponseModel.fromJson(
                convert.jsonDecode(response.body));
        setState(() {
          userprofileList = userprofile.data;
          // print("======> " + userprofileList.length.toString());
        });
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toGetUserProfileData();
    //  print("======> " + widget.userName);
    toGetUserProfileData();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _requestPop() {
      Navigator.of(context, rootNavigator: true).pop();
      return new Future.value(false);
    }

    SizeConfig().init(context);

    var cellHeight = SizeConfig.safeBlockHorizontal! * 58;

    double cellMargin = 7;

    var _crossAxisSpacing = 8.0;

    var bottomDialogTextSizeFilter = SizeConfig.safeBlockVertical! * 55;

    var _screenWidth = MediaQuery.of(context).size.width;

    var _crossAxisCount = 2;

    // double editTextHeight = MediaQuery.of(context).size.height * 0.06;
    double mainCatWidth = (SizeConfig.safeBlockHorizontal! * 50) -
        (cellMargin * 2 + _crossAxisSpacing);
    double mainCatHeight = cellHeight;
    double topCellHeight = ConstantWidget.getPercentSize(cellHeight, 12);
    double imageSize = SizeConfig.safeBlockVertical! * 6.5;
    double bottomRemainSize = cellHeight - imageSize - topCellHeight;

    return WillPopScope(
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
              child: userprofileList.length == 0
                  ? Center(
                      child: CircularProgressIndicator(
                        semanticsLabel: "กรุณารอสักครู",
                      ),
                    )
                  : new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                        ),
                        Center(
                          child: ConstantWidget.getCustomTextWithoutAlign(
                              "มาหาผู้เชี่ยวชาญ",
                              // S.of(context).gender,
                              //' My Profile',
                              // Colors.black,
                              ConstantData.primaryColor,
                              FontWeight.w900,
                              32.0),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                        ),
                        Container(
                          width: 280,
                          height: 280,
                          decoration: BoxDecoration(
                            /*borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7),
                      ),*/
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                            color: ConstantData.whiteColor,
                            border: Border.all(
                                // color: Colors.blue,
                                color: ConstantData.whiteColor,
                                width: 1.0),
                            /*image: DecorationImage(
                          /* image: AssetImage(
                                                // 'assets/images/image.jpg'
                                                ConstantData.assetsImagePath +
                                                    _subCatModle.image[0],
                                              ),*/
                          image: AssetImage(
                            ConstantData.assetsImagePath +
                               "profile/15/15-1615970522.jpg",
                               
                          ),
                          fit: BoxFit.cover),*/
                            image: DecorationImage(
                                image: AssetImage('assets/images/no-image.png'
                                    /* ConstantData.assetsImagePath +
                                                _subCatModle.image[0],*/
                                    ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                        ),

                        /* Container(
                    //color: Colors.green,
                   /* child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: ConstantData.whiteColor,
                            borderRadius: BorderRadius.circular(100)),
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
                    ),*/

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
                            /* ConstantData.assetsImagePath +
                                                    _subCatModle.image[0],*/

                            ConstantData.assetsImagePath +
                                "profile/15/15-1615970522.jpg",
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),*/

                        /*Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 270,
                    width: 270,
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                         // shape: BoxShape.circle,
                          color: Colors.black,
                          image: new DecorationImage(
                            /* image: _image == null
                                              ? AssetImage("assets/images/hugh.png")
                                              : FileImage(_image),*/

                            image: AssetImage(ConstantData.assetsImagePath +
                                "profile/15/15-1615970522.jpg"),
                            fit: BoxFit.fill,
                          )
                          // borderRadius: BorderRadius.all(Radius.elliptical(20.0, 20.0)),
                          ),
                    ),
                  ),*/
                        Center(
                          child: ConstantWidget.getCustomTextWithoutAlign(
                              // "Kraiput_In" + " " + "",
                              userprofileList[0].userProfileName.toString(),
                              // S.of(context).gender,
                              //' My Profile',
                              // Colors.black,
                              ConstantData.primaryColor,
                              FontWeight.w900,
                              32.0),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                            bottom: 10,
                          ),
                        ),
                        Center(
                          child: ConstantWidget.getCustomTextWithoutAlign(
                              // S.of(context).msg_aboutus,
                              // Colors.black,
                              //  "เพศ: " + " " + "ชาย",
                              "เพศ: " +
                                  " " +
                                  toCheckGender(userprofileList[0]
                                      .userProfileGender
                                      .toString()),
                              ConstantData.primaryColor,
                              FontWeight.w100,
                              16.0),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                            bottom: 10,
                          ),
                        ),
                        Center(
                          child: ConstantWidget.getCustomTextWithoutAlign(
                              // S.of(context).msg_aboutus,
                              // Colors.black,
                              //  "ลงรีวิว: " + " " + "0",
                              "ลงรีวิว: " +
                                  " " +
                                  userprofileList[0]
                                      .userProfileViewCount
                                      .toString(),
                              ConstantData.primaryColor,
                              FontWeight.w100,
                              16.0),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                            bottom: 10,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.person,
                                            size: 16,
                                            color: ConstantData.whiteColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          ConstantWidget
                                              .getCustomTextWithoutAlign(
                                                  S.of(context).editprofile,
                                                  Colors.white,
                                                  FontWeight.w900,
                                                  ConstantData.font15Px),
                                        ],
                                      ),
                                    ),
                                  )),
                              onTap: () {
                                // Navigator.pushNamed( context, '/editprofile');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CustomerEditProfilePage(
                                            userprofileList: userprofileList,
                                            userId: widget.userId,
                                            userName: widget.userName,
                                            userType: widget.userType),
                                  ),
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: ConstantData.whiteColor,
                                        ),
                                        /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                        SizedBox(
                                          width: 10,
                                        ),
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                S.of(context).editpicture,
                                                Colors.white,
                                                FontWeight.w900,
                                                ConstantData.font15Px),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                // Navigator.pushNamed( context, '/changepassword');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditPicturePage(),
                                  ),
                                );
                              },
                            ),
                          ],
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
    );
  }
}

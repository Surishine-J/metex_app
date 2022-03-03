import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:metex_app/data/data.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/experts_model.dart';
import 'package:metex_app/models/models.dart';
import 'package:metex_app/models/user_response_model.dart';
import 'package:metex_app/models/userprofile_response.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/pages/user_setting/agency_editprofile_page.dart';
import 'package:metex_app/pages/user_setting/customer_profile_page.dart';
import 'package:metex_app/pages/user_setting/expert_editprofile_page.dart';
import 'package:metex_app/pages/user_setting/expert_profile_page.dart';
import 'package:metex_app/services/config.dart';
import 'package:metex_app/utils/utils.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class UserSettingPage extends StatefulWidget {
  String userId;
  String userName;
  String userType;
  UserSettingPage(
      {Key? key,
      required this.userId,
      required this.userName,
      required this.userType})
      : super(key: key);

  @override
  _UserSettingPageState createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  List<UserData> userList = [];
  late List<UserProfileData> userprofileList = [];

  Future<bool> _requestPop() {
    Navigator.of(context, rootNavigator: true).pop();
    return new Future.value(false);
  }

  List<ExpertModel> imageList = [];

  // List<List<ExpertModel>> allCatList = [DataFile.getAllExpertModel()];
  void getData() {
    imageList = DataFile.getAllExpertModel();
  }

  toGetUserData() async {
    var data = {"user_id": widget.userId};
    try {
      Uri url = Uri.parse(Config.BASE_URL +'/api/user/user'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      // print(widget.userId);
      if (response.statusCode == 200) {
        //print(response.body);
        final UserResponseModel user =
            UserResponseModel.fromJson(convert.jsonDecode(response.body));
        setState(() {
          userList = user.data;
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('ไม่พบผู้ใช้ ')));
      }
    } catch (e) {
      print(e.toString());
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

  toLogout(BuildContext context) async {
    // Create storage
    final storage = new FlutterSecureStorage();
var token = await storage.read(key: 'loginUserToken');
    var data = {"token": token};
    try {
      //  Uri url = Uri.parse('http://127.0.0.1:3000/api/user/logout'); //url on web
      Uri url = Uri.parse(Config.BASE_URL + '/api/user/logout'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      print(response.statusCode);
      if (response.statusCode == 200) {
        //print(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavBeforeLoginPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Logout ไปแล้ว')));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  toCheckEditProfilePageRoute() async {
    // print(userList[0].userType.toString());
    try {
      if (userList[0].userType == 'c') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerEditProfilePage(
                userprofileList: userprofileList,
                userId: widget.userId,
                userName: widget.userName,
                userType: widget.userType),
          ),
        );
      } else if (userList[0].userType == 'u') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpertEditProfilePage(),
          ),
        );
      } else if (userList[0].userType == 'a') {}
    } catch (e) {
      print(e.toString());
    }
  }

  toCheckMyProfilePageRoute() async {
    try {
      print(userList[0].userType);
      if (userList[0].userType == 'c') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerProfilePage(
                userId: widget.userId,
                userName: widget.userName,
                userType: widget.userType),
          ),
        );
      } else if (userList[0].userType == 'u') {
        // print(userList[0].userType);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpertProfilePage(),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  toSendDataEditEmailPageRoute(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditEmailPage(
            userList: userList,
            userId: widget.userId,
            userName: widget.userName,
            userType: widget.userType),
      ),
    );
  }

  toSendDataEditPasswordPageRoute(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPasswordPage(
            userId: widget.userId,
            userName: widget.userName,
            userType: widget.userType),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toGetUserData();
    toGetUserProfileData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
              child: userList.length == 0
                  ? Center(
                      child: CircularProgressIndicator(
                        semanticsLabel: "กรุณารอสักครู",
                      ),
                    )
                  : Column(
                      // เชคว่าเป็น agent ไหม ตรงนี้
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                        ),
                        userList[0].userType == 'c' ||
                                userList[0].userType == 'u'
                            ? Container(
                                // color: Colors.green,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
                                    // Row(children: [],)
                                    Container(
                                        child: Responsive.isMobile(context)
                                            ? Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        child: Container(
                                                            //  margin: EdgeInsets.only(top: 20),
                                                            height: 50,
                                                            width: 200,
                                                            decoration: BoxDecoration(
                                                                color: ConstantData
                                                                    .blueColor,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                            child: InkWell(
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .person,
                                                                      size: 16,
                                                                      color: ConstantData
                                                                          .whiteColor,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    ConstantWidget.getCustomTextWithoutAlign(
                                                                        S
                                                                            .of(
                                                                                context)
                                                                            .myprofile,
                                                                        Colors
                                                                            .white,
                                                                        FontWeight
                                                                            .w900,
                                                                        ConstantData
                                                                            .font15Px),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                        onTap: () {
                                                          // Navigator.pushNamed( context, '/editprofile');
                                                          /*Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomerProfilePage(),
                                                ),
                                              );*/
                                                        },
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                      ),
                                                      InkWell(
                                                        child: Container(
                                                          //  margin: EdgeInsets.only(top: 20),
                                                          height: 50,
                                                          width: 200,
                                                          decoration: BoxDecoration(
                                                              color: ConstantData
                                                                  .blueColor,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8))),
                                                          child: InkWell(
                                                            child: Center(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons.edit,
                                                                    size: 20,
                                                                    color: ConstantData
                                                                        .whiteColor,
                                                                  ),
                                                                  /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  ConstantWidget.getCustomTextWithoutAlign(
                                                                      S
                                                                          .of(
                                                                              context)
                                                                          .editprofile,
                                                                      Colors
                                                                          .white,
                                                                      FontWeight
                                                                          .w900,
                                                                      ConstantData
                                                                          .font15Px),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          // Navigator.pushNamed( context, '/changepassword');
                                                          /*Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomerEditProfilePage(),
                                                ),
                                              );*/
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10),
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        child: Container(
                                                            //  margin: EdgeInsets.only(top: 20),
                                                            height: 50,
                                                            width: 200,
                                                            decoration: BoxDecoration(
                                                                color: ConstantData
                                                                    .blueColor,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                            child: InkWell(
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .picture_in_picture,
                                                                      size: 16,
                                                                      color: ConstantData
                                                                          .whiteColor,
                                                                    ),
                                                                    /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    ConstantWidget.getCustomTextWithoutAlign(
                                                                        S
                                                                            .of(
                                                                                context)
                                                                            .editpicture,
                                                                        Colors
                                                                            .white,
                                                                        FontWeight
                                                                            .w900,
                                                                        ConstantData
                                                                            .font15Px),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                        onTap: () {
                                                          print(
                                                              'You press EditPicture Button');
                                                          // Navigator.pushNamed(context, '/tabwidget');
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EditPicturePage(),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                      ),
                                                      InkWell(
                                                        child: Container(
                                                            //  margin: EdgeInsets.only(top: 20),
                                                            height: 50,
                                                            width: 200,
                                                            decoration: BoxDecoration(
                                                                color: ConstantData
                                                                    .blueColor,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                            child: InkWell(
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .email,
                                                                      size: 16,
                                                                      color: ConstantData
                                                                          .whiteColor,
                                                                    ),
                                                                    /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    ConstantWidget.getCustomTextWithoutAlign(
                                                                        S
                                                                            .of(
                                                                                context)
                                                                            .editemail,
                                                                        Colors
                                                                            .white,
                                                                        FontWeight
                                                                            .w900,
                                                                        ConstantData
                                                                            .font15Px),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                        onTap: () {
                                                          print(
                                                              'You press EditEmail Button');
                                                          // Navigator.pushNamed(context, '/tabwidget');

                                                          /* Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EditEmailPage(),
                                                            ),
                                                          );*/
                                                          toSendDataEditEmailPageRoute(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10),
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        child: Container(
                                                            //  margin: EdgeInsets.only(top: 20),
                                                            height: 50,
                                                            width: 200,
                                                            decoration: BoxDecoration(
                                                                color: ConstantData
                                                                    .blueColor,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                            child: InkWell(
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .lock,
                                                                      size: 16,
                                                                      color: ConstantData
                                                                          .whiteColor,
                                                                    ),
                                                                    /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    ConstantWidget.getCustomTextWithoutAlign(
                                                                        S
                                                                            .of(
                                                                                context)
                                                                            .editpassword,
                                                                        Colors
                                                                            .white,
                                                                        FontWeight
                                                                            .w900,
                                                                        ConstantData
                                                                            .font15Px),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                        onTap: () {
                                                          print(
                                                              'You press EditPassword Button');
                                                          toSendDataEditPasswordPageRoute(
                                                              context);
                                                        },
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                      ),
                                                      InkWell(
                                                        child: Container(
                                                            //  margin: EdgeInsets.only(top: 20),
                                                            height: 50,
                                                            width: 200,
                                                            decoration: BoxDecoration(
                                                                color: ConstantData
                                                                    .blueColor,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                            child: InkWell(
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .logout,
                                                                      size: 16,
                                                                      color: ConstantData
                                                                          .whiteColor,
                                                                    ),
                                                                    /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    ConstantWidget.getCustomTextWithoutAlign(
                                                                        S
                                                                            .of(
                                                                                context)
                                                                            .logoutbutton,
                                                                        Colors
                                                                            .white,
                                                                        FontWeight
                                                                            .w900,
                                                                        ConstantData
                                                                            .font15Px),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                        onTap: () {
                                                          // Navigator.pushNamed(context, '/tabwidget');
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  NavBeforeLoginPage(),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : Responsive.isTablet(context)
                                                ? Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                            child: Container(
                                                                //  margin: EdgeInsets.only(top: 20),
                                                                height: 50,
                                                                width: 200,
                                                                decoration: BoxDecoration(
                                                                    color: ConstantData
                                                                        .blueColor,
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
                                                                          Icons
                                                                              .person,
                                                                          size:
                                                                              16,
                                                                          color:
                                                                              ConstantData.whiteColor,
                                                                        ),
                                                                        /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        ConstantWidget.getCustomTextWithoutAlign(
                                                                            S.of(context).myprofile,
                                                                            Colors.white,
                                                                            FontWeight.w900,
                                                                            ConstantData.font15Px),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )),
                                                            onTap: () {
                                                              // Navigator.pushNamed(context, '/editprofile');
                                                              print(
                                                                  'You press MyProfile Button');
                                                              // Navigator.pushNamed(context, '/tabwidget');
                                                              /* Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CustomerProfilePage(),
                                                    ),
                                                  );*/
                                                            },
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                          ),
                                                          InkWell(
                                                            child: Container(
                                                              //  margin: EdgeInsets.only(top: 20),
                                                              height: 50,
                                                              width: 200,
                                                              decoration: BoxDecoration(
                                                                  color: ConstantData
                                                                      .blueColor,
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
                                                                        Icons
                                                                            .edit,
                                                                        size:
                                                                            16,
                                                                        color: ConstantData
                                                                            .whiteColor,
                                                                      ),
                                                                      /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      ConstantWidget.getCustomTextWithoutAlign(
                                                                          S
                                                                              .of(
                                                                                  context)
                                                                              .editprofile,
                                                                          Colors
                                                                              .white,
                                                                          FontWeight
                                                                              .w900,
                                                                          ConstantData
                                                                              .font15Px),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              // Navigator.pushNamed(context, '/changepassword');
                                                              print(
                                                                  'You press EditProfile Button');
                                                              // Navigator.pushNamed(context, '/tabwidget');
                                                              /* Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CustomerEditProfilePage(),
                                                    ),
                                                  );*/
                                                              toCheckEditProfilePageRoute();
                                                            },
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                          ),
                                                          InkWell(
                                                            child: Container(
                                                              //  margin: EdgeInsets.only(top: 20),
                                                              height: 50,
                                                              width: 200,
                                                              decoration: BoxDecoration(
                                                                  color: ConstantData
                                                                      .blueColor,
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
                                                                        Icons
                                                                            .picture_in_picture,
                                                                        size:
                                                                            16,
                                                                        color: ConstantData
                                                                            .whiteColor,
                                                                      ),
                                                                      /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      ConstantWidget.getCustomTextWithoutAlign(
                                                                          S
                                                                              .of(
                                                                                  context)
                                                                              .editpicture,
                                                                          Colors
                                                                              .white,
                                                                          FontWeight
                                                                              .w900,
                                                                          ConstantData
                                                                              .font15Px),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              // Navigator.pushNamed(context,  '/changepassword');
                                                              print(
                                                                  'You press EditPicture Button');
                                                              // Navigator.pushNamed(context, '/tabwidget');
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          EditPicturePage(),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 10),
                                                      ),
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                            child: Container(
                                                                //  margin: EdgeInsets.only(top: 20),
                                                                height: 50,
                                                                width: 200,
                                                                decoration: BoxDecoration(
                                                                    color: ConstantData
                                                                        .blueColor,
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
                                                                          Icons
                                                                              .email,
                                                                          size:
                                                                              16,
                                                                          color:
                                                                              ConstantData.whiteColor,
                                                                        ),
                                                                        /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        ConstantWidget.getCustomTextWithoutAlign(
                                                                            S.of(context).editemail,
                                                                            Colors.white,
                                                                            FontWeight.w900,
                                                                            ConstantData.font15Px),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )),
                                                            onTap: () {
                                                              // Navigator.pushNamed(context, '/tabwidget');
                                                              print(
                                                                  'You press EditEmail Button');
                                                              // Navigator.pushNamed(context, '/tabwidget');
                                                              /* Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          EditEmailPage(),
                                                                ),
                                                              );*/
                                                              toSendDataEditEmailPageRoute(
                                                                  context);
                                                            },
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                          ),
                                                          InkWell(
                                                            child: Container(
                                                                //  margin: EdgeInsets.only(top: 20),
                                                                height: 50,
                                                                width: 200,
                                                                decoration: BoxDecoration(
                                                                    color: ConstantData
                                                                        .blueColor,
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
                                                                          Icons
                                                                              .lock,
                                                                          size:
                                                                              16,
                                                                          color:
                                                                              ConstantData.whiteColor,
                                                                        ),
                                                                        /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        ConstantWidget.getCustomTextWithoutAlign(
                                                                            S.of(context).editpassword,
                                                                            Colors.white,
                                                                            FontWeight.w900,
                                                                            ConstantData.font15Px),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )),
                                                            onTap: () {
                                                              // Navigator.pushNamed(context, '/tabwidget');
                                                              print(
                                                                  'You press EditPassword Button');
                                                              toSendDataEditPasswordPageRoute(
                                                                  context);
                                                            },
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                          ),
                                                          InkWell(
                                                            child: Container(
                                                              //  margin: EdgeInsets.only(top: 20),
                                                              height: 50,
                                                              width: 200,
                                                              decoration: BoxDecoration(
                                                                  color: ConstantData
                                                                      .blueColor,
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
                                                                        Icons
                                                                            .logout,
                                                                        size:
                                                                            16,
                                                                        color: ConstantData
                                                                            .whiteColor,
                                                                      ),
                                                                      /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      ConstantWidget.getCustomTextWithoutAlign(
                                                                          S
                                                                              .of(
                                                                                  context)
                                                                              .logoutbutton,
                                                                          Colors
                                                                              .white,
                                                                          FontWeight
                                                                              .w900,
                                                                          ConstantData
                                                                              .font15Px),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              print(
                                                                  'You press Logout Button');
                                                              // Navigator.pushNamed(context, '/tabwidget');

                                                              /* Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          NavBeforeLoginPage(),
                                                                ),
                                                              );*/
                                                              toLogout(context);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 10),
                                                      ),
                                                    ],
                                                  )
                                                : Responsive.isDesktop(context)
                                                    ? Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                child:
                                                                    Container(
                                                                        //  margin: EdgeInsets.only(top: 20),
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            200,
                                                                        decoration: BoxDecoration(
                                                                            color: ConstantData
                                                                                .blueColor,
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                8))),
                                                                        child:
                                                                            InkWell(
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.person,
                                                                                  size: 16,
                                                                                  color: ConstantData.whiteColor,
                                                                                ),
                                                                                /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                                SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                ConstantWidget.getCustomTextWithoutAlign(S.of(context).myprofile, Colors.white, FontWeight.w900, ConstantData.font15Px),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )),
                                                                onTap: () {
                                                                  // Navigator.pushNamed( context,   '/myprofile');
                                                                  /* Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              CustomerProfilePage(),
                                                        ),
                                                      );*/
                                                                  toCheckMyProfilePageRoute();
                                                                },
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                              ),
                                                              InkWell(
                                                                child:
                                                                    Container(
                                                                  //  margin: EdgeInsets.only(top: 20),
                                                                  height: 50,
                                                                  width: 200,
                                                                  decoration: BoxDecoration(
                                                                      color: ConstantData
                                                                          .blueColor,
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(8))),
                                                                  child:
                                                                      InkWell(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.edit,
                                                                            size:
                                                                                16,
                                                                            color:
                                                                                ConstantData.whiteColor,
                                                                          ),
                                                                          /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          ConstantWidget.getCustomTextWithoutAlign(
                                                                              S.of(context).editprofile,
                                                                              Colors.white,
                                                                              FontWeight.w900,
                                                                              ConstantData.font15Px),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  toCheckEditProfilePageRoute();
                                                                },
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                              ),
                                                              InkWell(
                                                                child:
                                                                    Container(
                                                                  //  margin: EdgeInsets.only(top: 20),
                                                                  height: 50,
                                                                  width: 200,
                                                                  decoration: BoxDecoration(
                                                                      color: ConstantData
                                                                          .blueColor,
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(8))),
                                                                  child:
                                                                      InkWell(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.picture_in_picture,
                                                                            size:
                                                                                16,
                                                                            color:
                                                                                ConstantData.whiteColor,
                                                                          ),
                                                                          /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          ConstantWidget.getCustomTextWithoutAlign(
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
                                                                  print(
                                                                      'You press EditPicturePage Button');
                                                                  //  Navigator.pushNamed( context, '/editpicture');
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              EditPicturePage(),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                              ),
                                                              InkWell(
                                                                child:
                                                                    Container(
                                                                        //  margin: EdgeInsets.only(top: 20),
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            200,
                                                                        decoration: BoxDecoration(
                                                                            color: ConstantData
                                                                                .blueColor,
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                8))),
                                                                        child:
                                                                            InkWell(
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.email,
                                                                                  size: 16,
                                                                                  color: ConstantData.whiteColor,
                                                                                ),
                                                                                /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                                SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                ConstantWidget.getCustomTextWithoutAlign(S.of(context).editemail, Colors.white, FontWeight.w900, ConstantData.font15Px),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )),
                                                                onTap: () {
                                                                  print(
                                                                      'You press EditEmailPage Button');
                                                                  // Navigator.pushNamed(context,  '/editemail');
                                                                  /* Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              EditEmailPage(),
                                                                    ),
                                                                  );*/
                                                                  toSendDataEditEmailPageRoute(
                                                                      context);
                                                                },
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                              ),
                                                              InkWell(
                                                                child:
                                                                    Container(
                                                                        //  margin: EdgeInsets.only(top: 20),
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            200,
                                                                        decoration: BoxDecoration(
                                                                            color: ConstantData
                                                                                .blueColor,
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                8))),
                                                                        child:
                                                                            InkWell(
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.lock,
                                                                                  size: 16,
                                                                                  color: ConstantData.whiteColor,
                                                                                ),
                                                                                /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                                SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                ConstantWidget.getCustomTextWithoutAlign(S.of(context).editpassword, Colors.white, FontWeight.w900, ConstantData.font15Px),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )),
                                                                onTap: () {
                                                                  print(
                                                                      'You press EditPassword Button');
                                                                  toSendDataEditPasswordPageRoute(
                                                                      context);
                                                                },
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                              ),
                                                              InkWell(
                                                                child:
                                                                    Container(
                                                                  //  margin: EdgeInsets.only(top: 20),
                                                                  height: 50,
                                                                  width: 200,
                                                                  decoration: BoxDecoration(
                                                                      color: ConstantData
                                                                          .blueColor,
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(8))),
                                                                  child:
                                                                      InkWell(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.logout,
                                                                            size:
                                                                                16,
                                                                            color:
                                                                                ConstantData.whiteColor,
                                                                          ),
                                                                          /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          ConstantWidget.getCustomTextWithoutAlign(
                                                                              S.of(context).logoutbutton,
                                                                              Colors.white,
                                                                              FontWeight.w900,
                                                                              ConstantData.font15Px),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  toLogout(
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 10),
                                                          ),
                                                          Row(
                                                            children: [],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 10),
                                                          ),
                                                        ],
                                                      )
                                                    : Column()),
                                  ],
                                ),
                              )
                            : Container(
                                // color: Colors.green,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                    ),
                                    // Row(children: [],)
                                    Container(
                                        child: Responsive.isMobile(context)
                                            ? Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        child: Container(
                                                            //  margin: EdgeInsets.only(top: 20),
                                                            height: 50,
                                                            width: 200,
                                                            decoration: BoxDecoration(
                                                                color: ConstantData
                                                                    .blueColor,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                            child: InkWell(
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .person,
                                                                      size: 16,
                                                                      color: ConstantData
                                                                          .whiteColor,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    ConstantWidget.getCustomTextWithoutAlign(
                                                                        S
                                                                            .of(
                                                                                context)
                                                                            .editagencyprofile,
                                                                        Colors
                                                                            .white,
                                                                        FontWeight
                                                                            .w900,
                                                                        ConstantData
                                                                            .font15Px),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                        onTap: () {
                                                          // Navigator.pushNamed( context, '/editprofile');
                                                          /*Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomerProfilePage(),
                                                ),
                                              );*/
                                                        },
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                      ),
                                                      InkWell(
                                                        child: Container(
                                                          //  margin: EdgeInsets.only(top: 20),
                                                          height: 50,
                                                          width: 200,
                                                          decoration: BoxDecoration(
                                                              color: ConstantData
                                                                  .blueColor,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8))),
                                                          child: InkWell(
                                                            child: Center(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons.edit,
                                                                    size: 20,
                                                                    color: ConstantData
                                                                        .whiteColor,
                                                                  ),
                                                                  /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  ConstantWidget.getCustomTextWithoutAlign(
                                                                      S
                                                                          .of(
                                                                              context)
                                                                          .editexpertprofile,
                                                                      Colors
                                                                          .white,
                                                                      FontWeight
                                                                          .w900,
                                                                      ConstantData
                                                                          .font15Px),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          // Navigator.pushNamed( context, '/changepassword');
                                                          /*Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomerEditProfilePage(),
                                                ),
                                              );*/
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10),
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        child: Container(
                                                            //  margin: EdgeInsets.only(top: 20),
                                                            height: 50,
                                                            width: 200,
                                                            decoration: BoxDecoration(
                                                                color: ConstantData
                                                                    .blueColor,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                            child: InkWell(
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .email,
                                                                      size: 16,
                                                                      color: ConstantData
                                                                          .whiteColor,
                                                                    ),
                                                                    /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    ConstantWidget.getCustomTextWithoutAlign(
                                                                        S
                                                                            .of(
                                                                                context)
                                                                            .editemail,
                                                                        Colors
                                                                            .white,
                                                                        FontWeight
                                                                            .w900,
                                                                        ConstantData
                                                                            .font15Px),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                        onTap: () {
                                                          print(
                                                              'You press EditEmail Button');
                                                          // Navigator.pushNamed(context, '/tabwidget');

                                                          /* Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EditEmailPage(),
                                                            ),
                                                          );*/
                                                          toSendDataEditEmailPageRoute(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10),
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        child: Container(
                                                            //  margin: EdgeInsets.only(top: 20),
                                                            height: 50,
                                                            width: 200,
                                                            decoration: BoxDecoration(
                                                                color: ConstantData
                                                                    .blueColor,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                            child: InkWell(
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .lock,
                                                                      size: 16,
                                                                      color: ConstantData
                                                                          .whiteColor,
                                                                    ),
                                                                    /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    ConstantWidget.getCustomTextWithoutAlign(
                                                                        S
                                                                            .of(
                                                                                context)
                                                                            .editpassword,
                                                                        Colors
                                                                            .white,
                                                                        FontWeight
                                                                            .w900,
                                                                        ConstantData
                                                                            .font15Px),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                        onTap: () {
                                                          print(
                                                              'You press EditPassword Button');
                                                          toSendDataEditPasswordPageRoute(
                                                              context);
                                                        },
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                      ),
                                                      InkWell(
                                                        child: Container(
                                                            //  margin: EdgeInsets.only(top: 20),
                                                            height: 50,
                                                            width: 200,
                                                            decoration: BoxDecoration(
                                                                color: ConstantData
                                                                    .blueColor,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                            child: InkWell(
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .logout,
                                                                      size: 16,
                                                                      color: ConstantData
                                                                          .whiteColor,
                                                                    ),
                                                                    /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    ConstantWidget.getCustomTextWithoutAlign(
                                                                        S
                                                                            .of(
                                                                                context)
                                                                            .logoutbutton,
                                                                        Colors
                                                                            .white,
                                                                        FontWeight
                                                                            .w900,
                                                                        ConstantData
                                                                            .font15Px),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                        onTap: () {
                                                          // Navigator.pushNamed(context, '/tabwidget');
                                                          /* Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  NavBeforeLoginPage(),
                                                            ),
                                                          );*/
                                                          toLogout(context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : Responsive.isTablet(context)
                                                ? Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                            child: Container(
                                                                //  margin: EdgeInsets.only(top: 20),
                                                                height: 50,
                                                                width: 200,
                                                                decoration: BoxDecoration(
                                                                    color: ConstantData
                                                                        .blueColor,
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
                                                                          Icons
                                                                              .person,
                                                                          size:
                                                                              16,
                                                                          color:
                                                                              ConstantData.whiteColor,
                                                                        ),
                                                                        /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        ConstantWidget.getCustomTextWithoutAlign(
                                                                            S.of(context).editagencyprofile,
                                                                            Colors.white,
                                                                            FontWeight.w900,
                                                                            ConstantData.font15Px),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )),
                                                            onTap: () {
                                                              // Navigator.pushNamed(context, '/editprofile');
                                                              print(
                                                                  'You press MyProfile Button');
                                                              // Navigator.pushNamed(context, '/tabwidget');
                                                              /* Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CustomerProfilePage(),
                                                    ),
                                                  );*/
                                                            },
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                          ),
                                                          InkWell(
                                                            child: Container(
                                                              //  margin: EdgeInsets.only(top: 20),
                                                              height: 50,
                                                              width: 200,
                                                              decoration: BoxDecoration(
                                                                  color: ConstantData
                                                                      .blueColor,
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
                                                                        Icons
                                                                            .edit,
                                                                        size:
                                                                            16,
                                                                        color: ConstantData
                                                                            .whiteColor,
                                                                      ),
                                                                      /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      ConstantWidget.getCustomTextWithoutAlign(
                                                                          S
                                                                              .of(
                                                                                  context)
                                                                              .editexpertprofile,
                                                                          Colors
                                                                              .white,
                                                                          FontWeight
                                                                              .w900,
                                                                          ConstantData
                                                                              .font15Px),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              // Navigator.pushNamed(context, '/changepassword');
                                                              print(
                                                                  'You press EditProfile Button');
                                                              // Navigator.pushNamed(context, '/tabwidget');
                                                              /* Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CustomerEditProfilePage(),
                                                    ),
                                                  );*/
                                                              // toCheckEditProfilePageRoute();
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 10),
                                                      ),
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                            child: Container(
                                                                //  margin: EdgeInsets.only(top: 20),
                                                                height: 50,
                                                                width: 200,
                                                                decoration: BoxDecoration(
                                                                    color: ConstantData
                                                                        .blueColor,
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
                                                                          Icons
                                                                              .email,
                                                                          size:
                                                                              16,
                                                                          color:
                                                                              ConstantData.whiteColor,
                                                                        ),
                                                                        /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        ConstantWidget.getCustomTextWithoutAlign(
                                                                            S.of(context).editemail,
                                                                            Colors.white,
                                                                            FontWeight.w900,
                                                                            ConstantData.font15Px),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )),
                                                            onTap: () {
                                                              // Navigator.pushNamed(context, '/tabwidget');
                                                              print(
                                                                  'You press EditEmail Button');
                                                              // Navigator.pushNamed(context, '/tabwidget');
                                                              /* Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          EditEmailPage(),
                                                                ),
                                                              );*/
                                                              toSendDataEditEmailPageRoute(
                                                                  context);
                                                            },
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                          ),
                                                          InkWell(
                                                            child: Container(
                                                                //  margin: EdgeInsets.only(top: 20),
                                                                height: 50,
                                                                width: 200,
                                                                decoration: BoxDecoration(
                                                                    color: ConstantData
                                                                        .blueColor,
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
                                                                          Icons
                                                                              .lock,
                                                                          size:
                                                                              16,
                                                                          color:
                                                                              ConstantData.whiteColor,
                                                                        ),
                                                                        /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        ConstantWidget.getCustomTextWithoutAlign(
                                                                            S.of(context).editpassword,
                                                                            Colors.white,
                                                                            FontWeight.w900,
                                                                            ConstantData.font15Px),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )),
                                                            onTap: () {
                                                              // Navigator.pushNamed(context, '/tabwidget');
                                                              print(
                                                                  'You press EditPassword Button');
                                                              toSendDataEditPasswordPageRoute(
                                                                  context);
                                                            },
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                          ),
                                                          InkWell(
                                                            child: Container(
                                                              //  margin: EdgeInsets.only(top: 20),
                                                              height: 50,
                                                              width: 200,
                                                              decoration: BoxDecoration(
                                                                  color: ConstantData
                                                                      .blueColor,
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
                                                                        Icons
                                                                            .logout,
                                                                        size:
                                                                            16,
                                                                        color: ConstantData
                                                                            .whiteColor,
                                                                      ),
                                                                      /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      ConstantWidget.getCustomTextWithoutAlign(
                                                                          S
                                                                              .of(
                                                                                  context)
                                                                              .logoutbutton,
                                                                          Colors
                                                                              .white,
                                                                          FontWeight
                                                                              .w900,
                                                                          ConstantData
                                                                              .font15Px),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              print(
                                                                  'You press Logout Button');
                                                              // Navigator.pushNamed(context, '/tabwidget');
                                                              /* Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          NavBeforeLoginPage(),
                                                                ),
                                                              );*/
                                                              toLogout(context);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 10),
                                                      ),
                                                    ],
                                                  )
                                                : Responsive.isDesktop(context)
                                                    ? Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                child:
                                                                    Container(
                                                                        //  margin: EdgeInsets.only(top: 20),
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            200,
                                                                        decoration: BoxDecoration(
                                                                            color: ConstantData
                                                                                .blueColor,
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                8))),
                                                                        child:
                                                                            InkWell(
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.person,
                                                                                  size: 16,
                                                                                  color: ConstantData.whiteColor,
                                                                                ),
                                                                                /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                                SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                ConstantWidget.getCustomTextWithoutAlign(S.of(context).editagencyprofile, Colors.white, FontWeight.w900, ConstantData.font15Px),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )),
                                                                onTap: () {
                                                                  // Navigator.pushNamed( context,   '/myprofile');
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) => AgencyEditProfilePage(
                                                                          userList:
                                                                              userList,
                                                                          userId: widget
                                                                              .userId,
                                                                          userName: widget
                                                                              .userName,
                                                                          userType:
                                                                              widget.userType),
                                                                    ),
                                                                  );
                                                                  //toCheckMyProfilePageRoute();
                                                                },
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                              ),
                                                              InkWell(
                                                                child:
                                                                    Container(
                                                                  //  margin: EdgeInsets.only(top: 20),
                                                                  height: 50,
                                                                  width: 200,
                                                                  decoration: BoxDecoration(
                                                                      color: ConstantData
                                                                          .blueColor,
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(8))),
                                                                  child:
                                                                      InkWell(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.edit,
                                                                            size:
                                                                                16,
                                                                            color:
                                                                                ConstantData.whiteColor,
                                                                          ),
                                                                          /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          ConstantWidget.getCustomTextWithoutAlign(
                                                                              S.of(context).editexpertprofile,
                                                                              Colors.white,
                                                                              FontWeight.w900,
                                                                              ConstantData.font15Px),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  //  Navigator.pushNamed( context, '/editprofile');
                                                                  /* Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              CustomerEditProfilePage(),
                                                        ),
                                                      );*/

                                                                  // toCheckEditProfilePageRoute();
                                                                },
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                              ),
                                                              InkWell(
                                                                child:
                                                                    Container(
                                                                        //  margin: EdgeInsets.only(top: 20),
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            200,
                                                                        decoration: BoxDecoration(
                                                                            color: ConstantData
                                                                                .blueColor,
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                8))),
                                                                        child:
                                                                            InkWell(
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.email,
                                                                                  size: 16,
                                                                                  color: ConstantData.whiteColor,
                                                                                ),
                                                                                /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                                SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                ConstantWidget.getCustomTextWithoutAlign(S.of(context).editemail, Colors.white, FontWeight.w900, ConstantData.font15Px),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )),
                                                                onTap: () {
                                                                  print(
                                                                      'You press EditEmailPage Button');
                                                                  // Navigator.pushNamed(context,  '/editemail');
                                                                  /* Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              EditEmailPage(),
                                                                    ),
                                                                  );*/
                                                                  toSendDataEditEmailPageRoute(
                                                                      context);
                                                                },
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                              ),
                                                              InkWell(
                                                                child:
                                                                    Container(
                                                                        //  margin: EdgeInsets.only(top: 20),
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            200,
                                                                        decoration: BoxDecoration(
                                                                            color: ConstantData
                                                                                .blueColor,
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                8))),
                                                                        child:
                                                                            InkWell(
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.lock,
                                                                                  size: 16,
                                                                                  color: ConstantData.whiteColor,
                                                                                ),
                                                                                /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                                SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                ConstantWidget.getCustomTextWithoutAlign(S.of(context).editpassword, Colors.white, FontWeight.w900, ConstantData.font15Px),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )),
                                                                onTap: () {
                                                                  print(
                                                                      'You press EditPassword Button');
                                                                  toSendDataEditPasswordPageRoute(
                                                                      context);
                                                                },
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                              ),
                                                              InkWell(
                                                                child:
                                                                    Container(
                                                                  //  margin: EdgeInsets.only(top: 20),
                                                                  height: 50,
                                                                  width: 200,
                                                                  decoration: BoxDecoration(
                                                                      color: ConstantData
                                                                          .blueColor,
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(8))),
                                                                  child:
                                                                      InkWell(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.logout,
                                                                            size:
                                                                                16,
                                                                            color:
                                                                                ConstantData.whiteColor,
                                                                          ),
                                                                          /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          ConstantWidget.getCustomTextWithoutAlign(
                                                                              S.of(context).logoutbutton,
                                                                              Colors.white,
                                                                              FontWeight.w900,
                                                                              ConstantData.font15Px),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  toLogout(
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 10),
                                                          ),
                                                          Row(
                                                            children: [],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 10),
                                                          ),
                                                        ],
                                                      )
                                                    : Column()),
                                  ],
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
                      ],
                    )),
        ),
      ),
      onWillPop: _requestPop,
    );
  }

  void finish() {
    Navigator.of(context).pop();
  }
}

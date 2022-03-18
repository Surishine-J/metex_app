import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/me_info%20_response_model.dart';
import 'package:metex_app/models/userprofile_response.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/services/config.dart';
import 'package:metex_app/utils/utils.dart';

class CreateGroupPage extends StatefulWidget {
  // late String userId;
  // late String userName;
  // late String userType;
  late LoginUser? userlogin;
  CreateGroupPage({
    Key? key,
    // required this.userId,
    // required this.userName,
    // required this.userType
     required this.userlogin

  }) : super(key: key);

  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  TextEditingController groupNameController = new TextEditingController();
  late List<UserProfileData> userprofileList = [];
  UserProfileData? dropdownValue;
  final storage = new FlutterSecureStorage();
  var loginUserToken;

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return new Future.value(false);
  }

  /*toCheckLoginData() async {
    // Create storage
    loginUserToken = await storage.read(key: 'loginUserToken');
    if (loginUserToken != null) {
     // getMeInfo(loginUserToken);
    }
  }
*/
 /* getMeInfo(String loginUserToken) async {
    var data = {"token": loginUserToken};
    try {
      Uri url = Uri.parse(Config.BASE_URL + '/api/me/info'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));

      if (response.statusCode == 200) {
        print(response.body);
        final MeInfoResponseModel meinfo =
            MeInfoResponseModel.fromJson(convert.jsonDecode(response.body));
        setState(() {
          userlogin = meinfo.data.loginUser;
          //print(location);
        });

        /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavAfterLoginPage(
                userId: userlogin.userId.toString(),
                userName: userlogin.userName,
                userType: userlogin.userType),
          ),
        );*/
      } else {
        /* ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Logout ไปแล้ว')));*/
      }
    } catch (e) {
      print(e.toString());
    }
  }
*/
  toGetUserProfileData() async {
    var data = {"user_id": widget.userlogin!.userId.toString()};
    try {
      Uri url =
          Uri.parse(Config.BASE_URL + '/api/user/userprofile'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));

      if (response.statusCode == 200) {
        //  print(response.body);
        final UserProfileResponseModel userprofile =
            UserProfileResponseModel.fromJson(
                convert.jsonDecode(response.body));
        setState(() {
          userprofileList = userprofile.data;
         
        });
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  toSaveCreateGroup() async {
    var data = {
      "token": loginUserToken,
      "name": groupNameController.text,
      "user_profile_id": userprofileList[0].userProfileId,
      "user_id": widget.userlogin!.userId.toString()
    };
    try {
      Uri url =
          Uri.parse(Config.BASE_URL + '/api/user/group/create'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));

      print(response.statusCode);
      if (response.statusCode == 200) {
       

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('สร้างกลุ่มสำเร็จ')));
        Navigator.of(context).pop();
        // toGetUserProfileData();
      } else {
        print(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('สร้างกลุ่มไม่สำเร็จ')));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //toCheckLoginData();
    toGetUserProfileData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double editTextHeight = MediaQuery.of(context).size.height * 0.06;

    return new MaterialApp(
      // title: 'SingleChildScrollView Demo',
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        //  onWillPop: _requestPop,
        child: new Scaffold(
          // home: new Scaffold(

          /*appBar: AppBar(
            title: new Text('SingleChildScrollView Demo'),
          ),*/
          body: new SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              //  color: Colors.red,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
                //  bottom: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                //  left: MediaQuery.of(context).size.width * 0.07,
                // right: MediaQuery.of(context).size.width * 0.07,
              ),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 450,
                      height: 500,
                      // color: Colors.green,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: ConstantWidget.getCustomTextWithoutAlign(
                                S.of(context).creategroup,
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
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            height: editTextHeight,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Group Name is Required';
                                }
                              },
                              maxLines: 1,
                              controller: groupNameController,
                              // controller:  S.of(context).documentNo.toString(),
                              style: TextStyle(
                                  fontFamily: ConstantData.fontFamily,
                                  color: ConstantData.primaryTextColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),

                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                  const Radius.circular(5),
                                )),
                                labelText: S.of(context).groupname,
                                // hintText: 'Full Name',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                          ),
                          Container(
                            // height: 40.0,
                            height: editTextHeight,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            width: 450,

                            decoration: BoxDecoration(
                              color: ConstantData.bgColor,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: ConstantData.kGreyTextColor),
                              /* border: Border.all(
                                color: ConstantData.lightGrey, width: .5),*/
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<UserProfileData>(
                                value: dropdownValue,
                                //isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down,
                                    color: Colors.grey.withOpacity(0.7)),
                                // items: items,
                                items: userprofileList
                                    //items:locationSelectList
                                    .map<DropdownMenuItem<UserProfileData>>(
                                        (UserProfileData value) {
                                  return DropdownMenuItem<UserProfileData>(
                                    value: value,
                                    child:
                                        Text(value.userProfileName.toString()),
                                  );
                                }).toList(),
                                onChanged: (UserProfileData? newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                    print('----- value ------');
                                    print(dropdownValue!.userProfileId
                                            .toString() +
                                        " " +
                                        dropdownValue!.userProfileName
                                            .toString());
                                  });
                                },
                                hint: Text(
                                  "------- เลือกหัวหน้ากลุ่ม -------",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                // value: _selectedValue,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                          ),
                          InkWell(
                            child: Container(
                                margin: EdgeInsets.only(top: 20),
                                height: 50,
                                decoration: BoxDecoration(
                                    color: ConstantData.primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: InkWell(
                                  child: Center(
                                    child: ConstantWidget
                                        .getCustomTextWithoutAlign(
                                            S.of(context).create,
                                            Colors.white,
                                            FontWeight.w900,
                                            ConstantData.font15Px),
                                  ),
                                )),
                            onTap: () {
                              toSaveCreateGroup();
                            },
                          ),
                        ],
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
              ),
            ),
          ),
        ),
        onWillPop: _requestPop,
        /* onWillPop: () async {
            return false;
          }*/
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/user_response_model.dart';
import 'package:metex_app/models/userprofile_response.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/services/config.dart';
import 'package:metex_app/utils/utils.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class CustomerEditProfilePage extends StatefulWidget {
  late String userId;
  late String userName;
  late String userType;
  CustomerEditProfilePage(
      {Key? key,
      required this.userId,
      required this.userName,
      required this.userType})
      : super(key: key);

  @override
  State<CustomerEditProfilePage> createState() =>
      _CustomerEditProfilePageState();
}

class _CustomerEditProfilePageState extends State<CustomerEditProfilePage> {
  TextEditingController dispalyNameController = new TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late List<UserProfileData> userprofileList = [];

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  //late String _selectedValue = 'ชาย';
  late String _selectedValue =
      userprofileList[0].userProfileGender == 'm' ? "ชาย" : "หญิง";
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

  toGetUserProfileData() async {
    var data = {"user_id": widget.userId};
    try {
      Uri url =
          Uri.parse(Config.BASE_URL + '/api/user/userprofile'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      // print(widget.userId);
      if (response.statusCode == 200) {
      
        final UserProfileResponseModel userprofile =
            UserProfileResponseModel.fromJson(
                convert.jsonDecode(response.body));
        setState(() {
          userprofileList = userprofile.data;
        
          print(userprofileList[0].userProfileGender);
          dispalyNameController.text =
              userprofileList[0].userProfileName.toString();
          // _selectedValue =
          //     userprofileList[0].userProfileGender == 'm' ? "ชาย" : "หญิง";
          _selectedValue =
              userprofileList[0].userProfileGender == 'm' ? "ชาย" : "หญิง";
        });
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  toSaveCustomeProfile() async {
    var data = {
      "user_id": widget.userId,
      "user_name": dispalyNameController.text,
      "user_profile_gender": _selectedValue == 'ชาย' ? "m" : "f",
    };
    try {
      Uri url = Uri.parse(Config.BASE_URL + '/api/user/rename'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      // print(widget.userId);
      if (response.statusCode == 200) {
        print(response.body);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('เปลี่ยนชื่อสำเร็จ')));
       Navigator.of(context).pop();
       // toGetUserProfileData();
      } else {
        print(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('เปลี่ยนชื่อไม่สำเร็จ')));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toGetUserProfileData();
   
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double editTextHeight = MediaQuery.of(context).size.height * 0.06;

    return WillPopScope(
      child: new Scaffold(
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
              child: userprofileList.length == 0
                  ? Center(
                      child: CircularProgressIndicator(
                        semanticsLabel: "กรุณารอสักครู",
                      ),
                    )
                  : Column(
                      children: [
                        Form(
                          // ใช้งาน Form
                          key: formKey, // กำหนด key
                          child: Container(
                            width: 450,
                            height: 500,
                            //color: Colors.green,
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child:
                                      ConstantWidget.getCustomTextWithoutAlign(
                                          // S.of(context).editprofile,
                                          'แก้ไขโปรไฟล์ มาหาผุ้เชี่ยวชาญ',
                                          // Colors.black,
                                          ConstantData.primaryColor,
                                          FontWeight.w900,
                                          32.0),
                                ),
                                Center(
                                  child:
                                      ConstantWidget.getCustomTextWithoutAlign(
                                          S.of(context).editprofile,
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
                                    maxLines: 1,
                                    controller: dispalyNameController,
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
                                      labelText: S.of(context).displayname,
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
                                    child: DropdownButton(
                                      value: _selectedValue,
                                      //isExpanded: true,

                                      icon: Icon(Icons.arrow_drop_down,
                                          color: Colors.grey.withOpacity(0.7)),
                                      items: items,

                                      onChanged: (String? value) {
                                        setState(() {
                                          _selectedValue = value!;
                                        });
                                      },

                                      // value: _selectedValue,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  child: Container(
                                      margin: EdgeInsets.only(top: 20),
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: ConstantData.primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: InkWell(
                                        child: Center(
                                          child: ConstantWidget
                                              .getCustomTextWithoutAlign(
                                                  S.of(context).save,
                                                  Colors.white,
                                                  FontWeight.w900,
                                                  ConstantData.font15Px),
                                        ),
                                      )),
                                  onTap: () {
                                    toSaveCustomeProfile();
                                  },
                                ),
                              ],
                            ),
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
    );
  }
}

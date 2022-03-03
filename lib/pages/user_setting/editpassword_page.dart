import 'package:flutter/material.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/services/config.dart';
import 'package:metex_app/utils/utils.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


class EditPasswordPage extends StatefulWidget {
  late String userId;
  late String userName;
  late String userType;
  EditPasswordPage({Key? key,
  
      required this.userId,
      required this.userName,
      required this.userType
  }) : super(key: key);

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }
    toValidatePassword(BuildContext context) async {
    FormState? form = await formKey.currentState;
    form!.save();
    if (!form.validate()) {
      print('Invalid Password');
    } else {
      print('Credentials are valid');

      toSaveChangePassword(context);
    }
  }
 
  toSaveChangePassword(BuildContext context) async {
    var data = {
      "user_id": widget.userId,
      "user_password_old": oldPasswordController.text,
       "user_password_new": newPasswordController.text
    };
    try {
      Uri url = Uri.parse(Config.BASE_URL +'/api/user/rename-password'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      print(data);
      if (response.statusCode == 200) {
      
         ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('เปลี่ยน รหัสผ่าน สำเร็จ')));
            Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(' รหัสผ่านเดิมไม่ถูกต้อง')));
      }
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double editTextHeight = MediaQuery.of(context).size.height * 0.06;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: ConstantData.bgColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: ConstantData.bgColor,
          title: Text(""),
          leading: Builder(
            builder: (BuildContext context) {
              return Icon(
                Icons.keyboard_backspace,
                color: Colors.transparent,
              );
            },
          ),
        ),
        body: new SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            // color: Colors.pink,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.07,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              //  left: MediaQuery.of(context).size.width * 0.07,
              // right: MediaQuery.of(context).size.width * 0.07,
            ),
            child: Center(
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Container(
                      width: 450,
                      height: 750,
                      // color: Colors.pink,
                      child: new Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: ConstantWidget.getCustomTextWithoutAlign(
                                S.of(context).editpassword,
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
                                  return 'Email is Required';
                                }
                                if (value.length < 7) {
                                  return 'Required Password is greater than or equal to 7';
                                }
                                return null;
                              },
                              maxLines: 1,
                              controller: oldPasswordController,
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
                                labelText: S.of(context).oldpassword,
                                // hintText: 'Full Name',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            height: editTextHeight,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password is Required';
                                }
                                if (value.length < 7) {
                                  return 'Required Password is greater than or equal to 7';
                                }
                                return null;
                              },
                              maxLines: 1,
                              controller: newPasswordController,
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
                                labelText: S.of(context).newpassword,
                                // hintText: 'Full Name',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            height: editTextHeight,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Confirm Password is Required';
                                }
                                if (value.length < 7) {
                                  return 'Required Password is greater than or equal to 7';
                                }
                                return null;
                              },
                              maxLines: 1,
                              controller: confirmPasswordController,
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
                                labelText: S.of(context).confirmpassword,
                                // hintText: 'Full Name',
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
                                            S.of(context).save,
                                            Colors.white,
                                            FontWeight.w900,
                                            ConstantData.font15Px),
                                  ),
                                )),
                            onTap: () {
                              if (confirmPasswordController.text
                                      .toString()
                                      .trim() !=
                                  newPasswordController.text.toString().trim()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Password   ไม่ตรงกัน')));
                              } else {
                                toValidatePassword(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
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

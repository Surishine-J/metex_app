import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:metex_app/generated/intl/messages_en.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/adminlogin_response_model.dart';
import 'package:metex_app/models/models.dart';

import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/services/config.dart';
import 'package:metex_app/services/session.dart';
import 'package:metex_app/utils/utils.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class UserLoginPage extends StatefulWidget {
  UserLoginPage({Key? key}) : super(key: key);

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  static int _boolToInt(bool _value) => _value ? 1 : 0;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //late List<User> userList;
  late String userId;
  late String userName;
  late String userType;

  validateEmailAndPassword(BuildContext context) async {
    FormState? form = await formKey.currentState;
    form!.save();
    if (!form.validate()) {
      print('Invalid Email');
    } else {
      print('Credentials are valid');

      isUserLogin(context);
    }
  }

  isUserLogin(BuildContext context) async {
    try {
      final storage = new FlutterSecureStorage();
      var data = {
        "user_id": emailController.text,
        "user_password": passwordController.text,
        "rme": _boolToInt(_value).toString(),
      };
      //  Uri url = Uri.parse('http://localhost:3000/api/user/login'); //url on web
      String url = Config.BASE_URL +'/api/user/login'; //url on web
      var response = await MySession.post(url, convert.jsonEncode(data));
      // print(data);

      if (response.statusCode == 200) {
        // print("Login OK ====>" + response.body);
        var jsondata = convert.jsonDecode(response.body);
        print(jsondata);
        final LoginModel userloginModel =
            LoginModel.fromJson(convert.jsonDecode(response.body));
        await storage.write(key: 'loginUserToken', value: userloginModel.data.token);

        setState(() {
          //userList = loginModel.data.user;
          userId = userloginModel.data.user[0].userId.toString();
          userName = userloginModel.data.user[0].userUserId.toString();
          userType = userloginModel.data.user[0].userType.toString();
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => NavAfterLoginPage(
                      userId: userId,
                      userName: userName,
                      userType: userType,
                    )));

       
      } else {
        print("Login NOT OK ====>" + response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('??????????????????????????????????????????')));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  bool _value = false;

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
              child: Column(
                children: [
                  Form(
                    // ?????????????????? Form
                    key: formKey, // ??????????????? key
                    child: Container(
                      width: 450,
                      height: 500,
                      //color: Colors.green,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: ConstantWidget.getCustomTextWithoutAlign(
                                S.of(context).enter,
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
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email is Required';
                                }
                                if (!RegExp(
                                        r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                                    .hasMatch(value)) {
                                  return 'Please enter a valid Email';
                                }
                                return null;
                              },
                              maxLines: 1,
                              controller: emailController,

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
                                labelText: S.of(context).email,
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
                                  return 'Password is Required greater than or equal to 7';
                                }
                              },
                              maxLines: 1,
                              controller: passwordController,
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
                                labelText: S.of(context).password,
                                // hintText: 'Full Name',
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: _value,
                                onChanged: (value) {
                                   setState(() {
                                    _value = value!;
                                  });
                                },
                              ),
                              Text('Remember me')
                            ],
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
                                            S.of(context).login,
                                            Colors.white,
                                            FontWeight.w900,
                                            ConstantData.font15Px),
                                  ),
                                )),
                            onTap: () {
                              validateEmailAndPassword(context);
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
                      Text('?? metex')

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

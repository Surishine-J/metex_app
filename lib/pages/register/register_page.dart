import 'package:flutter/material.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/models.dart';
import 'package:metex_app/models/register_response_model.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/utils/utils.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class TypeRegister {
  String name;
  String type;
  int index;
  TypeRegister({required this.name, required this.index, required this.type});
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmpasswordController = new TextEditingController();
  TextEditingController displayNameController = new TextEditingController();

  //late List<User> userList;
  late String userId;
  late String userName;
  late String userType;

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  validateRegister(BuildContext context) async {
    FormState? form = await formKey.currentState;
    form!.save();
    if (!form.validate()) {
      print('Invalid Email');
    } else {
      print('Credentials are valid');

      toRegister(context);
    }
  }

  toRegister(BuildContext context) async {
    try {
      var data = {
        "user_id": emailController.text,
        "user_password": passwordController.text,
        "user_type": selectType,
        "user_name": displayNameController.text
      };
      Uri url =
          Uri.parse('http://127.0.0.1:3000/api/user/register'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));

      if (response.statusCode == 200) {
        print(response.body);
        if (response.body.isNotEmpty) {
          print(response.body);
          final RegisterResponse registerModel =
              RegisterResponse.fromJson(convert.jsonDecode(response.body));

          if (registerModel.err == null) {
            toLogin(context);
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  toLogin(BuildContext context) async {
    try {
      var data = {
        "user_id": emailController.text,
        "user_password": passwordController.text,
        "rme": 0,
      };
      Uri url = Uri.parse('http://127.0.0.1:3000/api/user/login'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      print(data);

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          print(response.body);
          final LoginModel userloginModel =
              LoginModel.fromJson(convert.jsonDecode(response.body));
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
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Default Radio Button Item
  String radioItem = 'มาหาผู้เชี่ยวชาญ';
  String selectType = 'c';
  // Group Value for Radio Button.
  int id = 1;

  List<TypeRegister> fList = [
    TypeRegister(
      index: 1,
      type: 'c',
      name: "มาหาผู้เชี่ยวชาญ",
    ),
    TypeRegister(
      index: 2,
      type: 'u',
      name: "ผู้เชี่ยวชาญต้องการลงโพสต์",
    ),
    TypeRegister(
      index: 3,
      type: 'a',
      name: "Agency (ลงข้อมูลผู้เชี่ยวชาญหลายคน)",
    ),
  ];

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
            // color: Colors.red,
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
                                S.of(context).register,
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

                                return null;
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

                                return null;
                              },
                              maxLines: 1,
                              controller: confirmpasswordController,
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
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            height: editTextHeight,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Display name is Required';
                                }

                                return null;
                              },
                              maxLines: 1,
                              controller: displayNameController,
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
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 170.0,
                                margin: EdgeInsets.only(bottom: 10, top: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                  border: Border.all(
                                      color: ConstantData.kGreyTextColor),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                bottom: 170,
                                child: Container(
                                  color: Colors.white,
                                  child: Container(
                                      color: ConstantData.bgColor,
                                      child: Text('คุณคือใคร')),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                  top: 25,
                                ),
                                child: Container(
                                  // color: Colors.pink,
                                  child: Column(
                                    children: fList
                                        .map((data) => RadioListTile(
                                              title: Text("${data.name}"),
                                              groupValue: id,
                                              value: data.index,
                                              onChanged: (val) {
                                                setState(() {
                                                  // radioItem = data.type;
                                                  id = data.index;

                                                  selectType = data.type;
                                                  print(selectType);
                                                });
                                              },
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                              //),
                            ],
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
                              Text('คุณยอมรับว่ามีอายุมากกว่า 18 ปี')
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
                                            S.of(context).registerbutton,
                                            Colors.white,
                                            FontWeight.w900,
                                            ConstantData.font15Px),
                                  ),
                                )),
                            onTap: () {
                              // Navigator.pushNamed(context, '/tabwidget');
                              if (!_value) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'กรุณายอมรับว่าคุณมีอายุ มากกว่า 18 ปี')));
                              } else if (confirmpasswordController.text
                                      .toString()
                                      .trim() !=
                                  passwordController.text.toString().trim()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Password   ไม่ตรงกัน')));
                              } else {
                                validateRegister(context);
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

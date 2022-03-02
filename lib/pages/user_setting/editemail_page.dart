import 'package:flutter/material.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/user_response_model.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/utils/utils.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class EditEmailPage extends StatefulWidget {
  late List<UserData> userList = [];
  late String userId;
  late String userName;
  late String userType;
  EditEmailPage(
      {Key? key,
      required this.userList,
      required this.userId,
      required this.userName,
      required this.userType})
      : super(key: key);

  @override
  State<EditEmailPage> createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage> {
  TextEditingController oldEmailController = new TextEditingController();
  TextEditingController newEmailController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }
    toValidateEmail(BuildContext context) async {
    FormState? form = await formKey.currentState;
    form!.save();
    if (!form.validate()) {
      print('Invalid Email');
    } else {
      print('Credentials are valid');

      toSaveChangeEmail(context);
    }
  }
  
   toSaveChangeEmail(BuildContext context) async {
    var data = {
      "user_id": widget.userId,
      "user_user_id": newEmailController.text,
       "user_password": confirmPasswordController.text
    };
    try {
      Uri url = Uri.parse('http://127.0.0.1:3000/api/user/rename-email'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      // print(widget.userId);
      if (response.statusCode == 200) {
        print(response.body);

   

         ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('เปลี่ยน Email สำเร็จ')));
            Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('เปลี่ยนชื่อไม่สำเร็จ Email ซ้ำ หรือ รหัสผ่านไม่ถูกต้อง')));
      }
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    oldEmailController.text = widget.userList[0].userUserId.toString();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double editTextHeight = MediaQuery.of(context).size.height * 0.06;
    /*return WillPopScope(
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
        body: Center(
          child: Container(
            // color: Colors.pink,
            width: 450,
            height: 500,
            /* margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.02,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,

             
            ),*/

            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ConstantWidget.getCustomTextWithoutAlign(
                      S.of(context).editemail,
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
                  child: TextField(
                    maxLines: 1,
                    controller: emailController,
                    // controller:  S.of(context).documentNo.toString(),
                    style: TextStyle(
                        fontFamily: ConstantData.fontFamily,
                        color: ConstantData.primaryTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),

                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                        const Radius.circular(5),
                      )),
                      labelText: S.of(context).oldemail,
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
                  child: TextField(
                    maxLines: 1,
                    controller: emailController,
                    // controller:  S.of(context).documentNo.toString(),
                    style: TextStyle(
                        fontFamily: ConstantData.fontFamily,
                        color: ConstantData.primaryTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),

                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                        const Radius.circular(5),
                      )),
                      labelText: S.of(context).newemail,
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
                  child: TextField(
                    maxLines: 1,
                    controller: emailController,
                    // controller:  S.of(context).documentNo.toString(),
                    style: TextStyle(
                        fontFamily: ConstantData.fontFamily,
                        color: ConstantData.primaryTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),

                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                        const Radius.circular(5),
                      )),
                      labelText: S.of(context).confirmpassword,
                      // hintText: 'Full Name',
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                      margin: EdgeInsets.only(top: 20),
                      height: 50,
                      decoration: BoxDecoration(
                          color: ConstantData.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: InkWell(
                        child: Center(
                          child: ConstantWidget.getCustomTextWithoutAlign(
                              S.of(context).save,
                              Colors.white,
                              FontWeight.w900,
                              ConstantData.font15Px),
                        ),
                      )),
                  onTap: () {
                    // PrefData.setIsSignIn(true);

                    /* Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TabWidget(),
                          ),
                        );*/
                    //  Navigator.pushNamed(context, '/nav');
                    /* Navigator.pushReplacementNamed(
                          context,
                          '/nav'
                        );*/
                    /* Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => NavPage()));*/
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: _requestPop,
    );
*/
    // onWillPop: () async => null,
    //);

    return WillPopScope(
      child: new Scaffold(
       
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
                            child: ConstantWidget.getCustomTextWithoutAlign(
                                S.of(context).editemail,
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
                              enabled: false, 
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Old Email is Required';
                                }
                                if (!RegExp(
                                        r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                                    .hasMatch(value)) {
                                  return 'Please enter a valid Email';
                                }
                                return null;
                              },
                              maxLines: 1,
                              controller: oldEmailController,
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
                                labelText: S.of(context).oldemail,
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
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'New Email is Required';
                                }
                                if (!RegExp(
                                        r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                                    .hasMatch(value)) {
                                  return 'Please enter a valid Email';
                                }
                                return null;
                              },
                              maxLines: 1,
                              controller: newEmailController,
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
                                labelText: S.of(context).newemail,
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

                              toValidateEmail(context);
                             
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

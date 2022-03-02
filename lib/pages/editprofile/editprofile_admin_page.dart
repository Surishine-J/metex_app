import 'package:flutter/material.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/utils/utils.dart';

class EditProfileAdminPage extends StatefulWidget {
  const EditProfileAdminPage({Key? key}) : super(key: key);

  @override
  _EditProfileAdminPageState createState() => _EditProfileAdminPageState();
}

class _EditProfileAdminPageState extends State<EditProfileAdminPage> {
  TextEditingController emailController = new TextEditingController();
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
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
                      S.of(context).editprofileadmin,
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
                      labelText: S.of(context).name,
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
                    // Navigator.pushNamed(context, '/register');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: _requestPop,
    );
  }
}

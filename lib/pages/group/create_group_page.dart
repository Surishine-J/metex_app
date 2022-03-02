import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/utils/utils.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  TextEditingController emailController = new TextEditingController();

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return new Future.value(false);
  }

  late String _selectedValue = 'ชาย';
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
                           // 
                            height: editTextHeight,
                           padding: EdgeInsets.only(left: 146, right: 146),
                            /*decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(),
                              color: Colors.cyanAccent),*/

                            //   margin: EdgeInsets.only(bottom: 10, top: 10,left: 20, right: 20),
                            // height: editTextHeight,
                            decoration: BoxDecoration(
                              //color: Colors.red,
                              color: ConstantData.bgColor,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: ConstantData.kGreyTextColor),
                              /* border: Border.all(
                                color: ConstantData.lightGrey, width: .5),*/
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                // isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down,
                                    color: Colors.grey.withOpacity(0.7)),
                                items: items,
                                onChanged: (String? value) {
                                  /* setState(() {
                          _selectedValue = value!;
                        });*/
                                  print('----- value ------');
                                  print(_selectedValue);
                                  print(editTextHeight);
                                },
                                hint: Text(
                                  "---- เลือกหัวหน้ากลุ่ม ----",
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
                              // PrefData.setIsSignIn(true);

                              /* Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TabWidget(),
                                    ),
                                  );*/
                             //  Navigator.pushNamed(context, '/groupdetails');
                              /* Navigator.pushReplacementNamed(
                                    context,
                                    '/nav'
                                  );*/
                               /*Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => RegisterPage()));*/
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

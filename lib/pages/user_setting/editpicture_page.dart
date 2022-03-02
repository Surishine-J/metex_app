import 'package:flutter/material.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/utils/utils.dart';

class EditPicturePage extends StatefulWidget {
  EditPicturePage({Key? key}) : super(key: key);

  @override
  State<EditPicturePage> createState() => _EditPicturePageState();
}

class _EditPicturePageState extends State<EditPicturePage> {
  TextEditingController emailController = new TextEditingController();
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }
   

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double editTextHeight = MediaQuery.of(context).size.height * 0.06;
    return
         WillPopScope(
        child:
        Scaffold(
      backgroundColor: ConstantData.bgColor,
     /* appBar: AppBar(
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
      ),*/
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
                    S.of(context).editpicture,
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
             

               Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  /*child: Image(
                    image: AssetImage('images/propic.png'),
                  ),*/
                  child: Icon(Icons.add_a_photo,size: 100,color: ConstantData.kGreyTextColor,),
                 /* onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        height: 200.0,
                        width: MediaQuery.of(context).size.width - 80,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.photo_library_rounded,
                                    size: 60.0,
                                   // color: kMainColor,
                                  // color:Colors.pink
                                  color: ConstantData.kGreyTextColor,
                                  ),
                                  Text(
                                    'Gallery',
                                   /* style: GoogleFonts.poppins(
                                      fontSize: 20.0,
                                      color: kMainColor,
                                    ),*/
                                  ),
                                ],
                              ),
                             /* SizedBox(
                                width: 40.0,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera,
                                    size: 60.0,
                                    color: ConstantData.kGreyTextColor,
                                  ),
                                  Text(
                                    'Camera',
                                    /*style: GoogleFonts.poppins(
                                      fontSize: 20.0,
                                      color: kGreyTextColor,
                                    ),*/
                                  ),
                                ],
                              ),*/
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),*/
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
   
    // onWillPop: () async => null,
    //);




  }
}

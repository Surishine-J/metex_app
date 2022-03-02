import 'package:flutter/material.dart';
import 'package:metex_app/data/data.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/experts_model.dart';
import 'package:metex_app/models/models.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/utils/utils.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }
  List<List<ExpertModel>> allCatList = [DataFile.getAllExpertModel()];
//  List<SubCategoryModel> subList = [];
  List<ExpertModel> subList = [];
  List<String> selectionList = [
    "Coach",
    "Trainer",
    "Consultant",
  ];
   int selectedPos = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    subList = [];
    subList = allCatList[selectedPos];
    var cellHeight = SizeConfig.safeBlockHorizontal! * 58;

    double cellMargin = 7;

    var _crossAxisSpacing = 8.0;

    var bottomDialogTextSizeFilter = SizeConfig.safeBlockVertical! * 55;
    var cellHeight2 =
        ConstantWidget.getPercentSize1(bottomDialogTextSizeFilter, 13);
    var _screenWidth = MediaQuery.of(context).size.width;

    var _crossAxisCount = 2;

    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    var _aspectRatio = _width / cellHeight;

    // double editTextHeight = MediaQuery.of(context).size.height * 0.06;
    double mainCatWidth = (SizeConfig.safeBlockHorizontal! * 50) -
        (cellMargin * 2 + _crossAxisSpacing);
    double mainCatHeight = cellHeight;
    double topCellHeight = ConstantWidget.getPercentSize(cellHeight, 12);
    double imageSize = SizeConfig.safeBlockVertical! * 6.5;
    double bottomRemainSize = cellHeight - imageSize - topCellHeight;

   /* return new MaterialApp(
      // title: 'SingleChildScrollView Demo',
      home: WillPopScope(
        onWillPop: _requestPop,
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
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                     Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                      Center(
                  child: ConstantWidget.getCustomTextWithoutAlign(
                      S.of(context).aboutus,
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
                Center(
                  child: ConstantWidget.getCustomTextWithoutAlign(
                      S.of(context).msg_aboutus,
                      // Colors.black,
                      ConstantData.primaryColor,
                      FontWeight.w100,
                      16.0),
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
              )),
        ),
      ),
    );
  */
 
 
  return WillPopScope(
        onWillPop: _requestPop,
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
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                     Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                      Center(
                  child: ConstantWidget.getCustomTextWithoutAlign(
                      S.of(context).aboutus,
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
                Center(
                  child: ConstantWidget.getCustomTextWithoutAlign(
                      S.of(context).msg_aboutus,
                      // Colors.black,
                      ConstantData.primaryColor,
                      FontWeight.w100,
                      16.0),
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
              )),
        ),
      
    );
  
  }
}

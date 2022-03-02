import 'package:flutter/material.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/utils/utils.dart';

class GroupDetailsPage extends StatefulWidget {
  const GroupDetailsPage({ Key? key }) : super(key: key);

  @override
  _GroupDetailsPageState createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {

   Future<bool> _requestPop() {
    Navigator.of(context,rootNavigator: true).pop();
    return new Future.value(false);
  }
  @override
   Widget build(BuildContext context) {
    SizeConfig().init(context);
   
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

   

    // double editTextHeight = MediaQuery.of(context).size.height * 0.06;
    double mainCatWidth = (SizeConfig.safeBlockHorizontal! * 50) -
        (cellMargin * 2 + _crossAxisSpacing);
    double mainCatHeight = cellHeight;
    double topCellHeight = ConstantWidget.getPercentSize(cellHeight, 12);
    double imageSize = SizeConfig.safeBlockVertical! * 6.5;
    double bottomRemainSize = cellHeight - imageSize - topCellHeight;

    return WillPopScope(
         
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
                       // S.of(context).aboutus,
                       "รายละเอียดกลุ่ม",
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
        
         onWillPop: _requestPop,
      
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metex_app/data/data.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/group_model.dart';
import 'package:metex_app/models/models.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/utils/utils.dart';

class GroupAfterLoginPage extends StatefulWidget {
   
  GroupAfterLoginPage({Key? key,}) : super(key: key);

  @override
  State<GroupAfterLoginPage> createState() => _GroupAfterLoginPageState();
}

class _GroupAfterLoginPageState extends State<GroupAfterLoginPage> {
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  List<List<GroupModel>> allCatList = [DataFile.getGroupModel()];
//  List<SubCategoryModel> subList = [];
  List<GroupModel> subList = [];

  int selectedPos = 0;

  TextEditingController emailController = new TextEditingController();

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

    return new MaterialApp(
        debugShowCheckedModeBanner: false,
      // title: 'SingleChildScrollView Demo',
     home: WillPopScope(//WillPopScope
      
        child: new Scaffold(
          //  home: new Scaffold(
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
                    Container(
                      child: ConstantWidget.getCustomTextWithoutAlign(
                          S.of(context).group,
                          // Colors.black,
                          ConstantData.primaryColor,
                          FontWeight.w900,
                          36.0),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    InkWell(
                      child: Container(
                        //  margin: EdgeInsets.only(top: 20),
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            color: ConstantData.blueColor,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 20,
                              color: ConstantData.whiteColor,
                            ),
                            /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                            SizedBox(
                              width: 10,
                            ),
                            ConstantWidget.getCustomTextWithoutAlign(
                                S.of(context).creategroup,
                                ConstantData.whiteColor,
                                FontWeight.w900,
                                ConstantData.font15Px),
                          ],
                        ),
                      ),
                      onTap: () {
                       // Navigator.pushNamed(context,'/creategroup');
                      /*  Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => CreateGroupPage()));*/
                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateGroupPage()));
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      primary: true,
                      /* mainAxisSpacing: _crossAxisSpacing2,
                      padding: EdgeInsets.symmetric(
                          vertical: cellMargin2,
                          horizontal: cellMargin2 + _crossAxisSpacing2),
                      crossAxisCount: 4, //_crossAxisCount2,
                      crossAxisSpacing: _crossAxisSpacing2,
                      childAspectRatio: _aspectRatio2,*/
                      padding: EdgeInsets.symmetric(
                        vertical: cellMargin,
                        horizontal: cellMargin + _crossAxisSpacing,
                      ),
                      mainAxisSpacing: 15.0, // ช่องว่างแนวนอน
                      crossAxisSpacing: 15.0, // ช่องว่างแนวตั้ง
                      crossAxisCount: Responsive.isMobile(context)
                          ? 2
                          : Responsive.isTablet(context)
                              ? 4
                              : Responsive.isDesktop(context)
                                  ? 6
                                  : 3,
                      childAspectRatio: 0.7,

                      children: List.generate(
                        subList.length,
                        (index) {
                        //  print( "sizes===$mainCatWidth==$mainCatHeight--$_aspectRatio");
                          GroupModel _subCatModle = subList[index];
                          return InkWell(

                            onTap: (){
                               // Navigator.pushNamed(context, '/groupdetails');
                                Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GroupDetailsPage()));
                            },
                            /*onTap: () {
                                  if (selectedFilterList != null &&
                                      selectedFilterList
                                          .contains(filterList[index])) {
                                    selectedFilterList.remove(filterList[index]);
                                  } else {
                                    selectedFilterList.add(filterList[index]);
                                  }
                                  setState(() {});
                                },*/
                            child: Container(
                              width: double.infinity,
                              height: cellHeight2,
                              child: Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(7),
                                            topRight: Radius.circular(7)),
                                        color: ConstantData.whiteColor,
                                        border: Border.all(
                                            // color: Colors.blue,
                                            color: ConstantData.whiteColor,
                                            width: 1.0),
                                        image: DecorationImage(
                                            image: AssetImage(
                                              // 'assets/images/image.jpg'
                                              ConstantData.assetsImagePath +
                                                  _subCatModle.imagegroup[0],
                                            ),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  AspectRatio(
                                    aspectRatio: 2.5,
                                    child: Container(
                                      // height: 150,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(7),
                                            bottomRight: Radius.circular(7),
                                          ),
                                          color: ConstantData.whiteColor,
                                          border: Border.all(
                                              // color: Colors.yellow,
                                              color: ConstantData.whiteColor,
                                              width: 1.0)),
                                      //child: Text('Item ${index}'),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                          ),
                                          /* ConstantWidget.getSpace(
                                                        ConstantWidget.getPercentSize1(
                                                            mainCatHeight, 2.5)),*/
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: ConstantData
                                                            .kGreyTextColor),
                                                    color:
                                                        ConstantData.whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: Icon(
                                                  Icons.group,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              ConstantWidget.getCustomText(
                                                  _subCatModle.groupname,
                                                  ConstantData.textColor,
                                                  1,
                                                  TextAlign.start,
                                                  FontWeight.bold,
                                                  ConstantWidget
                                                      .getPercentSize1(
                                                          mainCatHeight, 8)),
                                            ],
                                          ),
                                          /* Padding(
                                            padding: EdgeInsets.only(bottom: 20),
                                          ),*/
                                          /* ConstantWidget.getSpace(
                                                        ConstantWidget.getPercentSize1(
                                                            mainCatHeight, 2.5)),*/

                                          /* ConstantWidget.getSpace(
                                                          ConstantWidget
                                                              .getPercentSize1(
                                                                  mainCatHeight, 1.2)),*/
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
              )),
        ),
        //  onWillPop: _requestPop,
        onWillPop: () async {
            return false;
          }
     ),
    );
  }
}

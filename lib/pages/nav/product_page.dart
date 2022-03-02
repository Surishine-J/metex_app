
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metex_app/data/data.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/models.dart';
import 'package:metex_app/utils/utils.dart';

class ProductPage2 extends StatefulWidget {
  ProductPage2({Key? key}) : super(key: key);

  @override
  _ProductPage2State createState() => _ProductPage2State();
}

class _ProductPage2State extends State<ProductPage2> {
  List<List<SubCategoryModel>> allCatList = [
  //  DataFile.getAllCategoryModel(),
    DataFile.getBeerCategoryModel(),
    DataFile.getWineModel(),
   // DataFile.getAllExpertModel()
  ];
  List<SubCategoryModel> subList = [];
  List<String> selectionList = [
    "ทั้งหมด",
    "เบียร์",
    "ไวน์",
    "สุรา",
    "น้ำดื่ม",
    // "บรั่นดี",
    // "วอดก้า"
  ];

  int selectedPos = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    subList = [];
    subList = allCatList[selectedPos];
    double cellMargin2 = 7;
    double cellMargin = 7;
    var bottomDialogTextSize = SizeConfig.safeBlockVertical! * 45;
    var bottomDialogTextSizeFilter = SizeConfig.safeBlockVertical! * 55;
    var _crossAxisSpacing2 = 8.0;
    var _crossAxisSpacing = 8.0;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount2 = 3;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var _width2 =
        (_screenWidth - ((_crossAxisCount2 - 1) * _crossAxisSpacing2)) /
            _crossAxisCount2;
    var cellHeight = SizeConfig.safeBlockHorizontal! * 58;
    var cellHeight2 =
        ConstantWidget.getPercentSize1(bottomDialogTextSizeFilter, 13);
    var _aspectRatio = _width / cellHeight;
    var _aspectRatio2 = _width2 / cellHeight2;
    double mainCatWidth = (SizeConfig.safeBlockHorizontal! * 50) -
        (cellMargin * 2 + _crossAxisSpacing);
    double mainCatHeight = cellHeight;
    double topSliderWidth = SizeConfig.safeBlockHorizontal! * 23;
    double topSliderHeight = SizeConfig.safeBlockHorizontal! * 13;
    double imageSize = SizeConfig.safeBlockVertical! * 6.5;
    double imageSize1 = SizeConfig.safeBlockVertical! * 2.5;
    double marginSearch = SizeConfig.safeBlockHorizontal! * 5;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: ConstantData.bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          /* title: getCustomText(S.of(context).shopping, textColor, 1,
              TextAlign.start, FontWeight.w500, 18),*/
          title: ConstantWidget.getAppBarText(S.of(context).productList),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: marginSearch,
                        right: marginSearch,
                        bottom: marginSearch),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            height: imageSize,
                            decoration: new BoxDecoration(
                                // color: cardColor,
                                color: ConstantData.whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(1, 1),
                                    blurRadius: 1,
                                  )
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextField(
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: ConstantData.fontFamily,
                                  // color: primaryTextColor,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: ConstantWidget.getPercentSize1(
                                      imageSize, 30.0)),
                              decoration: InputDecoration(
                                //hintText: S.of(context).search,
                                 hintText: 'ค้นหา',
                                /*hintStyle: TextStyle(
                                fontFamily: Constants.fontsFamily,
                                color: primaryTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize:
                                    Constants.getPercentSize(imageSize, 30),
                              ),*/
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(top: 3, left: 8),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          child: Container(
                              // color: Colors.green,
                              height: imageSize,
                              width: imageSize,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: ConstantData.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: InkWell(
                                child: Center(
                                    child: Icon(
                                  CupertinoIcons.search,
                                  color: ConstantData.whiteColor,
                                  size: imageSize1,
                                )),
                                onTap: () {},
                              )),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.red,
                    height: topSliderHeight,
                    child: ListView.builder(
                      primary: false,
                      padding: EdgeInsets.all(
                          ConstantWidget.getPercentSize1(topSliderWidth, 5)),
                      itemCount: selectionList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedPos = index;
                            });
                          },
                          child: Container(
                            width: topSliderWidth,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: (selectedPos == index)
                                    ? ConstantData.primaryColor
                                    : ConstantData.lightPrimaryColors),
                            margin: EdgeInsets.all(
                                ConstantWidget.getPercentSize1(
                                    topSliderWidth, 5)),
                            child: Align(
                              alignment: Alignment.center,
                              child: ConstantWidget.getCustomText(
                                  selectionList[index],
                                  (selectedPos == index)
                                      ? Colors.white
                                      : ConstantData.primaryColor,
                                  1,
                                  TextAlign.center,
                                  FontWeight.w500,
                                  ConstantWidget.getPercentSize1(
                                      topSliderHeight, 25)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      padding: EdgeInsets.symmetric(
                          vertical: cellMargin,
                          horizontal: cellMargin + _crossAxisSpacing),
                      crossAxisCount: _crossAxisCount,
                      crossAxisSpacing: _crossAxisSpacing,
                      childAspectRatio: _aspectRatio,
                      children: List.generate(
                        subList.length,
                        (index) {
                          print(
                              "sizes===$mainCatWidth==$mainCatHeight--$_aspectRatio");
                          SubCategoryModel _subCatModle = subList[index];

                          return InkWell(
                            onTap: () {
                              /*  Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetail(_subCatModle),
                              ));*/
                            },
                            child: Container(
                              width: mainCatWidth,
                              height: mainCatHeight,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  // color: cardColor,
                                  color: ConstantData.whiteColor,
                                  //  color: Colors.green,
                                  boxShadow: [
                                    BoxShadow(
                                        color: ConstantData.shadowColor,
                                        blurRadius: 2)
                                  ]
                                  // border: Border.all(color: Colors.grey, width: 1)
                                  ),
                              margin: EdgeInsets.all(
                                  ConstantWidget.getPercentSize(
                                      mainCatHeight, 3)),
                              padding: EdgeInsets.all(
                                  ConstantWidget.getPercentSize(
                                      mainCatHeight, 5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      child: Image.asset(
                                        ConstantData.assetsImagePath +
                                            _subCatModle.image[0],
                                        fit: BoxFit.cover,
                                        width: double.infinity, //100
                                        height: double.infinity, //100
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  ConstantWidget.getSpace(
                                      ConstantWidget.getPercentSize1(
                                          mainCatHeight, 2.5)),
                                  ConstantWidget.getCustomText(
                                      _subCatModle.name,
                                      ConstantData.textColor,
                                      1,
                                      TextAlign.start,
                                      FontWeight.w400,
                                      ConstantWidget.getPercentSize1(
                                          mainCatHeight, 7)),
                                  Row(
                                    children: [
                                      ConstantWidget.getSpace(
                                          ConstantWidget.getPercentSize1(
                                              mainCatHeight, 1.2)),
                                      ConstantWidget.getCustomText(
                                        _subCatModle.priceCurrency +
                                            _subCatModle.price.toString(),
                                        // colorOrange,
                                        ConstantData.redColor,
                                        1,
                                        TextAlign.start,
                                        FontWeight.w600,
                                        ConstantWidget.getPercentSize1(
                                            mainCatHeight, 8),
                                      ),
                                      // SizedBox(width: 20,),
                                      ConstantWidget.getSpace1(),
                                      

                                      Text('เหลือ  10  ขวด')
                                      /*Text('99',
                                       /* _subCatModle.priceCurrency +
                                            (_subCatModle.price -
                                                    Constants.discountVal)
                                                .toString(),*/
                                        style: TextStyle(
                                            color: ConstantData.primaryTextColor,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontFamily: ConstantData.fontFamily,
                                            fontSize: ConstantWidget.getPercentSize1(
                                                mainCatHeight, 6),
                                            fontWeight: FontWeight.w600),
                                        maxLines: 1,
                                      )*/
                                    ],
                                  ),

                                  /* ConstantWidget.getSpace(ConstantWidget.getPercentSize1(
                                      mainCatHeight, 2.5)),*/
                                  /*Row(
                                    children: [
                                      
                                      Text('คงเหลือ 10 ขวด',textAlign: TextAlign.end,)
                      
                                    ],
                                  ),*/
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    flex: 1,
                  )
                ],
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        finish();
        return false;
      },
    );
  }

  void finish() {
    Navigator.of(context).pop();
  }
}

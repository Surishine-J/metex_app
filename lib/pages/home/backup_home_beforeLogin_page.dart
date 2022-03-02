// import 'package:flutter/material.dart';
// import 'package:metex_app/data/data.dart';
// import 'package:metex_app/generated/l10n.dart';
// import 'package:metex_app/models/api_respose.dart';
// import 'package:metex_app/models/experts_model.dart';
// import 'package:metex_app/models/models.dart';

// import 'package:metex_app/pages/pages.dart';
// import 'package:metex_app/services/zone_services.dart';
// import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;

// import 'package:metex_app/utils/utils.dart';

// class BackupHomeBeforeLoginPage extends StatefulWidget {
//   const BackupHomeBeforeLoginPage({Key? key}) : super(key: key);

//   @override
//   _BackupHomeBeforeLoginPageState createState() => _BackupHomeBeforeLoginPageState();
// }

// class _BackupHomeBeforeLoginPageState extends State<BackupHomeBeforeLoginPage> {
//   Future<bool> _requestPop() {
//     Navigator.of(context).pop();
//     return new Future.value(false);
//   }

//   Future<void> getDataCovid() async {
//     print('object');
//     var url = Uri.parse(
//         // 'http://www.nextflow.in.th/api/covid19/getTodayCases.json');
//         'https://covid19.th-stat.com/json/covid19v2/getTodayCases.json');
//     var response = await http.get(url);
//     print(response.body);
//     return;
//   }

//   List<List<ExpertModel>> allCatList = [
//     // DataFile.getAllCategoryModel(),
//     // DataFile.getBeerCategoryModel(),
//     // DataFile.getWineModel(),
//     DataFile.getAllExpertModel()
//   ];
// //  List<SubCategoryModel> subList = [];
//   List<ExpertModel> subList = [];
//   List<String> selectionList = [
//     // "ทั้งหมด",
//     "Coach",
//     "Trainer",
//     "Consultant",
//   ];
//   List<String> selectedFilterList = [];
//   List<String> filterList = [
//     "Teambuilding",
//     "Leadership",
//     "Communication",
//     "Performance Management",
//     "career Growth",
//     "Mind set",
//     "อื่นๆ",
//   ];

//   late String _selectedValue = 'ชาย';
//   List<DropdownMenuItem<String>> items = [
//     'ชาย',
//     'หญิง',
//   ].map<DropdownMenuItem<String>>((String value) {
//     return DropdownMenuItem<String>(
//       value: value,
//       child: Text(
//         value,
//         style: TextStyle(color: Colors.black, fontSize: 14),
//       ),
//     );
//   }).toList();

//   int selectedCareer = 0;
//   // TextEditingController emailController = new TextEditingController();

//   TextEditingController emailController = new TextEditingController();

//   List<LocationModel> location = [];
//   List<CareerTypeDataModel> careerTypeDataList = [];

//   getDataZone() async {
//     var response = await http.get(
//       Uri.parse('http://127.0.0.1:3000/api/zone/all'), //url on web
//      //  Uri.parse('http://10.0.2.2:3000/api/zone/all'),
//     );
//     if (response.statusCode == 200) {
//       final ZoneModel zoneModel =
//           ZoneModel.fromJson(convert.jsonDecode(response.body));
//       setState(() {
//         location = zoneModel.data;
//         //print(location);
//       });
//     } else {
//       print('Error');
//     }
//   }

//   getDataExpertType() async {
//     var response = await http.get(
//       Uri.parse('http://localhost:3000/api/user/usertype2/all'),
//     );
//     if (response.statusCode == 200) {
//       final CareerTypeModel careerTypeModel =
//           CareerTypeModel.fromJson(convert.jsonDecode(response.body));
//       setState(() {
//         careerTypeDataList = careerTypeModel.data;
//        // print(response.body);
//       });
//     } else {
//       print('Error');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     // ZoneServices().getzones();
//     //getDataCovid();
//     getDataZone();
//     getDataExpertType();
//   }

//  // List<ZoneModel> _categoryList = <ZoneModel>[];

//   LocationModel? dropdownValue;

//   //late String _selectedValue = 'ชาย';
//   List<DropdownMenuItem<String>> zones = [
//     'ชาย',
//     'หญิง',
//   ].map<DropdownMenuItem<String>>((String value) {
//     return DropdownMenuItem<String>(
//       value: value,
//       child: Text(
//         value,
//         style: TextStyle(color: Colors.black, fontSize: 14),
//       ),
//     );
//   }).toList();

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     subList = [];
//     subList = allCatList[selectedCareer];
//     var cellHeight = SizeConfig.safeBlockHorizontal! * 58;
//     double cellMargin2 = 7;
//     double cellMargin = 7;

//     var _crossAxisSpacing2 = 8.0;
//     var _crossAxisSpacing = 8.0;
//     var _crossAxisCount2 = 3;

//     var bottomDialogTextSizeFilter = SizeConfig.safeBlockVertical! * 55;
//     var cellHeight2 =
//         ConstantWidget.getPercentSize1(bottomDialogTextSizeFilter, 13);
//     var _screenWidth = MediaQuery.of(context).size.width;

//     var _crossAxisCount = 2;
//     var _width2 =
//         (_screenWidth - ((_crossAxisCount2 - 1) * _crossAxisSpacing2)) /
//             _crossAxisCount2;
//     var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
//         _crossAxisCount;
//     var _aspectRatio2 = _width2 / cellHeight2;
//     var _aspectRatio = _width / cellHeight;

//     // double editTextHeight = MediaQuery.of(context).size.height * 0.06;
//     double mainCatWidth = (SizeConfig.safeBlockHorizontal! * 50) -
//         (cellMargin * 2 + _crossAxisSpacing);
//     double mainCatHeight = cellHeight;
//     double topCellHeight = ConstantWidget.getPercentSize(cellHeight, 12);
//     double imageSize = SizeConfig.safeBlockVertical! * 6.5;
//     double bottomRemainSize = cellHeight - imageSize - topCellHeight;
//     double topSliderWidth = SizeConfig.safeBlockHorizontal! * 23;
//     double topSliderHeight = SizeConfig.safeBlockHorizontal! * 13;

//     double editTextHeight = MediaQuery.of(context).size.height * 0.06;

//     return WillPopScope(
//       child: new Scaffold(
//         /*appBar: AppBar(
//             title: new Text('SingleChildScrollView Demo'),
//           ),*/
//         body: new SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: Container(
//               // color: Colors.yellow,
//               margin: EdgeInsets.only(
//                 // bottom: MediaQuery.of(context).size.height * 0.02,
//                 left: MediaQuery.of(context).size.width * 0.05,
//                 right: MediaQuery.of(context).size.width * 0.05,
//                 //  left: MediaQuery.of(context).size.width * 0.07,
//                 // right: MediaQuery.of(context).size.width * 0.07,
//               ),
//               child: new Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 20),
//                   ),
//                   Center(
//                     child: ConstantWidget.getCustomTextWithoutAlign(
//                         S.of(context).expertmsg,
//                         // Colors.black,
//                         ConstantData.primaryColor,
//                         FontWeight.w900,
//                         26.0),
//                   ),
//                   Container(
//                     // color: Colors.red,
//                     height: topSliderHeight,
//                     /*child: ListView.builder(
//                       primary: false,
//                       shrinkWrap: true,
//                       padding: EdgeInsets.all(
//                           ConstantWidget.getPercentSize1(topSliderWidth, 5)),
//                       itemCount: selectionList.length,
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (context, index) {
//                         return InkWell(
//                           /*onTap: () {
//                                   setState(() {
//                                     selectedPos = index;
//                                   });
//                                 },*/
//                           child: Container(
//                             width: topSliderWidth,
//                             decoration: BoxDecoration(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)),
//                                 color: (selectedPos == index)
//                                     ? ConstantData.primaryColor
//                                     : ConstantData.lightPrimaryColors),
//                             margin: EdgeInsets.all(
//                                 ConstantWidget.getPercentSize1(
//                                     topSliderWidth, 5)),
//                             child: Align(
//                               alignment: Alignment.center,
//                               child: ConstantWidget.getCustomText(
//                                   selectionList[index],
//                                   (selectedPos == index)
//                                       ? Colors.white
//                                       : ConstantData.primaryColor,
//                                   1,
//                                   TextAlign.center,
//                                   FontWeight.w500,
//                                   ConstantWidget.getPercentSize1(
//                                       topSliderHeight, 25)),
//                             ),
//                           ),
//                         );
//                       },
//                     ),*/

//                     child: ListView.builder(
//                       primary: false,
//                       shrinkWrap: true,
//                       padding: EdgeInsets.all(
//                           ConstantWidget.getPercentSize1(topSliderWidth, 5)),
//                       itemCount: careerTypeDataList.length,
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (context, index) {
//                         return InkWell(
//                           /*onTap: () {
//                                   setState(() {
//                                     selectedPos = index;
//                                   });
//                                 },*/
//                           child: Container(
//                             width: topSliderWidth,
//                             decoration: BoxDecoration(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)),
//                                 color: (selectedCareer == index)
//                                     ? ConstantData.primaryColor
//                                     : ConstantData.lightPrimaryColors),
//                             margin: EdgeInsets.all(
//                                 ConstantWidget.getPercentSize1(
//                                     topSliderWidth, 5)),
//                             child: Align(
//                               alignment: Alignment.center,
//                               child: ConstantWidget.getCustomText(
//                                   careerTypeDataList[index].user_type2_name.toString(),
//                                   (selectedCareer == index)
//                                       ? Colors.white
//                                       : ConstantData.primaryColor,
//                                   1,
//                                   TextAlign.center,
//                                   FontWeight.w500,
//                                   ConstantWidget.getPercentSize1(
//                                       topSliderHeight, 25)),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Center(
//                     child: ConstantWidget.getCustomTextWithoutAlign(
//                       "Test",
//                        // S.of(context).expertmsg2,
//                         // Colors.black,
//                         ConstantData.primaryColor,
//                         FontWeight.w900,
//                         20.0),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 20),
//                   ),
//                   Center(
//                     child: ConstantWidget.getCustomTextWithoutAlign(
//                         S.of(context).expertmsg3,
//                         // Colors.black,
//                         ConstantData.primaryColor,
//                         FontWeight.normal,
//                         18.0),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 20),
//                   ),
//                   GridView.count(
//                     shrinkWrap: true,
//                     primary: true,
//                     mainAxisSpacing: _crossAxisSpacing2,
//                     padding: EdgeInsets.symmetric(
//                         vertical: cellMargin2,
//                         horizontal: cellMargin2 + _crossAxisSpacing2),
//                     crossAxisCount: 4, //_crossAxisCount2,
//                     crossAxisSpacing: _crossAxisSpacing2,
//                     childAspectRatio: _aspectRatio2,
//                     children: List.generate(
//                       filterList.length,
//                       (index) {
//                         // print( "sizes===$mainCatWidth==$mainCatHeight--$_aspectRatio");
//                         return InkWell(
//                           onTap: () {
//                             if (selectedFilterList != null &&
//                                 selectedFilterList
//                                     .contains(filterList[index])) {
//                               selectedFilterList.remove(filterList[index]);
//                             } else {
//                               selectedFilterList.add(filterList[index]);
//                             }
//                             setState(() {});
//                           },
//                           child: Container(
//                             width: double.infinity,
//                             height: cellHeight2,
//                             decoration: BoxDecoration(
//                                 color: ConstantData.bgColor,
//                                 //lightPrimaryColors,
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(7)),
//                                 border: Border.all(
//                                     color: (selectedFilterList != null &&
//                                             selectedFilterList
//                                                 .contains(filterList[index]))
//                                         ? ConstantData
//                                             .primaryColor //accentColors
//                                         : ConstantData
//                                             .kGreyTextColor, //Colors.transparent,
//                                     width: 1)),
//                             child: Center(
//                               child: ConstantWidget.getCustomText(
//                                   filterList[index],
//                                   ConstantData.textColor,
//                                   1,
//                                   TextAlign.center,
//                                   FontWeight.w500,
//                                   ConstantWidget.getPercentSize1(
//                                       cellHeight2, 25)),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 20),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         //margin: EdgeInsets.only(bottom: 10, top: 10),
//                         height: editTextHeight,
//                         width: 300,
//                         child: TextField(
//                           maxLines: 1,
//                           controller: emailController,
//                           // controller:  S.of(context).documentNo.toString(),
//                           style: TextStyle(
//                               fontFamily: ConstantData.fontFamily,
//                               color: ConstantData.primaryTextColor,
//                               fontWeight: FontWeight.normal,
//                               fontSize: 14),

//                           decoration: InputDecoration(
//                             contentPadding: const EdgeInsets.symmetric(
//                                 vertical: 25.0, horizontal: 10.0),
//                             // floatingLabelBehavior: FloatingLabelBehavior.always,
//                             border: OutlineInputBorder(
//                               borderRadius: const BorderRadius.all(
//                                 const Radius.circular(5),
//                               ),
//                             ),
//                             // border: InputBorder.none,
//                             // labelText: S.of(context).searchbyname,
//                             hintText: S.of(context).searchbyname,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),

//                       Container(
//                         // height: 40.0,
//                         height: editTextHeight,
//                         padding: EdgeInsets.only(left: 100, right: 100),

//                         decoration: BoxDecoration(
//                           color: ConstantData.bgColor,
//                           borderRadius: BorderRadius.circular(8),
//                           border:
//                               Border.all(color: ConstantData.kGreyTextColor),
//                           /* border: Border.all(
//                                 color: ConstantData.lightGrey, width: .5),*/
//                         ),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton<LocationModel>(
//                             value: dropdownValue,
//                             //isExpanded: true,
//                             icon: Icon(Icons.arrow_drop_down,
//                                 color: Colors.grey.withOpacity(0.7)),
//                             // items: items,
//                             items: location
//                                 .map<DropdownMenuItem<LocationModel>>(
//                                     (LocationModel value) {
//                               return DropdownMenuItem<LocationModel>(
//                                 value: value,
//                                 child: Text(value.zoneName.toString()),
//                               );
//                             }).toList(),
//                             onChanged: (LocationModel? newValue) {
//                               setState(() {
//                                 dropdownValue = newValue;
//                                 print('----- value ------');
//                                 print(dropdownValue!.zoneId.toString() +
//                                     " " +
//                                     dropdownValue!.zoneName.toString());
//                               });
//                             },
//                             hint: Text(
//                               "---- โซน ----",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             // value: _selectedValue,
//                           ),
//                         ),
//                       ),
//                       // ConstantWidget.getSpace1(),

//                       /* DropdownButton<ZoneModel>(
//                         value: dropdownValue,
//                         icon: Icon(Icons.arrow_downward),
//                         iconSize: 24,
//                         elevation: 16,
//                         style: TextStyle(color: Colors.deepPurple),
//                         underline: Container(
//                           height: 2,
//                           color: Colors.deepPurpleAccent,
//                         ),
//                         onChanged: (ZoneModel? newValue) {
//                           setState(() {
//                             dropdownValue = newValue;
//                           });
//                         },
//                         items: _categoryList.map<DropdownMenuItem<ZoneModel>>(
//                             (ZoneModel value) {
//                           return DropdownMenuItem<ZoneModel>(
//                             value: value,
//                             child: Text(value.zone_name),
//                           );
//                         }).toList(),
//                       )*/
//                     ],
//                   ),
//                   InkWell(
//                     child: Container(
//                         width: 300,
//                         margin: EdgeInsets.only(top: 20),
//                         height: 50,
//                         decoration: BoxDecoration(
//                             color: ConstantData.primaryColor,
//                             borderRadius: BorderRadius.all(Radius.circular(8))),
//                         child: InkWell(
//                           child: Center(
//                             child: ConstantWidget.getCustomTextWithoutAlign(
//                                 S.of(context).search,
//                                 Colors.white,
//                                 FontWeight.w900,
//                                 ConstantData.font15Px),
//                           ),
//                         )),
//                     onTap: () {
//                       // PrefData.setIsSignIn(true);

//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => SearchResultPage()));

//                       /* Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => TabWidget(),
//                               ),
//                             );*/
//                       //  Navigator.pushNamed(context, '/searchresult');
//                       /* Navigator.pushReplacementNamed(
//                               context,
//                               '/nav'
//                             );*/
//                       /* Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (BuildContext context) => NavPage()));*/
//                     },
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 50),
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Expanded(child: Divider()),

//                       // Expanded(child: Divider()),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 20),
//                   ),
//                   Center(
//                     child: ConstantWidget.getCustomTextWithoutAlign(
//                         S.of(context).allexpert,
//                         // Colors.black,
//                         ConstantData.primaryColor,
//                         FontWeight.w900,
//                         26.0),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 20),
//                   ),
//                   GridView.count(
//                     shrinkWrap: true,
//                     primary: true,
//                     /* mainAxisSpacing: _crossAxisSpacing2,
//                       padding: EdgeInsets.symmetric(
//                           vertical: cellMargin2,
//                           horizontal: cellMargin2 + _crossAxisSpacing2),
//                       crossAxisCount: 4, //_crossAxisCount2,
//                       crossAxisSpacing: _crossAxisSpacing2,
//                       childAspectRatio: _aspectRatio2,*/
//                     padding: EdgeInsets.symmetric(
//                       vertical: cellMargin,
//                       horizontal: cellMargin + _crossAxisSpacing,
//                     ),
//                     mainAxisSpacing: 15.0, // ช่องว่างแนวนอน
//                     crossAxisSpacing: 15.0, // ช่องว่างแนวตั้ง
//                     crossAxisCount: Responsive.isMobile(context)
//                         ? 2
//                         : Responsive.isTablet(context)
//                             ? 4
//                             : Responsive.isDesktop(context)
//                                 ? 6
//                                 : 3,
//                     childAspectRatio: 0.7,

//                     children: List.generate(
//                       subList.length,
//                       (index) {
//                         // print("sizes===$mainCatWidth==$mainCatHeight--$_aspectRatio");
//                         ExpertModel _subCatModle = subList[index];
//                         return InkWell(
//                           /*onTap: () {
//                                   if (selectedFilterList != null &&
//                                       selectedFilterList
//                                           .contains(filterList[index])) {
//                                     selectedFilterList.remove(filterList[index]);
//                                   } else {
//                                     selectedFilterList.add(filterList[index]);
//                                   }
//                                   setState(() {});
//                                 },*/
//                           child: Container(
//                             width: double.infinity,
//                             height: cellHeight2,
//                             // height: mainCatHeight,
//                             // width: mainCatWidth,
//                             decoration: BoxDecoration(
//                               //color: ConstantData.bgColor,
//                               //lightPrimaryColors,
//                               // color: Colors.red,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(7)),
//                               /* border: Border.all(
//                                     color: (selectedFilterList != null &&
//                                             selectedFilterList
//                                                 .contains(filterList[index]))
//                                         ? ConstantData.primaryColor //accentColors
//                                         : ConstantData
//                                             .kGreyTextColor, //Colors.transparent,
//                                     width: 1),*/
//                             ),
//                             /* child: Center(
//                                     child: ConstantWidget.getCustomText(
//                                        // filterList[index],
//                                        _subCatModle.name,
//                                         ConstantData.textColor,
//                                         1,
//                                         TextAlign.center,
//                                         FontWeight.w500,
//                                         ConstantWidget.getPercentSize1(
//                                             cellHeight2, 25)),
//                                   ),*/

//                             child: Column(
//                               children: [
//                                 AspectRatio(
//                                   aspectRatio: 1.0,
//                                   child: Container(
//                                     // color: Colors.green,
//                                     child: Align(
//                                       alignment: Alignment.topRight,
//                                       child: Container(
//                                         padding: EdgeInsets.all(0),
//                                         decoration: BoxDecoration(
//                                             color: ConstantData.whiteColor,
//                                             borderRadius:
//                                                 BorderRadius.circular(100)),
//                                         /* child: Icon(
//                                             Icons.favorite_border_rounded,
//                                             color: Colors.white,
//                                           ),*/
//                                         child: IconButton(
//                                           icon: Icon(
//                                             Icons.favorite_border_rounded,
//                                           ),
//                                           iconSize: 20,
//                                           color: ConstantData.kGreyTextColor,
//                                           onPressed: () {},
//                                         ),
//                                       ),
//                                     ),

//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(7),
//                                           topRight: Radius.circular(7)),
//                                       color: ConstantData.whiteColor,
//                                       border: Border.all(
//                                           // color: Colors.blue,
//                                           color: ConstantData.whiteColor,
//                                           width: 1.0),
//                                       image: DecorationImage(
//                                           image: AssetImage(
//                                             // 'assets/images/image.jpg'
//                                             ConstantData.assetsImagePath +
//                                                 _subCatModle.image[0],
//                                           ),
//                                           fit: BoxFit.cover),
//                                     ),
//                                   ),
//                                 ),
//                                 AspectRatio(
//                                   aspectRatio: 2.5,
//                                   child: Container(
//                                     // height: 150,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.only(
//                                           bottomLeft: Radius.circular(7),
//                                           bottomRight: Radius.circular(7),
//                                         ),
//                                         color: ConstantData.whiteColor,
//                                         border: Border.all(
//                                             // color: Colors.yellow,
//                                             color: ConstantData.whiteColor,
//                                             width: 1.0)),
//                                     //child: Text('Item ${index}'),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(bottom: 10),
//                                         ),
//                                         /* ConstantWidget.getSpace(
//                                                         ConstantWidget.getPercentSize1(
//                                                             mainCatHeight, 2.5)),*/
//                                         Row(
//                                           children: [
//                                             ConstantWidget.getCustomText(
//                                               _subCatModle.gender,
//                                               ConstantData.textColor,
//                                               1,
//                                               TextAlign.start,
//                                               FontWeight.bold,
//                                               ConstantWidget.getPercentSize1(
//                                                   mainCatHeight, 8),
//                                             ),
//                                             ConstantWidget.getSpace1(),
//                                             ConstantWidget.getCustomText(
//                                                 _subCatModle.salary + " " + "฿",
//                                                 ConstantData.textColor,
//                                                 1,
//                                                 TextAlign.start,
//                                                 FontWeight.bold,
//                                                 ConstantWidget.getPercentSize1(
//                                                     mainCatHeight, 8)),
//                                           ],
//                                         ),
//                                         /* Padding(
//                                             padding: EdgeInsets.only(bottom: 20),
//                                           ),*/
//                                         /* ConstantWidget.getSpace(
//                                                         ConstantWidget.getPercentSize1(
//                                                             mainCatHeight, 2.5)),*/
//                                         Row(
//                                           children: [
//                                             ConstantWidget.getCustomText(
//                                               _subCatModle.name,
//                                               ConstantData.textColor,
//                                               1,
//                                               TextAlign.start,
//                                               FontWeight.bold,
//                                               ConstantWidget.getPercentSize1(
//                                                   mainCatHeight, 8),
//                                             ),
//                                             ConstantWidget.getSpace1(),
//                                             ConstantWidget.getCustomText(
//                                                 _subCatModle.province,
//                                                 ConstantData.textColor,
//                                                 1,
//                                                 TextAlign.start,
//                                                 FontWeight.bold,
//                                                 ConstantWidget.getPercentSize1(
//                                                     mainCatHeight, 8)),
//                                           ],
//                                         ),
//                                         /* ConstantWidget.getSpace(
//                                                           ConstantWidget
//                                                               .getPercentSize1(
//                                                                   mainCatHeight, 1.2)),*/
//                                         ConstantWidget.getCustomText(
//                                           S.of(context).age +
//                                               _subCatModle.age.toString() +
//                                               S.of(context).year,
//                                           // colorOrange,
//                                           ConstantData.textColor,
//                                           1,
//                                           TextAlign.start,
//                                           FontWeight.normal,
//                                           ConstantWidget.getPercentSize1(
//                                               mainCatHeight, 8),
//                                         ),
//                                         Row(
//                                           children: [
//                                             ConstantWidget.getSpace(
//                                                 ConstantWidget.getPercentSize1(
//                                                     mainCatHeight, 1.2)),
//                                             ConstantWidget.getCustomText(
//                                               _subCatModle.expertName
//                                                   .toString(),

//                                               // colorOrange,
//                                               ConstantData.textColor,
//                                               1,
//                                               TextAlign.start,
//                                               FontWeight.normal,
//                                               ConstantWidget.getPercentSize1(
//                                                   mainCatHeight, 8),
//                                             ),
//                                             ConstantWidget.getSpace1(),
//                                             ConstantWidget.getCustomText(
//                                                 _subCatModle.reviewDesc,
//                                                 ConstantData.textColor,
//                                                 1,
//                                                 TextAlign.center,
//                                                 FontWeight.w100,
//                                                 ConstantWidget.getPercentSize(
//                                                     bottomRemainSize, 9)),
//                                             Icon(
//                                               Icons.star,
//                                               color: Colors.amber,
//                                               size: 16,
//                                             ),
//                                             Icon(
//                                               Icons.check_circle,
//                                               color: Colors.green,
//                                               size: 16,
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 50),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       // Expanded(child: Divider()),
//                       Text('© metex')

//                       // Expanded(child: Divider()),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 50),
//                   ),
//                 ],
//               ),
//             )),
//       ),
//       onWillPop: _requestPop,
//       /* onWillPop: () async {
//             return false;
//           }*/
//     );
//   }
// }

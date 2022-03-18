import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:intl/intl.dart';
import 'package:metex_app/data/data.dart';
import 'package:metex_app/generated/l10n.dart';

import 'package:metex_app/models/experts_model.dart';
import 'package:metex_app/models/models.dart';
import 'package:metex_app/models/search_all_response_model.dart';
import 'package:metex_app/models/work_all_response.dart';

import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/services/config.dart';
import 'package:metex_app/services/zone_services.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:metex_app/utils/utils.dart';

class FilterType {
  String name;
  int typevalue;
  int seqno;
  FilterType(
      {required this.name, required this.seqno, required this.typevalue});
}

class HomeBeforeLoginPage extends StatefulWidget {
  const HomeBeforeLoginPage({Key? key}) : super(key: key);

  @override
  _HomeBeforeLoginPageState createState() => _HomeBeforeLoginPageState();
}

class _HomeBeforeLoginPageState extends State<HomeBeforeLoginPage> {
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  late String search;
  late int type2 = 0;
  late int can_team_building = 0;
  late int can_leadership = 0;
  late int can_communication = 0;
  late int can_performance_management = 0;
  late int can_career_growth = 0;
  late int can_mind_set = 0;
  late int can_unn_unn = 0;
  late int zone_id = 0;
  TextEditingController searchController = new TextEditingController();

  int selectedCareer = 0;
  int selectedPos = 0;
  // TextEditingController emailController = new TextEditingController();

  List<LocationModel> location = [];
  List<LocationModel> locationSelectList = [];
  List<CareerTypeDataModel> careerList = [];
  List<CareerTypeDataModel> selectionCareerList = []; //ตัวเลือก อาชีพ
  List<CareerTypeDataModel> selectFilterCareerList = [];

  List<ExpertDetails> allExpertlist = [];
  List<ExpertDetails> craftsmanExpertList = [];
  List<ExpertDetails> fruitExpertList = [];
  List<ExpertDetails> vegetableExpertList = [];
  List<ExpertDetails> carbonExpertList = [];

  List<WorkData> allWorkList = [];
  List<WorkData> workList = [];
  List<WorkData> craftsmanList = [];
  List<WorkData> fruitList = [];
  List<WorkData> vegetableList = [];
  List<WorkData> cabonList = [];

  List<ExpertDetails> chooseExpertlist = [];

  List<String> work = [];

//  List<SubCategoryModel> subList = [];
  List<ExpertDetails> subList = [];
   int indexz = 0;
   LocationModel? selectZoneValue;

  List<WorkData> selectedFilterList = [];

  getDataZone() async {
    var response = await http.post(
      Uri.parse(Config.BASE_URL + '/api/zone/all'),
    );
    if (response.statusCode == 200) {
      final ZoneModel zoneModel =
          ZoneModel.fromJson(convert.jsonDecode(response.body));
      setState(() {
        location = zoneModel.data;
        locationSelectList
            .add(LocationModel(zoneId: 0, zoneName: "เลือกโซน", zoneOrder: 0));
        locationSelectList.addAll(location);
        
      });
    } else {
      print('Error');
    }
  }

  getDataExpertType() async {
    var response = await http.post(
      Uri.parse(Config.BASE_URL + '/api/user/usertype2/all'),
    );
    if (response.statusCode == 200) {
      final CareerTypeModel careerTypeModel =
          CareerTypeModel.fromJson(convert.jsonDecode(response.body));
      setState(() {
        careerList = careerTypeModel.data;
        selectionCareerList.add(
            CareerTypeDataModel(user_type2_id: 0, user_type2_name: "ทั้งหมด"));
        selectionCareerList.addAll(careerList);
      });
    } else {
      print('Error');
    }
  }

  getDataExpertAll() async {
    var data = {
      "user_id": null,
    };
    Uri url = Uri.parse(Config.BASE_URL + '/api/user/search/all'); //url on web
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // body: convert.jsonEncode(data)
    );
    // print(data);
    // print(response.body);

    if (response.statusCode == 200) {
      // print(response.body);
      final SearchAllResponse searchModel =
          SearchAllResponse.fromJson(convert.jsonDecode(response.body));
//var seen = Set<ExpertDetails>();
      setState(() {
        allExpertlist = searchModel.data.expertdetails
            .where((element) =>
                element.userProfileType == 'u' &&
                element.userProfileIsActive == 1)
            .toList();
        // .where((expertdetails) => seen.add(expertdetails) )
        // .toList();
        craftsmanExpertList = allExpertlist
            .where((element) => element.userType2Id == '1')
            .toList();
        fruitExpertList = allExpertlist
            .where((element) => element.userType2Id == '2')
            .toList();
        vegetableExpertList = allExpertlist
            .where((element) => element.userType2Id == '3')
            .toList();
        carbonExpertList = allExpertlist
            .where((element) => element.userType2Id == '4')
            .toList();
      });
    } else {
      print('Error getDataExpertAll');
    }
  }

  List<ExpertDetails>? checkFilter() {
    if (selectedPos == 0) {
      return allExpertlist;
    }
    if (selectedPos == 1) {
      return craftsmanExpertList;
    }
    if (selectedPos == 2) {
      return fruitExpertList;
    }
    if (selectedPos == 3) {
      return vegetableExpertList;
    }
    if (selectedPos == 4) {
      return carbonExpertList;
    }
    return null;
  }

  sendParamToNextPage() {
    search = searchController.text;
    type2 = selectedPos;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchResultPage(
                 
                )));
  }

  getDataWork() async {
    var response = await http.post(
      Uri.parse(Config.BASE_URL + '/api/user/work/all'),
    );
    // print(response.body);
    if (response.statusCode == 200) {
      final WorkAllResponseModel zoneModel =
          WorkAllResponseModel.fromJson(convert.jsonDecode(response.body));
      setState(() {
        allWorkList = zoneModel.data;
        craftsmanList = allWorkList
            .where((element) => element.workUserType2Id == 1)
            .toList();
        fruitList = allWorkList
            .where((element) => element.workUserType2Id == 2)
            .toList();
        vegetableList = allWorkList
            .where((element) => element.workUserType2Id == 3)
            .toList();
        cabonList = allWorkList
            .where((element) => element.workUserType2Id == 4)
            .toList();
      });
    } else {
      print('Error getDataZone');
    }
  }

  List<WorkData>? checkFilterWork() {
    if (selectedPos == 0) {
      workList = allWorkList;
      return workList;
    }
    if (selectedPos == 1) {
      workList = craftsmanList;

      return workList;
    }
    if (selectedPos == 2) {
      workList = fruitList;

      return workList;
    }
    if (selectedPos == 3) {
      workList = vegetableList;

      return workList;
    }
    if (selectedPos == 4) {
      workList = cabonList;

      return workList;
    }

    return null;
  }

  sendDataToExpertDetailsPage(String user_profile_id) {
    print('user_profile_id =======>' + user_profile_id);
    setState(() {
      chooseExpertlist = allExpertlist
          .where(
              (element) => element.userProfileId == int.parse(user_profile_id))
          .toList();

      print('chooseExpertlist ===== >' + chooseExpertlist.length.toString());

      if (chooseExpertlist.length > 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    ExpertDetailPage(chooseExpertlist: chooseExpertlist)));
      }
    });
  }

  // Create storage
  final storage = new FlutterSecureStorage();

  storageReadWrite() async {
    // Read value
    String? value2 = await storage.read(key: 'test');
    if (value2 == null) {
      await storage.write(key: 'test', value: '0');
    } else {
      String value3 = (int.parse(value2) + 1).toString();
      await storage.write(key: 'test', value: value3);
    }
// Read all values
//Map<String, String> allValues = await storage.readAll();

// Delete value
//await storage.delete(key: 'test');

// Delete all
//await storage.deleteAll();

// Write value
    // await storage.write(key: 'test', value: '0');
  }

  read() async {
    // Read value
    var v = await storage.read(key: 'test');
    var v2 = await storage.read(key: 'loginUserToken');
    setState(() {
      test = v;
      loginUserToken = v2;
    });
  }

  var test;
  var loginUserToken;

  @override
  void initState() {
    super.initState();

    storageReadWrite();
    read();

    getDataZone();
    getDataExpertType();
    getDataExpertAll();
    getDataWork();
    //dropdownValue!.zoneId.toString();
  }

  // List<ZoneModel> _categoryList = <ZoneModel>[];

 

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    subList = [];
    // subList = allCatList[selectedPos];
    subList = checkFilter()!;
    //subList = allExpertlist;
    var cellHeight = SizeConfig.safeBlockHorizontal! * 58;
    double cellMargin2 = 7;
    double cellMargin = 7;

    var _crossAxisSpacing2 = 8.0;
    var _crossAxisSpacing = 8.0;
    var _crossAxisCount2 = 3;

    var bottomDialogTextSizeFilter = SizeConfig.safeBlockVertical! * 55;
    var cellHeight2 =
        ConstantWidget.getPercentSize1(bottomDialogTextSizeFilter, 13);
    var _screenWidth = MediaQuery.of(context).size.width;

    var _crossAxisCount = 2;
    var _width2 =
        (_screenWidth - ((_crossAxisCount2 - 1) * _crossAxisSpacing2)) /
            _crossAxisCount2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var _aspectRatio2 = _width2 / cellHeight2;
    var _aspectRatio = _width / cellHeight;

    // double editTextHeight = MediaQuery.of(context).size.height * 0.06;
    double mainCatWidth = (SizeConfig.safeBlockHorizontal! * 50) -
        (cellMargin * 2 + _crossAxisSpacing);
    double mainCatHeight = cellHeight;
    double topCellHeight = ConstantWidget.getPercentSize(cellHeight, 12);
    double imageSize = SizeConfig.safeBlockVertical! * 6.5;
    double bottomRemainSize = cellHeight - imageSize - topCellHeight;
    double topSliderWidth = SizeConfig.safeBlockHorizontal! * 23;
    double topSliderHeight = SizeConfig.safeBlockHorizontal! * 13;

    double editTextHeight = MediaQuery.of(context).size.height * 0.06;

    return WillPopScope(
      child: new Scaffold(
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
            child: allExpertlist.length == 0
                ? Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: "กรุณารอสักครู",
                    ),
                  )
                : new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                      ),
                      Center(
                        child: ConstantWidget.getCustomTextWithoutAlign(
                            S.of(context).expertmsg,
                            // Colors.black,
                            ConstantData.primaryColor,
                            FontWeight.w900,
                            26.0),
                      ),
                      Container(
                        // color: Colors.red,
                        height: topSliderHeight * 1.25,

                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.all(
                              ConstantWidget.getPercentSize1(
                                  topSliderWidth, 5)),
                          itemCount: selectionCareerList.length,
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
                                    image: selectionCareerList[index]
                                                .user_type2_id ==
                                            1
                                        ? DecorationImage(
                                            image: AssetImage(
                                                'assets/images/logo/carve.png'),
                                            fit: BoxFit.cover)
                                        : selectionCareerList[index]
                                                    .user_type2_id ==
                                                2
                                            ? DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/logo/fruit.png'),
                                                fit: BoxFit.cover)
                                            : selectionCareerList[index]
                                                        .user_type2_id ==
                                                    3
                                                ? DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/logo/hydro.png'),
                                                    fit: BoxFit.cover)
                                                : selectionCareerList[index]
                                                            .user_type2_id ==
                                                        4
                                                    ? DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/logo/carbon.png'),
                                                        fit: BoxFit.cover)
                                                    : DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/logo/all.jpg'),
                                                        fit: BoxFit.cover),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: (selectedPos == index)
                                        ? ConstantData.primaryColor
                                        : ConstantData.lightPrimaryColors),
                                margin: EdgeInsets.all(
                                    ConstantWidget.getPercentSize1(
                                        topSliderWidth, 5)),
                                /* child: Align(
                                  alignment: Alignment.center,
                                  child: ConstantWidget.getCustomText(
                                      selectionCareerList[index]
                                          .user_type2_name
                                          .toString(),
                                      (selectedPos == index)
                                          ? ConstantData.whiteColor
                                          : ConstantData.whiteColor,
                                      1,
                                      TextAlign.right,
                                      FontWeight.bold,
                                      ConstantWidget.getPercentSize1(
                                          topSliderHeight, 25)),
                                ),*/
                                child: Align(
                                  //heightFactor:100 ,
                                  alignment: Alignment.bottomCenter,
                                  child:
                                      ConstantWidget.getCustomTextWithoutAlign(
                                          selectionCareerList[index]
                                              .user_type2_name
                                              .toString(),
                                          ConstantData.whiteColor,
                                          FontWeight.w900,
                                          36.0),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      /* Center(child: Text('Test ====> ' + test.toString())),
                      Center(
                          child: Text('loginUserToken ====> ' +
                              loginUserToken.toString())),*/

                      Center(
                        child: ConstantWidget.getCustomTextWithoutAlign(
                            // "Test",
                            S.of(context).expertmsg2,
                            // Colors.black,
                            ConstantData.primaryColor,
                            FontWeight.w900,
                            20.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                      ),
                      Center(
                        child: ConstantWidget.getCustomTextWithoutAlign(
                            S.of(context).expertmsg3,
                            // Colors.black,
                            ConstantData.primaryColor,
                            FontWeight.normal,
                            18.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                      ),
                      GridView.count(
                        //ปุ่ม  filter 7 ปุ่ม
                        shrinkWrap: true,
                        primary: true,
                        mainAxisSpacing: _crossAxisSpacing2,
                        padding: EdgeInsets.symmetric(
                          vertical: cellMargin2,
                          horizontal: cellMargin2 + _crossAxisSpacing2,
                          // vertical: 50,
                          // horizontal: 50,
                        ),
                        crossAxisCount: 5, //_crossAxisCount2,
                        crossAxisSpacing: _crossAxisSpacing2,
                        childAspectRatio: _aspectRatio2,
                        children: List.generate(
                          // allWorkList.length,
                          checkFilterWork()!.length,
                          (index) {
                            // print( "sizes===$mainCatWidth==$mainCatHeight--$_aspectRatio");
                            return InkWell(
                              onTap: () {
                                if (selectedFilterList != null &&
                                    selectedFilterList
                                        .contains(workList[index])) {
                                  selectedFilterList.remove(workList[index]);
                                  work.remove(
                                      workList[index].workId.toString());
                                } else {
                                  selectedFilterList.add(workList[index]);
                                  work.add(workList[index].workId.toString());
                                }
                                setState(() {});
                              },
                              child: Container(
                                width: double.infinity,
                                // height: 200,
                                height: cellHeight2,
                                decoration: BoxDecoration(
                                  // color: ConstantData.bgColor,
                                  color: (selectedFilterList != null &&
                                          selectedFilterList
                                              .contains(workList[index]))
                                      ? ConstantData.primaryColor //accentColors
                                      : ConstantData.bgColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  border: Border.all(
                                      color: (selectedFilterList != null &&
                                              selectedFilterList
                                                  .contains(workList[index]))
                                          ? ConstantData
                                              .primaryColor //accentColors
                                          : ConstantData
                                              .kGreyTextColor, //Colors.transparent,
                                      width: 1),
                                ),
                                child: Center(
                                  child: ConstantWidget.getCustomText(
                                      // filterList[index].name,
                                      workList[index].workName,
                                      //ConstantData.textColor,
                                      (selectedFilterList != null &&
                                              selectedFilterList
                                                  .contains(workList[index]))
                                          ? ConstantData
                                              .whiteColor //accentColors
                                          : ConstantData.kGreyTextColor,
                                      1,
                                      TextAlign.center,
                                      FontWeight.bold,
                                      ConstantWidget.getPercentSize1(
                                          cellHeight2, 25)),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                      ),
                      Responsive.isTablet(context) ||
                              Responsive.isDesktop(context)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  //margin: EdgeInsets.only(bottom: 10, top: 10),
                                  height: editTextHeight,
                                  width: 300,
                                  child: TextField(
                                    maxLines: 1,
                                    controller: searchController,
                                    // controller:  S.of(context).documentNo.toString(),
                                    style: TextStyle(
                                        fontFamily: ConstantData.fontFamily,
                                        color: ConstantData.primaryTextColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),

                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 25.0, horizontal: 10.0),
                                      // floatingLabelBehavior: FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(5),
                                        ),
                                      ),
                                      // border: InputBorder.none,
                                      // labelText: S.of(context).searchbyname,
                                      hintText: S.of(context).searchbyname,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),

                                /*  Container(
                                  // height: 40.0,
                                  height: editTextHeight,
                                  padding:
                                      EdgeInsets.only(left: 100, right: 100),

                                  decoration: BoxDecoration(
                                    color: ConstantData.bgColor,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: ConstantData.kGreyTextColor),
                                    /* border: Border.all(
                                color: ConstantData.lightGrey, width: .5),*/
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<LocationModel>(
                                      value: dropdownValue,
                                      //isExpanded: true,
                                      icon: Icon(Icons.arrow_drop_down,
                                          color: Colors.grey.withOpacity(0.7)),
                                      // items: items,
                                      items: location
                                          .map<DropdownMenuItem<LocationModel>>(
                                              (LocationModel value) {
                                        return DropdownMenuItem<LocationModel>(
                                          value: value,
                                          child:
                                              Text(value.zoneName.toString()),
                                        );
                                      }).toList(),
                                      onChanged: (LocationModel? newValue) {
                                        setState(() {
                                          dropdownValue = newValue;
                                          print('----- value ------');
                                          print(
                                              dropdownValue!.zoneId.toString() +
                                                  " " +
                                                  dropdownValue!.zoneName
                                                      .toString());
                                        });
                                      },
                                      hint: Text(
                                        "------- โซน -------",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      // value: _selectedValue,
                                    ),
                                  ),
                                ),
                                // ConstantWidget.getSpace1(),
                              */

                              /*  Container(
                                  // height: 40.0,
                                  height: editTextHeight,
                                  // padding: EdgeInsets.only(left: 100, right: 100),
                                  width: 305,

                                  decoration: BoxDecoration(
                                    color: ConstantData.bgColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: ConstantData.kGreyTextColor),
                                    /* border: Border.all(
                                color: ConstantData.lightGrey, width: .5),*/
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<LocationModel>(
                                      value: dropdownValue,
                                      //isExpanded: true,
                                      icon: Icon(Icons.arrow_drop_down,
                                          color: Colors.grey.withOpacity(0.7)),
                                      // items: items,
                                      items: location
                                          .map<DropdownMenuItem<LocationModel>>(
                                              (LocationModel value) {
                                        return DropdownMenuItem<LocationModel>(
                                          value: value,
                                          child:
                                              Text(value.zoneName.toString()),
                                        );
                                      }).toList(),
                                      onChanged: (LocationModel? newValue) {
                                        setState(() {
                                          dropdownValue = newValue;
                                          print('----- value ------');
                                          print(
                                              dropdownValue!.zoneId.toString() +
                                                  " " +
                                                  dropdownValue!.zoneName
                                                      .toString());
                                        });
                                      },
                                      /* hint: Text(
                                        "------- โซน -------",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),*/
                                      // value: _selectedValue,
                                    ),
                                  ),
                                ),
                              */
                            
                             Container(
                              // height: 40.0,
                              height: editTextHeight,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: 300,

                              decoration: BoxDecoration(
                                color: ConstantData.bgColor,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: ConstantData.kGreyTextColor),
                                /* border: Border.all(
                                color: ConstantData.lightGrey, width: .5),*/
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<LocationModel>(
                                  // value: dropdownValue,
                                  value: locationSelectList[indexz],
                                  //isExpanded: true,
                                  icon: Icon(Icons.arrow_drop_down,
                                      color: Colors.grey.withOpacity(0.7)),
                                  // items: items,
                                  // items: location
                                  items: locationSelectList
                                      .map<DropdownMenuItem<LocationModel>>(
                                          (LocationModel value) {
                                    return DropdownMenuItem<LocationModel>(
                                        value: value,
                                        // child: Text(value.zoneName.toString()),
                                        child: ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                value.zoneName.toString(),
                                                ConstantData.kGreyTextColor,
                                                FontWeight.normal,
                                                16.0));
                                  }).toList(),
                                  onChanged: (LocationModel? newValue) {
                                    setState(() {
                                      /* dropdownValue = newValue;
                                      indexw =
                                          locationSelectList.indexOf(newValue!);
                                      print('----- value ------');
                                      print(dropdownValue!.zoneId.toString() +
                                          " " +
                                          dropdownValue!.zoneName.toString());*/

                                      indexz =
                                          locationSelectList.indexOf(newValue!);
                                      print(indexz);
                                      selectZoneValue = newValue;

                                      print(selectZoneValue!.zoneName);
                                    });
                                  },
                                  /* hint: Text(
                                    "------- โซน -------",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),*/
                                  // value: _selectedValue,
                                ),
                              ),
                            ),
                         
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  //margin: EdgeInsets.only(bottom: 10, top: 10),
                                  height: editTextHeight,
                                  width: 300,
                                  child: TextField(
                                    maxLines: 1,
                                    controller: searchController,
                                    // controller:  S.of(context).documentNo.toString(),
                                    style: TextStyle(
                                        fontFamily: ConstantData.fontFamily,
                                        color: ConstantData.primaryTextColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),

                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 25.0, horizontal: 10.0),
                                      // floatingLabelBehavior: FloatingLabelBehavior.always,
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(5),
                                        ),
                                      ),
                                      // border: InputBorder.none,
                                      // labelText: S.of(context).searchbyname,
                                      hintText: S.of(context).searchbyname,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                               Container(
                              // height: 40.0,
                              height: editTextHeight,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: 300,

                              decoration: BoxDecoration(
                                color: ConstantData.bgColor,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: ConstantData.kGreyTextColor),
                                /* border: Border.all(
                                color: ConstantData.lightGrey, width: .5),*/
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<LocationModel>(
                                  // value: dropdownValue,
                                  value: locationSelectList[indexz],
                                  //isExpanded: true,
                                  icon: Icon(Icons.arrow_drop_down,
                                      color: Colors.grey.withOpacity(0.7)),
                                  // items: items,
                                  // items: location
                                  items: locationSelectList
                                      .map<DropdownMenuItem<LocationModel>>(
                                          (LocationModel value) {
                                    return DropdownMenuItem<LocationModel>(
                                        value: value,
                                        // child: Text(value.zoneName.toString()),
                                        child: ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                value.zoneName.toString(),
                                                ConstantData.kGreyTextColor,
                                                FontWeight.normal,
                                                16.0));
                                  }).toList(),
                                  onChanged: (LocationModel? newValue) {
                                    setState(() {
                                      /* dropdownValue = newValue;
                                      indexw =
                                          locationSelectList.indexOf(newValue!);
                                      print('----- value ------');
                                      print(dropdownValue!.zoneId.toString() +
                                          " " +
                                          dropdownValue!.zoneName.toString());*/

                                      indexz =
                                          locationSelectList.indexOf(newValue!);
                                      print(indexz);
                                      selectZoneValue = newValue;

                                      print(selectZoneValue!.zoneName);
                                    });
                                  },
                                  /* hint: Text(
                                    "------- โซน -------",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),*/
                                  // value: _selectedValue,
                                ),
                              ),
                            ),
                         
                              ],
                            ),
                      InkWell(
                        child: Container(
                            width: 300,
                            margin: EdgeInsets.only(top: 20),
                            height: 50,
                            decoration: BoxDecoration(
                                color: ConstantData.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: InkWell(
                              child: Center(
                                child: ConstantWidget.getCustomTextWithoutAlign(
                                    S.of(context).search,
                                    Colors.white,
                                    FontWeight.w900,
                                    ConstantData.font15Px),
                              ),
                            )),
                        onTap: () {
                          // PrefData.setIsSignIn(true);
                          sendParamToNextPage();
                        },
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
                        padding: EdgeInsets.only(bottom: 20),
                      ),
                      Center(
                        child: ConstantWidget.getCustomTextWithoutAlign(
                            //  S.of(context).allexpert,
                            // Colors.black,
                            'พบ ผู้ให้บริการ  ' +
                                selectionCareerList[selectedPos]
                                    .user_type2_name
                                    .toString() +
                                "  " +
                                subList.length.toString() +
                                "  คน",
                            ConstantData.primaryColor,
                            FontWeight.w900,
                            26.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                      ),
                      GridView.count(
                        //สรางการ์ด Expert
                        shrinkWrap: true,
                        primary: true,

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
                            // print("sizes===$mainCatWidth==$mainCatHeight--$_aspectRatio");
                            // ExpertModel _subCatModle = subList[index];
                            ExpertDetails _subCatModle = subList[index];

                            return InkWell(
                              /*onTap: () {
                            if (selectedFilterList != null &&
                                selectedFilterList
                                    .contains(filterList[index])) {
                              selectedFilterList.remove(filterList[index]);
                            } else {
                              selectedFilterList
                                  .add(filterList[index].toString());
                              print(selectedFilterList);
                            }
                            setState(() {});
                          },*/
                              onTap: () {
                                sendDataToExpertDetailsPage(
                                    _subCatModle.userProfileId.toString());
                                /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ExpertDetailPage(chooseExpertlist: chooseExpertlist)));*/
                              },
                              child: Container(
                                width: double.infinity,
                                height: cellHeight2,
                                child: Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1.0,
                                      child: Container(
                                        // color: Colors.green,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          // verticalDirection: VerticalDirection.down,
                                          // mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                padding: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                  color:
                                                      ConstantData.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                /* child: Icon(
                                                    Icons.favorite_border_rounded,
                                                    color: Colors.white,
                                                  ),*/
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons
                                                        .favorite_border_rounded,
                                                  ),
                                                  iconSize: 20,
                                                  color: ConstantData
                                                      .kGreyTextColor,
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Container(
                                                    height: 35,
                                                    width: 45,
                                                    padding: EdgeInsets.all(0),
                                                    decoration: BoxDecoration(
                                                        color: ConstantData
                                                            .whiteColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0))),
                                                    child: Center(
                                                      child: ConstantWidget
                                                          .getCustomText(
                                                        //"ชาย",
                                                        _subCatModle.gender,

                                                        ConstantData.textColor,
                                                        1,
                                                        TextAlign.start,
                                                        FontWeight.bold,
                                                        ConstantWidget
                                                            .getPercentSize1(
                                                                cellHeight2,
                                                                25),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Container(
                                                    height: 35,
                                                    width: 80,
                                                    padding: EdgeInsets.all(0),
                                                    decoration: BoxDecoration(
                                                        color: ConstantData
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0))),
                                                    child: Center(
                                                      child: ConstantWidget
                                                          .getCustomText(
                                                        "฿ " +
                                                            _subCatModle
                                                                .userProfilePrice,
                                                        ConstantData.whiteColor,
                                                        1,
                                                        TextAlign.start,
                                                        FontWeight.normal,
                                                        /* ConstantWidget
                                                              .getPercentSize1(
                                                                  mainCatHeight,
                                                                  8),*/
                                                        ConstantWidget
                                                            .getPercentSize1(
                                                                cellHeight2,
                                                                25),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(7),
                                              topRight: Radius.circular(7)),
                                          color: ConstantData.whiteColor,
                                          border: Border.all(
                                              // color: Colors.blue,
                                              color: ConstantData.whiteColor,
                                              width: 1.0),
                                          /* image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/no-image.png'
                                                  /* ConstantData.assetsImagePath +
                                                _subCatModle.image[0],*/
                                                  ),
                                              fit: BoxFit.cover),*/
                                          image: _subCatModle.userProfileImage ==
                                                  '0'
                                              ? DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/no-image.png'),
                                                  fit: BoxFit.cover)
                                              : DecorationImage(
                                                  image: NetworkImage(Config
                                                          .BASE_URL +
                                                      '/public/uploads/user-profile/' +
                                                      _subCatModle.userProfileId
                                                          .toString() +
                                                      '/' +
                                                      _subCatModle
                                                          .userProfileImage),
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

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, right: 4),
                                              child: Row(
                                                //mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ConstantWidget.getCustomText(
                                                    // _subCatModle.name,
                                                    _subCatModle
                                                        .userProfileName,
                                                    ConstantData.textColor,
                                                    1,
                                                    TextAlign.start,
                                                    FontWeight.bold,
                                                    ConstantWidget
                                                        .getPercentSize1(
                                                            mainCatHeight, 8),
                                                  ),

                                                Responsive.isDesktop(context)? ConstantWidget.getSpace1():
                                                   //ConstantWidget.getSpaceWidth(20),
                                                   Spacer(flex: 1),

                                                  ConstantWidget.getCustomText(
                                                          _subCatModle.zoneName,
                                                          ConstantData
                                                              .textColor,
                                                          1,
                                                          TextAlign.start,
                                                          FontWeight.bold,
                                                          ConstantWidget
                                                              .getPercentSize1(
                                                                  mainCatHeight,
                                                                  8))
                                                       /*Expanded(
                                                          child: ConstantWidget
                                                              .getCustomText(
                                                                  _subCatModle
                                                                      .zoneName,
                                                                  ConstantData
                                                                      .textColor,
                                                                  1,
                                                                  TextAlign
                                                                      .start,
                                                                  FontWeight
                                                                      .bold,
                                                                  ConstantWidget
                                                                      .getPercentSize1(
                                                                          mainCatHeight,
                                                                          8)),
                                                        ),*/
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, right: 4),
                                              child: Row(
                                                children: [
                                                  ConstantWidget.getCustomText(
                                                    S.of(context).age +
                                                        _subCatModle.age
                                                            .toString() +
                                                        S.of(context).year,
                                                    // colorOrange,
                                                    ConstantData.textColor,
                                                    1,
                                                    TextAlign.start,
                                                    FontWeight.normal,
                                                    ConstantWidget
                                                        .getPercentSize1(
                                                            mainCatHeight, 8),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, right: 4),
                                              child: Row(
                                                children: [
                                                  ConstantWidget.getSpace(
                                                      ConstantWidget
                                                          .getPercentSize1(
                                                              mainCatHeight,
                                                              1.2)),
                                                  ConstantWidget.getCustomText(
                                                    // _subCatModle.expertName
                                                    //"อาชีพ",
                                                    _subCatModle.userType2Name,

                                                    // colorOrange,
                                                    // _subCatModle.userType2Name.toString(),
                                                    ConstantData.textColor,
                                                    1,
                                                    TextAlign.start,
                                                    FontWeight.normal,
                                                    ConstantWidget
                                                        .getPercentSize1(
                                                            mainCatHeight, 8),
                                                  ),
                                                  ConstantWidget.getSpace1(),
                                                  ConstantWidget.getCustomText(
                                                      "( " +
                                                          _subCatModle
                                                              .userProfileStarRate
                                                              .toString() +
                                                          " )",
                                                      ConstantData.textColor,
                                                      1,
                                                      TextAlign.center,
                                                      FontWeight.w100,
                                                      ConstantWidget
                                                          .getPercentSize(
                                                              bottomRemainSize,
                                                              9)),
                                                  Icon(
                                                    Icons.star,
                                                    color: _subCatModle
                                                                .userProfileIsTopStar ==
                                                            1
                                                        ? Colors.amber
                                                        : ConstantData
                                                            .kGreyTextColor,
                                                    size: 16,
                                                  ),
                                                  Icon(
                                                    Icons.check_circle,
                                                    color: _subCatModle
                                                                .userProfileIsConfirmImage ==
                                                            1
                                                        ? Colors.green
                                                        : ConstantData
                                                            .kGreyTextColor,
                                                    size: 16,
                                                  ),
                                                ],
                                              ),
                                            ),
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
          ),
        ),
      ),
      onWillPop: _requestPop,
      /* onWillPop: () async {
            return false;
          }*/
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/checkbox_model.dart';
import 'package:metex_app/models/models.dart';
import 'package:metex_app/models/userprofile_response.dart';
import 'package:metex_app/models/work_all_response.dart';
import 'package:metex_app/pages/nav/test4.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/pages/user_setting/work_checkbox.dart';
import 'package:metex_app/services/config.dart';
import 'package:metex_app/utils/utils.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ExpertEditProfilePage extends StatefulWidget {
  String userId;
  String userName;
  String userType;
  ExpertEditProfilePage(
      {Key? key,
      required this.userId,
      required this.userName,
      required this.userType})
      : super(key: key);

  @override
  State<ExpertEditProfilePage> createState() => _ExpertEditProfilePageState();
}

class Data {
  late WorkData data;
  late bool isSelected = false;

 // Data({required this.isSelected, required this.title, required this.subTitle});
}

class _ExpertEditProfilePageState extends State<ExpertEditProfilePage> {


  List<LocationModel> location = [];
  List<LocationModel> locationSelectList = [];
  List<CareerTypeDataModel> careerList = [];
  List<CareerTypeDataModel> selectionCareerList = []; //ตัวเลือก อาชีพ
  List<CareerTypeDataModel> selectFilterCareerList = [];
  TextEditingController displayNameController = new TextEditingController();
  TextEditingController lineIdController = new TextEditingController();
  TextEditingController facebookController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController searchController = new TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LocationModel? dropdownValue;
  CareerTypeDataModel? selectWorkTypeValue;
  late List<UserProfileData> userprofileList = [];
  List<WorkData> allWorkList = [];
  List<Data> allWorkList2 = [];
  DateTime checkInDate = DateTime.now();
  DateTime checkOutDate = DateTime.now();
  int indexw = 0;
  int indexz = 0;

 

  var tmpArray = [];

 
 

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  toGetUserProfileData() async {
    var data = {"user_id": widget.userId};
    try {
      Uri url =
          Uri.parse(Config.BASE_URL + '/api/user/userprofile'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      // print(widget.userId);
      if (response.statusCode == 200) {
        final UserProfileResponseModel userprofile =
            UserProfileResponseModel.fromJson(
                convert.jsonDecode(response.body));
        setState(() {
          userprofileList = userprofile.data;

          // print(userprofileList[0].userProfileGender);
          displayNameController.text =
              userprofileList[0].userProfileName.toString();
          userprofileList[0].userProfileGender == 'm' ? "ชาย" : "หญิง";
          _selectedValue =
              userprofileList[0].userProfileGender == 'm' ? "ชาย" : "หญิง";
        });
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  //late String _selectedValue = 'ชาย';
  late String _selectedValue =
      userprofileList[0].userProfileGender == 'm' ? "ชาย" : "หญิง";
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
            CareerTypeDataModel(user_type2_id: 0, user_type2_name: "ประเภท"));
        selectionCareerList.addAll(careerList);
        // workTypeValue = selectionCareerList;
      });
    } else {
      print('Error');
    }
  }

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
      print('Error getDataZone');
    }
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
        allWorkList2.clear();

        allWorkList.forEach((element) {
        
          Data c2 = Data();
         
          c2.data = element;
         
          allWorkList2.add(c2);
           });
      });
    } else {
      print('Error getDataZone');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toGetUserProfileData();
    getDataZone();
    getDataExpertType();
    getDataWork();
    // selectWorkTypeValue = selectionCareerList[0];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double editTextHeight = MediaQuery.of(context).size.height * 0.06;
    double screenWidth = SizeConfig.safeBlockHorizontal! * 100;
    double screenHeight = SizeConfig.safeBlockVertical! * 100;
    double containerHeight = ConstantWidget.getPercentSize1(screenWidth, 24);

    return WillPopScope(
      child: new Scaffold(
        /*appBar: AppBar(
            title: new Text('SingleChildScrollView Demo'),
          ),*/
        body: new SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            // color: Colors.red,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
              //  bottom: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              //  left: MediaQuery.of(context).size.width * 0.07,
              // right: MediaQuery.of(context).size.width * 0.07,
            ),
            child: userprofileList.length == 0 && allWorkList.length == 0
                ? Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: "กรุณารอสักครู",
                    ),
                  )
                : Form(
                    key: formKey,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ConstantWidget.getCustomTextWithoutAlign(
                              // S.of(context).editprofile,
                              'แก้ไขโปรไฟล์ ผุ้เชี่ยวชาญ',
                              // Colors.black,
                              ConstantData.primaryColor,
                              FontWeight.w900,
                              32.0),
                        ),
                       /* Center(
                          child: ConstantWidget.getCustomTextWithoutAlign(
                              S.of(context).editprofile,
                              // Colors.black,
                              ConstantData.primaryColor,
                              FontWeight.w900,
                              32.0),
                        ),*/
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                            bottom: 10,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              //  margin: EdgeInsets.only(bottom: 10, top: 10),
                              height: editTextHeight,
                              width: 300,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Display name is Required';
                                  }

                                  return null;
                                },
                                maxLines: 1,
                                controller: displayNameController,
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
                                  labelText: S.of(context).displayname,
                                  // hintText: 'Full Name',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
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
                                child: DropdownButton(
                                  value: _selectedValue,
                                  //isExpanded: true,

                                  icon: Icon(Icons.arrow_drop_down,
                                      color: Colors.grey.withOpacity(0.7)),
                                  items: items,

                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedValue = value!;
                                    });
                                  },

                                  // value: _selectedValue,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
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
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<CareerTypeDataModel>(
                                  value: selectionCareerList[indexw],
                                  //isExpanded: true,

                                  icon: Icon(Icons.arrow_drop_down,
                                      color: Colors.grey.withOpacity(0.7)),
                                  // items: items,
                                  items: selectionCareerList.map<
                                          DropdownMenuItem<
                                              CareerTypeDataModel>>(
                                      (CareerTypeDataModel value) {
                                    return DropdownMenuItem<
                                        CareerTypeDataModel>(
                                      value: value,
                                      child: Text(
                                          value.user_type2_name.toString()),
                                    );
                                  }).toList(),
                                  onChanged: (CareerTypeDataModel? newValue) {
                                    setState(() {
                                      indexw = selectionCareerList
                                          .indexOf(newValue!);
                                      print(indexw);
                                      selectWorkTypeValue = newValue;

                                      print(
                                          selectWorkTypeValue!.user_type2_name);
                                    });
                                  },
                                ),
                              ),
                            ),
                            /* Container(
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
                                child: DropdownButton<CareerTypeDataModel>(
                                  value: worktypeValue,
                                  //isExpanded: true,

                                  icon: Icon(Icons.arrow_drop_down,
                                      color: Colors.grey.withOpacity(0.7)),
                                  items: selectionCareerList,

                                  onChanged: (CareerTypeDataModel value) {
                                    setState(() {
                                      worktypeValue = value;
                                    });
                                  },

                                  // value: _selectedValue,
                                ),
                              ),
                            ),
                            */

                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: editTextHeight,
                              width: 300,
                              // margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: ConstantData.bgColor,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: ConstantData.kGreyTextColor),
                              ),

                              child: InkWell(
                                onTap: () async {
                                  await showDatePicker(
                                    context: context,
                                    initialDate: checkInDate,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2050),
                                  ).then((pickedDate) {
                                    if (pickedDate != null &&
                                        pickedDate != checkInDate)
                                      setState(() {
                                        checkInDate = pickedDate;
                                      });
                                  });
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: ConstantWidget.getCustomText(
                                          DateFormat.yMMMd()
                                              .format(checkInDate),
                                          ConstantData.primaryTextColor,
                                          1,
                                          TextAlign.start,
                                          FontWeight.w400,
                                          ConstantWidget.getPercentSize1(
                                              screenHeight, 2)),
                                      flex: 1,
                                    ),
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      color: ConstantData.primaryTextColor,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              //  margin: EdgeInsets.only(bottom: 10, top: 10),
                              height: editTextHeight,
                              width: 300,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Display name is Required';
                                  }

                                  return null;
                                },
                                maxLines: 1,
                                controller: displayNameController,
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
                                  labelText: S.of(context).lineid,
                                  // hintText: 'LINE ID',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),

                            Container(
                              //  margin: EdgeInsets.only(bottom: 10, top: 10),
                              height: editTextHeight,
                              width: 300,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Display name is Required';
                                  }

                                  return null;
                                },
                                maxLines: 1,
                                controller: displayNameController,
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
                                  labelText: S.of(context).facebook,
                                  // hintText: 'Facebook',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),

                            Container(
                              //  margin: EdgeInsets.only(bottom: 10, top: 10),
                              height: editTextHeight,
                              width: 300,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Display name is Required';
                                  }

                                  return null;
                                },
                                maxLines: 1,
                                controller: displayNameController,
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
                                  labelText: S.of(context).phone,
                                  // hintText: 'เบอร์โทร',
                                ),
                              ),
                            ),
                            // ConstantWidget.getSpace1(),
                            SizedBox(
                              width: 20,
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
                                      child: Text(value.zoneName.toString()),
                                    );
                                  }).toList(),
                                  onChanged: (LocationModel? newValue) {
                                    setState(() {
                                      // dropdownValue = newValue;
                                      indexw =
                                          locationSelectList.indexOf(newValue!);
                                      print('----- value ------');
                                      print(dropdownValue!.zoneId.toString() +
                                          " " +
                                          dropdownValue!.zoneName.toString());
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
                        Padding(
                          padding: EdgeInsets.only(bottom: 30),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              //  margin: EdgeInsets.only(bottom: 10, top: 10),
                              height: editTextHeight,
                              width: 300,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Display name is Required';
                                  }

                                  return null;
                                },
                                maxLines: 1,
                                controller: displayNameController,
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
                                  labelText: S.of(context).lowprice,
                                  // hintText: 'ค่าใช้จ่ายขั้นต่ำ',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              //  margin: EdgeInsets.only(bottom: 10, top: 10),
                              height: editTextHeight,
                              width: 300,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Display name is Required';
                                  }

                                  return null;
                                },
                                maxLines: 1,
                                controller: displayNameController,
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
                                  labelText: S.of(context).heightprice,
                                  // hintText: 'ค่าใช้จ่ายขั้นสุง',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30),
                        ),

                        /* Container(
                              //  margin: EdgeInsets.only(bottom: 10, top: 10),
                              // height: editTextHeight,
                             width: 300,
                             // width: 800,
                              // height: 100,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Display name is Required';
                                  }

                                  return null;
                                },
                                maxLines: 10,
                                controller: displayNameController,
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
                                  labelText: S.of(context).about,
                                  // hintText: 'เกี่ยวกับ',
                                ),
                              ),
                            ),
                            */

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              //  margin: EdgeInsets.only(bottom: 10, top: 10),
                              // height: editTextHeight,
                              width: 1270,
                              // height: 300,
                              // height: 100,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Display name is Required';
                                  }

                                  return null;
                                },
                                maxLines: 10,
                                controller: displayNameController,
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
                                  labelText: S.of(context).about,
                                  // hintText: 'เกี่ยวกับ',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30),
                        ),

                        /* Padding(
                         padding: const EdgeInsets.only(right: 470),
                         child: Stack(
                            children: <Widget>[
                              Container(
                                height: 500.0,
                               // color: Colors.pinkAccent,
                                
                               margin: EdgeInsets.only(bottom: 10, top: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                  border: Border.all(
                                      color: ConstantData.kGreyTextColor),
                                ),
                              ),
                              /* Positioned(
                                  left: 10,
                                  bottom: 170,
                                  child: Container(
                                    color: Colors.white,
                                    child: Container(
                                        color: ConstantData.bgColor,
                                        child: Text('คุณคือใคร')),
                                  ),
                                ),*/

                              Padding(
                                padding: EdgeInsets.only(
                                  top: 25,
                                ),
                                child: Container(
                                    width: 300,
                                    height: 700,
                                    child: CheckBoxListTileExample()),
                              ),
                              //),
                            ],
                          ),
                       ),
                        */

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text('data'),
                            Container(
                              //  margin: EdgeInsets.only(bottom: 10, top: 10),
                              // height: editTextHeight,
                              width: 1270,
                              height: 500,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.0),
                                border: Border.all(
                                    color: ConstantData.kGreyTextColor),
                              ),
                              // child: WorkCheckBox(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: ListView.builder(
                                  // itemCount: _data.length,
                                  itemCount: allWorkList2.length,
                                  itemBuilder: (context, index) {
                                    return CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      
                                       title: Text(
                                        allWorkList2[index].data.workName.toString() 
                                          
                                      ),
                                      
                                      value:  allWorkList2[index].isSelected,
                                      onChanged: (val) {
                                        setState(
                                          () {
                                            allWorkList2[index].isSelected = val!;
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),

                              /*child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 30, right: 30),
                                  child: ListView.builder(
                                    itemCount: _data.length,
                                    itemBuilder: (context, index) {
                                      return CheckboxListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        // secondary: Icon(Icons.person),
                                        title: Text(
                                          _data[index].title +
                                              " " +
                                              (index + 1).toString(),
                                        ),
                                        
                                        value: _data[index].isSelected,
                                        onChanged: (val) {
                                          setState(
                                            () {
                                              _data[index].isSelected = val!;
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),*/
                            ),
                          ],
                        ),
                        InkWell(
                          child: Container(
                              width: 500,
                              margin: EdgeInsets.only(top: 20),
                              height: 50,
                              decoration: BoxDecoration(
                                  color: ConstantData.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: InkWell(
                                child: Center(
                                  child:
                                      ConstantWidget.getCustomTextWithoutAlign(
                                          S.of(context).save,
                                          Colors.white,
                                          FontWeight.w900,
                                          ConstantData.font15Px),
                                ),
                              )),
                          onTap: () {
                            // toSaveCustomeProfile();
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30),
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

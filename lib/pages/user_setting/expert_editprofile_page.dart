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
  TextEditingController lowPriceController = new TextEditingController();
  TextEditingController heightPriceController = new TextEditingController();
  TextEditingController aboutController = new TextEditingController();
  List<String> work = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LocationModel? selectZoneValue;
  CareerTypeDataModel? selectWorkTypeValue;
  late List<UserProfileData> userprofileList = [];
  List<WorkData> allWorkList = [];
  List<Data> allWorkList2 = [];
  //DateTime checkInDate = DateTime.now();
  // DateTime checkOutDate = DateTime.now();
  DateTime? birthDate = DateTime.now();
  DateTime toDay = DateTime.now();

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
      // print(response.body);
      if (response.statusCode == 200) {
        final UserProfileResponseModel userprofile =
            UserProfileResponseModel.fromJson(
                convert.jsonDecode(response.body));
        setState(() {
          userprofileList = userprofile.data;
          //print(userprofileList[0].userProfileName.toString());
          prepareShowData();
        });
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  late String _selectedGender = 'ชาย';

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

  convertDate() {
    var dob = "${birthDate!.year}-${birthDate!.month}-${birthDate!.day}";
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

  saveExpertProfile() async {
    //print(displayNameController.value);
    var data = {
      "user_id":userprofileList[0].userProfileUserId,
      "user_profile_id": userprofileList[0].userProfileId,
      "user_profile_name": displayNameController.value.text.isEmpty ||
              displayNameController.value.text.trim().toString() == ""
          ? ''
          : displayNameController.text,
      "user_profile_type2": selectWorkTypeValue!.user_type2_id == 0
          ? null
          : selectWorkTypeValue!.user_type2_id,
      "user_profile_zone_id":
          selectZoneValue!.zoneId == 0 ? '' : selectZoneValue!.zoneId,
      "user_profile_gender": _selectedGender == 'ชาย' ? "m" : "f",
      "user_profile_birth_date": birthDate == toDay ? null : convertDate(),
      "user_profile_facebook_id": facebookController.value.text.isEmpty ||
              facebookController.value.text.trim().toString() == ""
          ? null
          : facebookController.text,
      "user_profile_line_id": lineIdController.value.text.isEmpty ||
              lineIdController.value.text.trim().toString() == ""
          ? null
          : lineIdController.text,
      "user_profile_tel": phoneController.value.text.isEmpty ||
              phoneController.value.text.trim().toString() == ""
          ? null
          : phoneController.text,
      "user_profile_price": lowPriceController.value.text.isEmpty ||
              lowPriceController.value.text.trim().toString() == ""
          ? 0
          : lowPriceController.text,
      "user_profile_price2": heightPriceController.value.text.isEmpty ||
              heightPriceController.value.text.trim().toString() == ""
          ? 0
          : heightPriceController.text,
      "user_profile_about": aboutController.value.text.isEmpty ||
              aboutController.value.text.trim().toString() == ""
          ? null
          : aboutController.text,
      "work_id": work
    };

    print(data);
    try {
      Uri url = Uri.parse(Config.BASE_URL +
          '/api/user/userprofile/update-profile'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      // print(widget.userId);
      if (response.statusCode == 200) {
        print(response.body);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Update ข้อมูลสำเร็จ')));
        Navigator.of(context).pop();
        // toGetUserProfileData();
      } else {
        print(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Update ข้อมูลไม่สำเร็จ')));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  prepareShowData() {
    displayNameController.text = userprofileList[0].userProfileName.toString();
    lineIdController.text = userprofileList[0].userProfileLineId.toString();
    facebookController.text =
        userprofileList[0].userProfileFacebookId.toString();
    phoneController.text = userprofileList[0].userProfileTel.toString();
    _selectedGender =
        userprofileList[0].userProfileGender == 'm' ? "ชาย" : "หญิง";
    lowPriceController.text = userprofileList[0].userProfilePrice.toString();
    heightPriceController.text =
        userprofileList[0].userProfilePrice2.toString();
    aboutController.text = userprofileList[0].userProfileAbout.toString();
    /* birthDate = userprofileList[0].userProfileBirthDate == null
        ? birthDate
        : userprofileList[0].userProfileBirthDate as DateTime;*/
     /* selectWorkTypeValue = (userprofileList[0].userProfileType2 == null
        ? selectWorkTypeValue
        : userprofileList[0].userProfileType2) as CareerTypeDataModel?;*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toGetUserProfileData();
    getDataZone();
    getDataExpertType();
    getDataWork();
    // prepareData();
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
            child: userprofileList.length == 0 //&& allWorkList.length == 0
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
                              'แก้ไขโปรไฟล์ ผู้เชี่ยวชาญ',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              //  margin: EdgeInsets.only(bottom: 10, top: 10),
                              height: editTextHeight,
                              width: 300,
                              child: TextFormField(
                                /*  validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Display name is Required';
                                  }

                                  return null;
                                },*/
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
                                  value: _selectedGender,
                                  /* value: ConstantWidget
                                          .getCustomTextWithoutAlign(
                                          _selectedGender,
                                              ConstantData.kGreyTextColor,
                                              FontWeight.normal,
                                              16.0),*/
                                  //isExpanded: true,

                                  icon: Icon(Icons.arrow_drop_down,
                                      color: Colors.grey.withOpacity(0.7)),
                                  items: items,

                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedGender = value!;
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
                                        // child: Text(value.user_type2_name.toString()),
                                        child: ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                value.user_type2_name
                                                    .toString(),
                                                ConstantData.kGreyTextColor,
                                                FontWeight.normal,
                                                16.0));
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
                                    initialDate: birthDate!,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2050),
                                  ).then((pickedDate) {
                                    if (pickedDate != null &&
                                        pickedDate != birthDate)
                                      setState(() {
                                        birthDate = pickedDate;
                                      });
                                  });

                                  print(birthDate);
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: ConstantWidget.getCustomText(
                                          DateFormat.yMMMd().format(birthDate!),
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
                                /*validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Line ID name is Required';
                                  }

                                  return null;
                                },*/
                                maxLines: 1,
                                controller: lineIdController,
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
                                /* validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Facebook is Required';
                                  }

                                  return null;
                                },*/
                                maxLines: 1,
                                controller: facebookController,
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
                                /* validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Phone is Required';
                                  }

                                  return null;
                                },*/
                                maxLines: 1,
                                controller: phoneController,
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
                                /*validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Low Price is Required';
                                  }

                                  return null;
                                },*/
                                maxLines: 1,
                                controller: lowPriceController,
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
                                /* validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Height Price is Required';
                                  }

                                  return null;
                                },*/
                                maxLines: 1,
                                controller: heightPriceController,
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
                                /* validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'About is Required';
                                  }

                                  return null;
                                },*/
                                maxLines: 10,
                                controller: aboutController,
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

                                      /* title: Text(
                                        allWorkList2[index].data.workName.toString() ,*/

                                      title: ConstantWidget
                                          .getCustomTextWithoutAlign(
                                              allWorkList2[index]
                                                  .data
                                                  .workName
                                                  .toString(),
                                              ConstantData.kGreyTextColor,
                                              FontWeight.normal,
                                              16.0),
                                      value: allWorkList2[index].isSelected,
                                      onChanged: (val) {
                                        setState(
                                          () {
                                            allWorkList2[index].isSelected =
                                                val!;

                                            if (allWorkList2[index]
                                                    .isSelected ==
                                                false) {
                                              work.remove(allWorkList2[index]
                                                  .data
                                                  .workId
                                                  .toString());
                                            } else {
                                              work.add(allWorkList2[index]
                                                  .data
                                                  .workId
                                                  .toString());
                                            }
                                            print('work  ==> + $work');
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),

                            
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
                          
                            // ignore: unrelated_type_equality_checks
                            if (selectZoneValue == null || selectZoneValue!.zoneId == 0 ||
                               selectWorkTypeValue == null || selectWorkTypeValue!.user_type2_id == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('กรุณาเลือก โซน และ ประเภท ')));
                            } else {
                              saveExpertProfile();
                            }
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

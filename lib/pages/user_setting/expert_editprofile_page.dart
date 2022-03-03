import 'package:flutter/material.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/models.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/services/config.dart';
import 'package:metex_app/utils/utils.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ExpertEditProfilePage extends StatefulWidget {
  ExpertEditProfilePage({Key? key}) : super(key: key);

  @override
  State<ExpertEditProfilePage> createState() => _ExpertEditProfilePageState();
}

class _ExpertEditProfilePageState extends State<ExpertEditProfilePage> {
  List<LocationModel> location = [];
  List<LocationModel> locationSelectList = [];
  TextEditingController displayNameController = new TextEditingController();
  TextEditingController searchController = new TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LocationModel? dropdownValue;

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
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
  getDataZone() async {
    var response = await http.get(
      Uri.parse(Config.BASE_URL +'/api/zone/all'),
    );
    if (response.statusCode == 200) {
      final ZoneModel zoneModel =
          ZoneModel.fromJson(convert.jsonDecode(response.body));
      setState(() {
        location = zoneModel.data;
        /* locationSelectList.add(
            LocationModel(zoneId: 0, zoneName: "เลือกโซน",zoneOrder: 0));
        locationSelectList.addAll(location);*/
      });
    } else {
      print('Error getDataZone');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataZone();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double editTextHeight = MediaQuery.of(context).size.height * 0.06;

   
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
            child: Form(
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
                  Center(
                    child: ConstantWidget.getCustomTextWithoutAlign(
                        S.of(context).editprofile,
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                        // padding: EdgeInsets.only(left: 100, right: 100),
                        width: 305,

                        decoration: BoxDecoration(
                          color: ConstantData.bgColor,
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: ConstantData.kGreyTextColor),
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
                                child: Text(value.zoneName.toString()),
                              );
                            }).toList(),
                            onChanged: (LocationModel? newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                print('----- value ------');
                                print(dropdownValue!.zoneId.toString() +
                                    " " +
                                    dropdownValue!.zoneName.toString());
                              });
                            },
                            hint: Text(
                              "------- เพศ -------",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
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
                        // padding: EdgeInsets.only(left: 100, right: 100),
                        width: 305,

                        decoration: BoxDecoration(
                          color: ConstantData.bgColor,
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: ConstantData.kGreyTextColor),
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
                                child: Text(value.zoneName.toString()),
                              );
                            }).toList(),
                            onChanged: (LocationModel? newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                print('----- value ------');
                                print(dropdownValue!.zoneId.toString() +
                                    " " +
                                    dropdownValue!.zoneName.toString());
                              });
                            },
                            hint: Text(
                              "------- ระบุประเภท -------",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
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
                        // padding: EdgeInsets.only(left: 100, right: 100),
                        width: 305,

                        decoration: BoxDecoration(
                          color: ConstantData.bgColor,
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: ConstantData.kGreyTextColor),
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
                                child: Text(value.zoneName.toString()),
                              );
                            }).toList(),
                            onChanged: (LocationModel? newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                print('----- value ------');
                                print(dropdownValue!.zoneId.toString() +
                                    " " +
                                    dropdownValue!.zoneName.toString());
                              });
                            },
                            hint: Text(
                              "------- วันที่ -------",
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
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                  ),
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        // height: 40.0,
                        height: editTextHeight,
                        // padding: EdgeInsets.only(left: 100, right: 100),
                        width: 305,

                        decoration: BoxDecoration(
                          color: ConstantData.bgColor,
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: ConstantData.kGreyTextColor),
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
                                child: Text(value.zoneName.toString()),
                              );
                            }).toList(),
                            onChanged: (LocationModel? newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                print('----- value ------');
                                print(dropdownValue!.zoneId.toString() +
                                    " " +
                                    dropdownValue!.zoneName.toString());
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        //  margin: EdgeInsets.only(bottom: 10, top: 10),
                       // height: editTextHeight,
                       // width: 300,
                       width: 800,
                       height: 500,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Display name is Required';
                            }

                            return null;
                          },
                          maxLines: 20,
                          controller: displayNameController,
                          // controller:  S.of(context).documentNo.toString(),
                          style: TextStyle(
                              fontFamily: ConstantData.fontFamily,
                              color: ConstantData.primaryTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),

                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                              const Radius.circular(5),
                            )),
                             labelText: S.of(context).about,
                           // hintText: 'เกี่ยวกับ',
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                              const Radius.circular(5),
                            )),
                            labelText: S.of(context).skill,
                            // hintText: 'ทำอะไรได้บ้าง',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),

                       Stack(
                            children: <Widget>[
                              Container(
                                height: 170.0,
                                margin: EdgeInsets.only(bottom: 10, top: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                  border: Border.all(
                                      color: ConstantData.kGreyTextColor),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                bottom: 170,
                                child: Container(
                                  color: Colors.white,
                                  child: Container(
                                      color: ConstantData.bgColor,
                                      child: Text('คุณคือใคร')),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                  top: 25,
                                ),
                                child: Container(
                                  width: 200,
                                  height: 200,
                                   color: Colors.pink,
                                  /*child: Column(
                                    children: fList
                                        .map((data) => RadioListTile(
                                              title: Text("${data.name}"),
                                              groupValue: id,
                                              value: data.index,
                                              onChanged: (val) {
                                                setState(() {
                                                  // radioItem = data.type;
                                                  id = data.index;

                                                  selectType = data.type;
                                                  print(selectType);
                                                });
                                              },
                                            ))
                                        .toList(),
                                  ),*/
                                ),
                              ),
                              //),
                            ],
                          ),
                          
                    ],
                  ),
                 /* Padding(
                    padding: EdgeInsets.only(bottom: 30),
                  ),*/
                  /* Container(
                    // height: 40.0,
                    height: editTextHeight,
                    padding: EdgeInsets.only(left: 180, right: 180),
                    /*decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(),
                            color: Colors.cyanAccent),*/

                    //   margin: EdgeInsets.only(bottom: 10, top: 10,left: 20, right: 20),
                    // height: editTextHeight,
                    decoration: BoxDecoration(
                      color: ConstantData.bgColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ConstantData.kGreyTextColor),
                      /* border: Border.all(
                              color: ConstantData.lightGrey, width: .5),*/
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        icon: Icon(Icons.arrow_drop_down,
                            color: Colors.grey.withOpacity(0.7)),
                        items: items,
                        onChanged: (String? value) {
                          /* setState(() {
                        _selectedValue = value!;
                      });*/
                          print('----- value ------');
                          print(_selectedValue);
                        },
                        hint: Text(
                          "---- เพศ ----",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        // value: _selectedValue,
                      ),
                    ),
                  ),
                  */
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
                      // toSaveCustomeProfile();
                    },
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

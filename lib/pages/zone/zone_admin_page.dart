import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/pages/zone/drivers_table.dart';
import 'package:metex_app/utils/utils.dart';

class ZoneAdminPage extends StatefulWidget {
  const ZoneAdminPage({Key? key}) : super(key: key);

  @override
  _ZoneAdminPageState createState() => _ZoneAdminPageState();
}

class _ZoneAdminPageState extends State<ZoneAdminPage> {
  TextEditingController emailController = new TextEditingController();
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  late String _selectedValue = 'บนสุด';
  List<DropdownMenuItem<String>> items = [
    'บนสุด',
    'ต่อจาก -> กรุงเทพมหานคร',
    'ต่อจาก -> กำแพงเพชร',
    'ต่อจาก -> ชัยนาท',
    'ต่อจาก -> นครนายก',
    'ต่อจาก -> เชียงใหม่',
    'ต่อจาก -> กระบี่',
    'ต่อจาก -> น่าน',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double editTextHeight = MediaQuery.of(context).size.height * 0.06;
    /* return WillPopScope(
      child: Scaffold(
        backgroundColor: ConstantData.bgColor,
        appBar: AppBar(
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
        ),
        body: Container(
         //  color: Colors.pink,

          margin: EdgeInsets.only(
            // bottom: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                child: Container(
                  //  margin: EdgeInsets.only(top: 20),
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      color: ConstantData.dangerColor,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  /* child: InkWell(
                    child: Center(
                      child: ConstantWidget.getCustomTextWithoutAlign(
                          S.of(context).adminbutton,
                          Colors.white,
                          FontWeight.w900,
                          ConstantData.font15Px),
                    ),

                     
                  ),*/

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info,
                        size: 20,
                        color: ConstantData.whiteColor,
                      ),
                      /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                      SizedBox(
                        width: 10,
                      ),
                      ConstantWidget.getCustomTextWithoutAlign(
                          S.of(context).adminbutton,
                          ConstantData.whiteColor,
                          FontWeight.w900,
                          ConstantData.font15Px),
                    ],
                  ),
                ),
                /*onTap: () {
                  Navigator.pushNamed(context, '/tabwidget');
                },*/
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
              ),
              Container(
                child: ConstantWidget.getCustomTextWithoutAlign(
                    S.of(context).zone,
                    // Colors.black,
                    ConstantData.primaryColor,
                    FontWeight.w900,
                    32.0),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
              ),
              Container(
                child: ConstantWidget.getCustomTextWithoutAlign(
                    S.of(context).add,
                    // Colors.black,
                    ConstantData.primaryColor,
                    FontWeight.w900,
                    20.0),
              ),
              Row(
                children: [
                  Container(
                    width: 200,
                    margin: EdgeInsets.only(bottom: 10, top: 20),
                    height: editTextHeight,
                    child: TextField(
                      maxLines: 1,
                      controller: emailController,
                      // controller:  S.of(context).documentNo.toString(),
                      style: TextStyle(
                          fontFamily: ConstantData.fontFamily,
                          color: ConstantData.primaryTextColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),

                      decoration: InputDecoration(
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                          const Radius.circular(5),
                        )),
                        // labelText: S.of(context).email,
                        // hintText: 'Full Name',
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(top: 10, left: 15),
                      height: 50,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: ConstantData.lightGrey, width: .5),
                      ),
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 20,
                            ),
                            ConstantWidget.getCustomTextWithoutAlign(
                                S.of(context).add,
                                ConstantData.textColor,
                                FontWeight.w900,
                                ConstantData.font15Px),
                          ],
                        ),
                      ),
                    ),
                    /*onTap: () {
                  Navigator.pushNamed(context, '/tabwidget');
                },*/
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
              ),
              Container(
                child: ConstantWidget.getCustomTextWithoutAlign(
                    S.of(context).data,
                    // Colors.black,
                    ConstantData.primaryColor,
                    FontWeight.w900,
                    20.0),
              ),
              //DriversTable(),
              Container(
              //  color: Colors.red,
              
                //padding: const EdgeInsets.all(5),
                margin: EdgeInsets.only(bottom: 30),
                child: DataTable2(
                  horizontalMargin: 10.0,
                  columnSpacing: 120.0,
                  //minWidth: 600,
                  columns: [
                    DataColumn2(
                      label: Text("ID"),
                      // size: ColumnSize.L,
                    ),
                    DataColumn(
                      label: Text('ชื่อ'),
                    ),
                    DataColumn(
                      label: Text('Order'),
                    ),
                    DataColumn2(
                      label: Text('จัดการ'),
                      size: ColumnSize.L,
                    ),
                   
                  ],
                  rows: List<DataRow>.generate(
                    8,
                    (index) => DataRow(
                      cells: [
                        DataCell(CustomText(
                            text: "1",
                            size: 16,
                            color: Colors.black,
                            weight: FontWeight.normal)),
                        DataCell(CustomText(
                            text: "เชียงใหม่",
                            size: 16,
                            color: Colors.black,
                            weight: FontWeight.normal)),
                        DataCell(CustomText(
                            text: "3",
                            size: 16,
                            color: Colors.black,
                            weight: FontWeight.normal)),
                      
                        DataCell(
                          Row(
                            children: [
                            
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: ConstantData.lightGrey,
                                        width: .5),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  child: InkWell(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          size: 16,
                                        ),
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                S.of(context).edit,
                                                ConstantData.textColor,
                                                FontWeight.w900,
                                                ConstantData.font15Px),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Navigator.pushNamed(context, '/tabwidget');
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                              ),
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: ConstantData.lightGrey,
                                        width: .5),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  child: InkWell(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          size: 16,
                                        ),
                                        ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                S.of(context).edit,
                                                ConstantData.textColor,
                                                FontWeight.w900,
                                                ConstantData.font15Px),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Navigator.pushNamed(context, '/tabwidget');
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                              ),
                              Container(
                                height: 40.0,
                                padding: EdgeInsets.only(left: 10, right: 10),
                              
                                decoration: BoxDecoration(
                                  color: ConstantData.whiteColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: ConstantData.lightGrey, width: .5),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                   // icon: Icon(Icons.arrow_drop_down_circle,
                                      icon: Icon(Icons.arrow_drop_down,
                                        color: Colors.grey.withOpacity(0.7)),
                                    items: items,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                      print('----- value ------');
                                      print(_selectedValue);
                                    },
                                    hint: Text(
                                      "-- เลื่อนลำดับ --",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                     value: _selectedValue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                 
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: _requestPop,
    );
  */

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
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                ),
                InkWell(
                  child: Container(
                    //  margin: EdgeInsets.only(top: 20),
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        color: ConstantData.dangerColor,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    /* child: InkWell(
                    child: Center(
                      child: ConstantWidget.getCustomTextWithoutAlign(
                          S.of(context).adminbutton,
                          Colors.white,
                          FontWeight.w900,
                          ConstantData.font15Px),
                    ),

                     
                  ),*/

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info,
                          size: 20,
                          color: ConstantData.whiteColor,
                        ),
                        /* Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),),*/
                        SizedBox(
                          width: 10,
                        ),
                        ConstantWidget.getCustomTextWithoutAlign(
                            S.of(context).adminbutton,
                            ConstantData.whiteColor,
                            FontWeight.w900,
                            ConstantData.font15Px),
                      ],
                    ),
                  ),
                  /*onTap: () {
                  Navigator.pushNamed(context, '/tabwidget');
                },*/
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                ),
                Container(
                  child: ConstantWidget.getCustomTextWithoutAlign(
                      S.of(context).zone,
                      // Colors.black,
                      ConstantData.primaryColor,
                      FontWeight.w900,
                      32.0),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                ),
                Container(
                  child: ConstantWidget.getCustomTextWithoutAlign(
                      S.of(context).add,
                      // Colors.black,
                      ConstantData.primaryColor,
                      FontWeight.w900,
                      20.0),
                ),
                Row(
                  children: [
                    Container(
                      width: 200,
                      margin: EdgeInsets.only(bottom: 10, top: 20),
                      height: editTextHeight,
                      child: TextField(
                        maxLines: 1,
                        controller: emailController,
                        // controller:  S.of(context).documentNo.toString(),
                        style: TextStyle(
                            fontFamily: ConstantData.fontFamily,
                            color: ConstantData.primaryTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 20),

                        decoration: InputDecoration(
                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                            const Radius.circular(5),
                          )),
                          // labelText: S.of(context).email,
                          // hintText: 'Full Name',
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top: 10, left: 15),
                        height: 50,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: ConstantData.lightGrey, width: .5),
                        ),
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 20,
                              ),
                              ConstantWidget.getCustomTextWithoutAlign(
                                  S.of(context).add,
                                  ConstantData.textColor,
                                  FontWeight.w900,
                                  ConstantData.font15Px),
                            ],
                          ),
                        ),
                      ),
                      /*onTap: () {
                  Navigator.pushNamed(context, '/tabwidget');
                },*/
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                ),
                Container(
                  child: ConstantWidget.getCustomTextWithoutAlign(
                      S.of(context).data,
                      // Colors.black,
                      ConstantData.primaryColor,
                      FontWeight.w900,
                      20.0),
                ),
                //DriversTable(),
                Container(
                  //  color: Colors.red,

                  //padding: const EdgeInsets.all(5),
                  margin: EdgeInsets.only(bottom: 30),
                  child: DataTable2(
                    horizontalMargin: 10.0,
                    columnSpacing: 120.0,
                    //minWidth: 600,
                    columns: [
                      DataColumn2(
                        label: Text("ID"),
                        // size: ColumnSize.L,
                      ),
                      DataColumn(
                        label: Text('ชื่อ'),
                      ),
                      DataColumn(
                        label: Text('Order'),
                      ),
                      DataColumn2(
                        label: Text('จัดการ'),
                        size: ColumnSize.L,
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      30,
                      (index) => DataRow(
                        cells: [
                          DataCell(CustomText(
                              text: "1",
                              size: 16,
                              color: Colors.black,
                              weight: FontWeight.normal)),
                          DataCell(CustomText(
                              text: "เชียงใหม่",
                              size: 16,
                              color: Colors.black,
                              weight: FontWeight.normal)),
                          DataCell(CustomText(
                              text: "3",
                              size: 16,
                              color: Colors.black,
                              weight: FontWeight.normal)),
                          DataCell(
                            Row(
                              children: [
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: ConstantData.lightGrey,
                                          width: .5),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    child: InkWell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            size: 16,
                                          ),
                                          ConstantWidget
                                              .getCustomTextWithoutAlign(
                                                  S.of(context).edit,
                                                  ConstantData.textColor,
                                                  FontWeight.w900,
                                                  ConstantData.font15Px),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    // Navigator.pushNamed(context, '/tabwidget');
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                ),
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: ConstantData.lightGrey,
                                          width: .5),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    child: InkWell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            size: 16,
                                          ),
                                          ConstantWidget
                                              .getCustomTextWithoutAlign(
                                                  S.of(context).edit,
                                                  ConstantData.textColor,
                                                  FontWeight.w900,
                                                  ConstantData.font15Px),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    // Navigator.pushNamed(context, '/tabwidget');
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                ),
                                Container(
                                  height: 40.0,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    color: ConstantData.whiteColor,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: ConstantData.lightGrey,
                                        width: .5),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      // icon: Icon(Icons.arrow_drop_down_circle,
                                      icon: Icon(Icons.arrow_drop_down,
                                          color: Colors.grey.withOpacity(0.7)),
                                      items: items,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _selectedValue = value!;
                                        });
                                        print('----- value ------');
                                        print(_selectedValue);
                                      },
                                      hint: Text(
                                        "-- เลื่อนลำดับ --",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      value: _selectedValue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
    );
  }
}

import 'package:data_table_2/data_table_2.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/pages/widgets/custom_text.dart';
import 'package:metex_app/utils/utils.dart';

/// Example without datasource
class DriversTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late String _selectedValue = 'Android';
    List<DropdownMenuItem<String>> items = [
      'Android',
      'IOS',
      'Flutter',
      'Node',
      'Java',
      'Python',
      'PHP',
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      );
    }).toList();

    return Container(
      /* decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ConstantData.active.withOpacity(.4), width: .5),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: ConstantData.lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        borderRadius: BorderRadius.circular(8),
      ),*/
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
          /* DataColumn(
            label: Text('จัดการ'),
          ),*/
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
              /*DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.deepOrange,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CustomText(
                      text: "4.5",
                      size: 16,
                      color: Colors.black,
                      weight: FontWeight.normal,
                    )
                  ],
                ),
              ),*/
              DataCell(
                Row(
                  children: [
                    /* Container(
                      decoration: BoxDecoration(
                        color: ConstantData.light,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: ConstantData.active, width: .5),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: CustomText(
                        text: "แก้ไข",
                        color: ConstantData.active.withOpacity(.7),
                        weight: FontWeight.bold,
                        size: 16,
                      ),
                    ),*/
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: ConstantData.lightGrey, width: .5),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit,
                                size: 16,
                              ),
                              ConstantWidget.getCustomTextWithoutAlign(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: ConstantData.lightGrey, width: .5),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete,
                                size: 16,
                              ),
                              ConstantWidget.getCustomTextWithoutAlign(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                    Container(
                      height: 40.0,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      /*decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(),
                          color: Colors.cyanAccent),*/
                      decoration: BoxDecoration(
                        color: ConstantData.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: ConstantData.lightGrey, width: .5),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          icon: Icon(Icons.arrow_drop_down_circle,
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
                            "-- เลื่อนลำดับ --",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          // value: _selectedValue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /* DataCell(
                Container(
                  decoration: BoxDecoration(
                    color: ConstantData.light,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ConstantData.active, width: .5),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: CustomText(
                    text: "Block",
                    color: ConstantData.active.withOpacity(.7),
                    weight: FontWeight.bold,
                    size: 16,
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

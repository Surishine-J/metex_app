import 'package:flutter/material.dart';
import 'package:metex_app/pages/about/about_page.dart';
import 'package:metex_app/pages/group/group_afterLogin_page.dart';
import 'package:metex_app/pages/group/group_beforeLogin_page.dart';
import 'package:metex_app/pages/group/group_page.dart';
import 'package:metex_app/pages/home/home_beforeLogin_page.dart';
import 'package:metex_app/pages/login/user_login_page.dart';
import 'package:metex_app/pages/nav/test2.dart';

import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/pages/register/register_page.dart';
import 'package:metex_app/utils/utils.dart';

class NavBeforeLoginPage extends StatefulWidget {
  @override
  _NavBeforeLoginPageState createState() => _NavBeforeLoginPageState();
}

class _NavBeforeLoginPageState extends State<NavBeforeLoginPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollViewController;
/*toCheckLoginData() async {
    var data = {"user_id": widget.userId};
    try {
      Uri url = Uri.parse('http://127.0.0.1:3000/api/user/user'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      // print(widget.userId);
      if (response.statusCode == 200) {
        //print(response.body);
        final UserResponseModel user =
            UserResponseModel.fromJson(convert.jsonDecode(response.body));
        setState(() {
          userList = user.data;
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('ไม่พบผู้ใช้ ')));
      }
    } catch (e) {
      print(e.toString());
    }
  }*/



  @override
  void initState() {
    super.initState();
   _tabController = TabController(vsync: this, length: 5);
   _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The System Back Button is Deactivated')));
        return false;
      },
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          //resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size(screenSize.width, 100.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 70 ,
              decoration: BoxDecoration(
                // color: Colors.green,
                color: ConstantData.primaryColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    // color: Colors.white,
                    offset: Offset(0, 2),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // color: Colors.red,
                          margin: EdgeInsets.only(right: 20),//20
                          child: Image.asset(
                            ConstantData.assetsImagePath + "logo/200-3.png",
                            height: 50,
                          ),
                        ),
                        //),
                        Container(
                         // color: Colors.red,
                          height: double.infinity,
                          // height: 90,
                          width: 700,
                          child: TabBar(
                            indicatorColor: ConstantData.whiteColor,
                            indicatorWeight: 3.0,

                            tabs: [
                              Tab(
                                  icon: Icon(Icons.search, size: 24),
                                  text: "ค้นหา"),
                              Tab(
                                  icon: Icon(Icons.group, size: 24),
                                  text: "กลุ่ม"),
                              Tab(
                                  icon: Icon(Icons.info, size: 24),
                                  text: "ข้อมูล"),
                              Tab(
                                  icon: Icon(Icons.login, size: 24),
                                  text: "เข้าสู่ระบบ"),
                              Tab(
                                  icon:
                                      Icon(Icons.check_box_outlined, size: 24),
                                  text: "สมัครสมาชิก"),
                              /*Tab(
                              icon: Icon(Icons.settings, size: 24),
                              text: "หน้าแอดมิน"),*/
                            ],

                             /*labelStyle: TextStyle(
                                color: ConstantData.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: ConstantData.font15Px,
                                fontFamily: ConstantData.fontFamily),*/

                            // unselectedLabelStyle: TextStyle(
                            //     color: ConstantData.whiteColor,
                            //     fontWeight: FontWeight.w700,
                            //     fontSize: ConstantData.font15Px,
                            //     fontFamily: ConstantData.fontFamily),
                          ),
                        ),
                      ],
                    ),
                  
            ),
          ),
          /* body: IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),*/

          body: TabBarView(
            children: [
              HomeBeforeLoginPage(),
              GroupBeforeLoginPage(),
              AboutPage(),
              // DemoApp(),
              UserLoginPage(),
              RegisterPage(),
              // AdminSettingPage2()
            ],
          ),
        ),
      ),
    );
  }
}

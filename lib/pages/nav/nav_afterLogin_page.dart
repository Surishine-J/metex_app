import 'package:flutter/material.dart';
import 'package:metex_app/models/models.dart';
import 'package:metex_app/pages/about/about_page.dart';
import 'package:metex_app/pages/admin_setting/admin_setting_page.dart';
import 'package:metex_app/pages/favorite/favorite_page.dart';
import 'package:metex_app/pages/group/group_afterLogin_page.dart';
import 'package:metex_app/pages/group/group_page.dart';
import 'package:metex_app/pages/home/home_afterAdminLogin_page%20.dart';
import 'package:metex_app/pages/home/home_beforeLogin_page.dart';

import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/utils/utils.dart';

class NavAfterLoginPage extends StatefulWidget {
  //late List<User> userList;
  String userId;
  String userName;
  String userType;
  NavAfterLoginPage(
      {Key? key,
      required this.userId,
      required this.userName,
      required this.userType})
      : super(key: key);
  @override
  _NavAfterLoginPageState createState() => _NavAfterLoginPageState();
}

class _NavAfterLoginPageState extends State<NavAfterLoginPage> {
  late List<User> userLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // userLogin = widget.userList;
    print(widget.userId);
    print(widget.userType);
  }
  //late  User? userLogin = widget.user;

  /*bool isAdmin() {
    String user = 'admin';
    bool result = false;

    if (user == 'admin') {
      result = true;
    }

    return result;
  }*/

  bool isUser() {
    /*  String user = 'admin';
    bool result = false;
    if (user == 'admin') {
      result = true;
    }
    return result;*/

    if (widget.userType == 'a' ||
        widget.userType == 'c' ||
        widget.userType == 'u') {
      return true;
    }
    return false;
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
       // length: 5,
         length: isUser()
            ? 5
            : 4,
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size(screenSize.width, 100.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  height: 70.0,
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
                      // Expanded(
                      /* child: Text(
                'Metex',
                style: const TextStyle(
                  // color: Palette.facebookBlue,
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2,
                ),
              ),*/

                      Container(
                        // color: Colors.red,
                        margin: EdgeInsets.only(right: 20),
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
                        width: 700.0,
                        /* child: TabBar(
                        indicatorColor: ConstantData.whiteColor,
                        indicatorWeight: 3.0,
    
                        tabs: [
                          Tab(icon: Icon(Icons.search, size: 24), text: "ค้นหา"),
                          Tab(icon: Icon(Icons.group, size: 24), text: "กลุ่ม"),
                          Tab(icon: Icon(Icons.info, size: 24), text: "ข้อมูล"),
                          Tab(
                              icon: Icon(Icons.favorite, size: 24),
                              text: "ถูกใจ"),
                          Tab(icon: Icon(Icons.person, size: 24), text: "ผู้ใช้"),
                          Tab(
                              icon: Icon(Icons.settings, size: 24),
                              text: "หน้าแอดมิน"),
                        ],
                      
    
                        //  labelStyle: TextStyle(
                        //     color: ConstantData.whiteColor,
                        //     fontWeight: FontWeight.w700,
                        //     fontSize: ConstantData.font15Px,
                        //     fontFamily: ConstantData.fontFamily),
    
                        // unselectedLabelStyle: TextStyle(
                        //     color: ConstantData.whiteColor,
                        //     fontWeight: FontWeight.w700,
                        //     fontSize: ConstantData.font15Px,
                        //     fontFamily: ConstantData.fontFamily),
                      ),*/

                        child: isUser()
                            ? TabBar(
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
                                      icon: Icon(Icons.favorite, size: 24),
                                      text: "ถูกใจ"),
                                  // Tab(icon: Icon(Icons.person, size: 24), text: "ผู้ใช้"),
                                  Tab(
                                      icon: Icon(Icons.person, size: 24),
                                      text: "ผู้ใช้"),
                                ],

                                //  labelStyle: TextStyle(
                                //     color: ConstantData.whiteColor,
                                //     fontWeight: FontWeight.w700,
                                //     fontSize: ConstantData.font15Px,
                                //     fontFamily: ConstantData.fontFamily),

                                // unselectedLabelStyle: TextStyle(
                                //     color: ConstantData.whiteColor,
                                //     fontWeight: FontWeight.w700,
                                //     fontSize: ConstantData.font15Px,
                                //     fontFamily: ConstantData.fontFamily),
                              )
                            : TabBar(
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
                                 /* Tab(
                                      icon: Icon(Icons.favorite, size: 24),
                                      text: "ถูกใจ"),*/
                                  Tab(
                                      icon: Icon(Icons.settings, size: 24),
                                      text: "หน้าแอดมิน"),
                                ],

                                //  labelStyle: TextStyle(
                                //     color: ConstantData.whiteColor,
                                //     fontWeight: FontWeight.w700,
                                //     fontSize: ConstantData.font15Px,
                                //     fontFamily: ConstantData.fontFamily),

                                // unselectedLabelStyle: TextStyle(
                                //     color: ConstantData.whiteColor,
                                //     fontWeight: FontWeight.w700,
                                //     fontSize: ConstantData.font15Px,
                                //     fontFamily: ConstantData.fontFamily),
                              ),
                      ),
                    ],
                  ),
                )),
            /* body: IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),*/

            /* body: TabBarView(
            children: [
              HomePage(),
              GroupPage(),
              AboutPage(),
              UserLoginPage(),
              RegisterPage(),
              AdminSettingPage2()
            ],
          ),*/

            body: isUser()
                ? TabBarView(
                    children: [
                      HomeAfterLoginPage(userId: widget.userId,
                        userName: widget.userName,
                        userType: widget.userType,),
                      GroupAfterLoginPage(),
                      AboutPage(),
                      FavoritePage(userId: widget.userId,
                        userName: widget.userName,
                        userType: widget.userType,),
                      // UserSettingPage(),
                      UserSettingPage(userId: widget.userId,
                        userName: widget.userName,
                        userType: widget.userType,)
                    ],
                  )
                : TabBarView(
                    children: [
                      HomeAdminLoginPage(userId: widget.userId,
                        userName: widget.userName,
                        userType: widget.userType,),
                      GroupAfterLoginPage(),
                      AboutPage(),
                      /*FavoritePage(userId: widget.userId,
                        userName: widget.userName,
                        userType: widget.userType,),*/
                      AdminSettingPage()

                      //RegisterPage(),
                    ],
                  )),
      ),
    );
  }
}

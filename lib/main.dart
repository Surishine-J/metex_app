import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'package:metex_app/models/zone_models.dart';

import 'package:metex_app/pages/all_experts/all_experts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:metex_app/pages/login/user_login_page.dart';
import 'package:metex_app/pages/nav/test.dart';
import 'package:metex_app/pages/nav/test2.dart';
import 'package:metex_app/pages/nav/test3.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/pages/register/register_page.dart';
import 'package:metex_app/services/zone_services.dart';

import 'generated/l10n.dart';

import 'pages/nav/nav_afterLogin_page.dart';
import 'pages/nav/product_page.dart';


void main() {
 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // initialRoute: '/login',
      /*  initialRoute: '/',
      routes: {
        // '/':(context) =>  FacePileDemoScreen(),
       '/': (context) => NavDefaultPage(),
        '/nav': (context) => NavPage(),
        // '/nav': (context) =>  BasicDemo(),
        // '/nav': (context) =>  ExpertDetailsPage(),

        '/login': (context) => UserLoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => const HomePage(),
        '/group': (context) => GroupPage(),
        '/creategroup': (context) => CreateGroupPage(),
        '/editprofileadmin': (context) => const EditProfileAdminPage(),
        '/changepassword': (context) => const ChangePasswordPage(),
        '/zone': (context) => const ZoneAdminPage(),
        '/expertdetail': (context) => ExpertDetailsPage(),
        '/favorite': (context) => FavoritePage(),
        '/usersetting': (context) => UserSettingPage(),
        '/editemail': (context) => EditEmailPage(),
        '/editpassword': (context) => EditPasswordPage(),
        '/editpicture': (context) => EditPicturePage(),
        '/editprofile': (context) =>  EditProfilePage(),
        '/searchresult': (context) =>  SearchResultPage(),
        '/groupdetails': (context) =>  GroupDetailsPage(),
      },*/

      // home: MyHomePage(title: 'Flutter Demo Home Page'),
       home: NavBeforeLoginPage(),
      //home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<LocationModel> location = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _getDataZone();
  // ZoneServices().getDataZone();
  }

  _getDataZone() async {
    var response = await http.get(
      Uri.parse('http://127.0.0.1:3000/api/zone/all'),
    );
    if (response.statusCode == 200) {
      final ZoneModel zoneModel =
          ZoneModel.fromJson(convert.jsonDecode(response.body));
      setState(() {
        location = zoneModel.data;
      });
    } else {
      print('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Get Data Zones'),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(location[index].zoneName),
              subtitle: Text(location[index].zoneName),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
          itemCount: location.length),
    );
  }
}

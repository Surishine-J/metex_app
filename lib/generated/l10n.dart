// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `รหัสผ่าน`
  String get password {
    return Intl.message(
      'รหัสผ่าน',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `ยืนยันรหัสผ่าน`
  String get confirmpassword {
    return Intl.message(
      'ยืนยันรหัสผ่าน',
      name: 'confirmpassword',
      desc: '',
      args: [],
    );
  }

  /// `ลงชื่อเข้าใช้`
  String get login {
    return Intl.message(
      'ลงชื่อเข้าใช้',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `เข้าสู่ระบบ`
  String get enter {
    return Intl.message(
      'เข้าสู่ระบบ',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `เข้าสู่ระบบสำหรับแอดมิน`
  String get enteradmin {
    return Intl.message(
      'เข้าสู่ระบบสำหรับแอดมิน',
      name: 'enteradmin',
      desc: '',
      args: [],
    );
  }

  /// `ไปหน้าเข้าสู่ระบบสำหรับแอดมิน`
  String get adminloginpage {
    return Intl.message(
      'ไปหน้าเข้าสู่ระบบสำหรับแอดมิน',
      name: 'adminloginpage',
      desc: '',
      args: [],
    );
  }

  /// `สมัครสมาชิก`
  String get register {
    return Intl.message(
      'สมัครสมาชิก',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `ชื่อที่จะแสดง`
  String get displayname {
    return Intl.message(
      'ชื่อที่จะแสดง',
      name: 'displayname',
      desc: '',
      args: [],
    );
  }

  /// `คุณคือใคร`
  String get you {
    return Intl.message(
      'คุณคือใคร',
      name: 'you',
      desc: '',
      args: [],
    );
  }

  /// `สมัครเลย!`
  String get registerbutton {
    return Intl.message(
      'สมัครเลย!',
      name: 'registerbutton',
      desc: '',
      args: [],
    );
  }

  /// `ค้นหาจากชื่อ`
  String get searchbyname {
    return Intl.message(
      'ค้นหาจากชื่อ',
      name: 'searchbyname',
      desc: '',
      args: [],
    );
  }

  /// `ค้นหา`
  String get search {
    return Intl.message(
      'ค้นหา',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `อันดับที่`
  String get topstar {
    return Intl.message(
      'อันดับที่',
      name: 'topstar',
      desc: '',
      args: [],
    );
  }

  /// `TOP EXPERT`
  String get topexpert {
    return Intl.message(
      'TOP EXPERT',
      name: 'topexpert',
      desc: '',
      args: [],
    );
  }

  /// `ที่คุณถูกใจ`
  String get youfavorite {
    return Intl.message(
      'ที่คุณถูกใจ',
      name: 'youfavorite',
      desc: '',
      args: [],
    );
  }

  /// `รูปภาพ`
  String get picture {
    return Intl.message(
      'รูปภาพ',
      name: 'picture',
      desc: '',
      args: [],
    );
  }

  /// `ผ่านการประเมิน`
  String get verified {
    return Intl.message(
      'ผ่านการประเมิน',
      name: 'verified',
      desc: '',
      args: [],
    );
  }

  /// `หน้านี้แอดมินเห็นเท่านั้น`
  String get adminbutton {
    return Intl.message(
      'หน้านี้แอดมินเห็นเท่านั้น',
      name: 'adminbutton',
      desc: '',
      args: [],
    );
  }

  /// `แก้ไขข้อมูลส่วนตัว`
  String get editprofilebutton {
    return Intl.message(
      'แก้ไขข้อมูลส่วนตัว',
      name: 'editprofilebutton',
      desc: '',
      args: [],
    );
  }

  /// `เปลี่ยนรหัสผ่าน`
  String get changepasswordbutton {
    return Intl.message(
      'เปลี่ยนรหัสผ่าน',
      name: 'changepasswordbutton',
      desc: '',
      args: [],
    );
  }

  /// `ออกจากระบบ`
  String get logoutbutton {
    return Intl.message(
      'ออกจากระบบ',
      name: 'logoutbutton',
      desc: '',
      args: [],
    );
  }

  /// `ข้อมูลโซน`
  String get zonebutton {
    return Intl.message(
      'ข้อมูลโซน',
      name: 'zonebutton',
      desc: '',
      args: [],
    );
  }

  /// `ข้อมูลงาน`
  String get workbutton {
    return Intl.message(
      'ข้อมูลงาน',
      name: 'workbutton',
      desc: '',
      args: [],
    );
  }

  /// `แก้ไขข้อมูลส่วนตัวแอดมิน`
  String get editprofileadmin {
    return Intl.message(
      'แก้ไขข้อมูลส่วนตัวแอดมิน',
      name: 'editprofileadmin',
      desc: '',
      args: [],
    );
  }

  /// `ชื่อ`
  String get name {
    return Intl.message(
      'ชื่อ',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `บันทึก`
  String get save {
    return Intl.message(
      'บันทึก',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `รหัสผ่านเดิม`
  String get oldpassword {
    return Intl.message(
      'รหัสผ่านเดิม',
      name: 'oldpassword',
      desc: '',
      args: [],
    );
  }

  /// `รหัสผ่านใหม่`
  String get newpassword {
    return Intl.message(
      'รหัสผ่านใหม่',
      name: 'newpassword',
      desc: '',
      args: [],
    );
  }

  /// `ยืนยันรหัสผ่านใหม่`
  String get confirmnewpassword {
    return Intl.message(
      'ยืนยันรหัสผ่านใหม่',
      name: 'confirmnewpassword',
      desc: '',
      args: [],
    );
  }

  /// `เปลี่ยนรหัสผ่านแอดมิน`
  String get changepasswordadmin {
    return Intl.message(
      'เปลี่ยนรหัสผ่านแอดมิน',
      name: 'changepasswordadmin',
      desc: '',
      args: [],
    );
  }

  /// `เปลี่ยนรหัส`
  String get savechange {
    return Intl.message(
      'เปลี่ยนรหัส',
      name: 'savechange',
      desc: '',
      args: [],
    );
  }

  /// `โซน`
  String get zone {
    return Intl.message(
      'โซน',
      name: 'zone',
      desc: '',
      args: [],
    );
  }

  /// `เพิ่ม`
  String get add {
    return Intl.message(
      'เพิ่ม',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `ข้อมูล`
  String get data {
    return Intl.message(
      'ข้อมูล',
      name: 'data',
      desc: '',
      args: [],
    );
  }

  /// `แก้ไข`
  String get edit {
    return Intl.message(
      'แก้ไข',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `ผู้ให้บริการ`
  String get allexpert {
    return Intl.message(
      'ผู้ให้บริการ',
      name: 'allexpert',
      desc: '',
      args: [],
    );
  }

  /// `ลูกค้าทั้งหมด`
  String get allcustomer {
    return Intl.message(
      'ลูกค้าทั้งหมด',
      name: 'allcustomer',
      desc: '',
      args: [],
    );
  }

  /// `อายุ  `
  String get age {
    return Intl.message(
      'อายุ  ',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// ` ปี`
  String get year {
    return Intl.message(
      ' ปี',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `ส่วนควบคุมสำหรับแอดมิน`
  String get admincontroll {
    return Intl.message(
      'ส่วนควบคุมสำหรับแอดมิน',
      name: 'admincontroll',
      desc: '',
      args: [],
    );
  }

  /// `เข้าสู่ระบบผู้เชี่ยวชาญคนนี้`
  String get expertlogin {
    return Intl.message(
      'เข้าสู่ระบบผู้เชี่ยวชาญคนนี้',
      name: 'expertlogin',
      desc: '',
      args: [],
    );
  }

  /// `ปิดใช้งานผู้เชี่ยวชาญคนนี้`
  String get expertclose {
    return Intl.message(
      'ปิดใช้งานผู้เชี่ยวชาญคนนี้',
      name: 'expertclose',
      desc: '',
      args: [],
    );
  }

  /// `ปิดใช้งานยืนยันรูปภาพ`
  String get expertcloseauthen {
    return Intl.message(
      'ปิดใช้งานยืนยันรูปภาพ',
      name: 'expertcloseauthen',
      desc: '',
      args: [],
    );
  }

  /// `ปิดใช้งานเป็น TOP EXPERT`
  String get expertclosetop {
    return Intl.message(
      'ปิดใช้งานเป็น TOP EXPERT',
      name: 'expertclosetop',
      desc: '',
      args: [],
    );
  }

  /// `ลบผู้เชี่ยวชาญคนนี้`
  String get expertdelete {
    return Intl.message(
      'ลบผู้เชี่ยวชาญคนนี้',
      name: 'expertdelete',
      desc: '',
      args: [],
    );
  }

  /// `ออกจากระบบแอดมิน`
  String get adminlogout {
    return Intl.message(
      'ออกจากระบบแอดมิน',
      name: 'adminlogout',
      desc: '',
      args: [],
    );
  }

  /// `กลุ่ม`
  String get group {
    return Intl.message(
      'กลุ่ม',
      name: 'group',
      desc: '',
      args: [],
    );
  }

  /// `ชื่อกลุ่ม`
  String get groupname {
    return Intl.message(
      'ชื่อกลุ่ม',
      name: 'groupname',
      desc: '',
      args: [],
    );
  }

  /// `สร้างกลุ่ม`
  String get creategroup {
    return Intl.message(
      'สร้างกลุ่ม',
      name: 'creategroup',
      desc: '',
      args: [],
    );
  }

  /// `สร้าง`
  String get create {
    return Intl.message(
      'สร้าง',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `หน้าแอดมิน`
  String get adminsetting {
    return Intl.message(
      'หน้าแอดมิน',
      name: 'adminsetting',
      desc: '',
      args: [],
    );
  }

  /// `เกี่ยวกับเรา metex`
  String get aboutus {
    return Intl.message(
      'เกี่ยวกับเรา metex',
      name: 'aboutus',
      desc: '',
      args: [],
    );
  }

  /// `Metex ศูนย์รวมผู้เชี่ยวชาญในการพัฒนาองค์กร ไม่ว่าคุณจะต้องการพบผู้เชี่ยวชาญแบบไหน? เราเชื่อมต่อให้คุณ`
  String get msg_aboutus {
    return Intl.message(
      'Metex ศูนย์รวมผู้เชี่ยวชาญในการพัฒนาองค์กร ไม่ว่าคุณจะต้องการพบผู้เชี่ยวชาญแบบไหน? เราเชื่อมต่อให้คุณ',
      name: 'msg_aboutus',
      desc: '',
      args: [],
    );
  }

  /// `คุณต้องการผู้ให้บริการแบบไหน?`
  String get expertmsg {
    return Intl.message(
      'คุณต้องการผู้ให้บริการแบบไหน?',
      name: 'expertmsg',
      desc: '',
      args: [],
    );
  }

  /// `คุณต้องการคนปลูกอะไร`
  String get expertmsg2 {
    return Intl.message(
      'คุณต้องการคนปลูกอะไร',
      name: 'expertmsg2',
      desc: '',
      args: [],
    );
  }

  /// `เลือกได้มากกว่า 1 อย่าง`
  String get expertmsg3 {
    return Intl.message(
      'เลือกได้มากกว่า 1 อย่าง',
      name: 'expertmsg3',
      desc: '',
      args: [],
    );
  }

  /// `ถูกใจ`
  String get fav {
    return Intl.message(
      'ถูกใจ',
      name: 'fav',
      desc: '',
      args: [],
    );
  }

  /// `favorite`
  String get favorite {
    return Intl.message(
      'favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `โปรไฟล์ของฉัน`
  String get myprofile {
    return Intl.message(
      'โปรไฟล์ของฉัน',
      name: 'myprofile',
      desc: '',
      args: [],
    );
  }

  /// `แก้ไขโปรไฟล์`
  String get editprofile {
    return Intl.message(
      'แก้ไขโปรไฟล์',
      name: 'editprofile',
      desc: '',
      args: [],
    );
  }

  /// `แก้ไขรูปภาพ`
  String get editpicture {
    return Intl.message(
      'แก้ไขรูปภาพ',
      name: 'editpicture',
      desc: '',
      args: [],
    );
  }

  /// `เปลี่ยน Email`
  String get editemail {
    return Intl.message(
      'เปลี่ยน Email',
      name: 'editemail',
      desc: '',
      args: [],
    );
  }

  /// `เปลี่ยน รหัสผ่าน`
  String get editpassword {
    return Intl.message(
      'เปลี่ยน รหัสผ่าน',
      name: 'editpassword',
      desc: '',
      args: [],
    );
  }

  /// `แก้ไขโปรไฟล์ของฉัน`
  String get editagencyprofile {
    return Intl.message(
      'แก้ไขโปรไฟล์ของฉัน',
      name: 'editagencyprofile',
      desc: '',
      args: [],
    );
  }

  /// `แก้ไขโปรไฟล์ผู้เชี่ยวชาญ`
  String get editexpertprofile {
    return Intl.message(
      'แก้ไขโปรไฟล์ผู้เชี่ยวชาญ',
      name: 'editexpertprofile',
      desc: '',
      args: [],
    );
  }

  /// `Email เดิม`
  String get oldemail {
    return Intl.message(
      'Email เดิม',
      name: 'oldemail',
      desc: '',
      args: [],
    );
  }

  /// `Email ใหม่`
  String get newemail {
    return Intl.message(
      'Email ใหม่',
      name: 'newemail',
      desc: '',
      args: [],
    );
  }

  /// `เลือกรูปภาพ`
  String get selectpicture {
    return Intl.message(
      'เลือกรูปภาพ',
      name: 'selectpicture',
      desc: '',
      args: [],
    );
  }

  /// `ค่าใช้จ่ายขั้นต่ำ`
  String get lowprice {
    return Intl.message(
      'ค่าใช้จ่ายขั้นต่ำ',
      name: 'lowprice',
      desc: '',
      args: [],
    );
  }

  /// `ค่าใช้จ่ายขั้นสูง`
  String get heightprice {
    return Intl.message(
      'ค่าใช้จ่ายขั้นสูง',
      name: 'heightprice',
      desc: '',
      args: [],
    );
  }

  /// `LINE ID`
  String get lineid {
    return Intl.message(
      'LINE ID',
      name: 'lineid',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get facebook {
    return Intl.message(
      'Facebook',
      name: 'facebook',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `เกี่ยวกับ`
  String get about {
    return Intl.message(
      'เกี่ยวกับ',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `ทำอะไรได้บ้าง`
  String get skill {
    return Intl.message(
      'ทำอะไรได้บ้าง',
      name: 'skill',
      desc: '',
      args: [],
    );
  }

  /// `ประเภท`
  String get type {
    return Intl.message(
      'ประเภท',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `เพศ`
  String get gender {
    return Intl.message(
      'เพศ',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `นับสต๊อคสินค้า`
  String get productList {
    return Intl.message(
      'นับสต๊อคสินค้า',
      name: 'productList',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

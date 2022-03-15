import 'dart:html';

import 'package:dio/dio.dart' as dioo;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:metex_app/generated/l10n.dart';
import 'package:metex_app/models/userprofile_response.dart';
import 'package:metex_app/pages/pages.dart';
import 'package:metex_app/services/config.dart';
import 'package:metex_app/utils/utils.dart';
//import 'dart:io' show File;
//import 'dart:html' show File;
import 'package:image_picker/image_picker.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
//import 'package:universal_io/io.dart' show File;

class EditPicturePage extends StatefulWidget {
  late String userId;
  late String userName;
  late String userType;
  EditPicturePage(
      {Key? key,
      required this.userId,
      required this.userName,
      required this.userType})
      : super(key: key);

  @override
  State<EditPicturePage> createState() => _EditPicturePageState();
}

class _EditPicturePageState extends State<EditPicturePage> {
  TextEditingController emailController = new TextEditingController();

  // List<Widget> itemPhotosWidgetList = <Widget>[];
  // final ImagePicker _picker = ImagePicker();
  // File? file;
  // List<XFile>? photo = <XFile>[];
  // List<XFile> itemImagesList = <XFile>[];
  // late List<UserProfileData> userprofileList = [];
  //  PickedFile? pickedFile;

  List<Widget> itemPhotosWidgetList = <Widget>[];
  final ImagePicker _picker = ImagePicker();
  // File? file;
  XFile? photo;
  XFile? itemImagesList;
  late List<UserProfileData> userprofileList = [];
  PickedFile? pickedFile;

  bool uploading = false;
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  getUserProfile() async {
    var data = {"user_id": widget.userId};
    try {
      Uri url =
          Uri.parse(Config.BASE_URL + '/api/user/userprofile'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      //  print(response.body);

      if (response.statusCode == 200) {
        final UserProfileResponseModel userprofile =
            UserProfileResponseModel.fromJson(
                convert.jsonDecode(response.body));
        setState(() {
          userprofileList = userprofile.data;
        });
      } else {
        /* ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Logout ไปแล้ว')));*/
      }
    } catch (e) {
      print(e.toString());
    }
  }

  /* addImage() {
    // PickedFile? pickedFile;
    //PickedFile? pickedFile;
    itemPhotosWidgetList.clear();
    for (var bytes in photo!) {
      itemPhotosWidgetList.add(Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          height: 190.0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              child: kIsWeb
                  ? Image.network(File(bytes.path).path)
                  : Image.file(
                      File(bytes.path),
                    ),
            ),
          ),
        ),
      ));
    }

    for (int i = 0; i < itemImagesList.length; i++) {
      file = File(itemImagesList[i].path);
      pickedFile = PickedFile(file!.path);

      // await uploadImageToStorage(pickedFile, productId);
    }

    print('file ====>  $file');
    print('pickedFile ====>  $pickedFile');
  }
*/
  /* pickPhotoFromGallery() async {
    photo = await _picker.pickMultiImage();
    if (photo != null) {
      setState(() {
        // itemImagesList = itemImagesList + photo!;
        itemImagesList = photo!;
        addImage();
        photo!.clear();
        print(itemImagesList);
      });
    }
  }
*/
  addImage() {
    // PickedFile? pickedFile;
    //PickedFile? pickedFile;
    // itemPhotosWidgetList.clear();
    /* for (var bytes in photo as List) {
      itemPhotosWidgetList.add(Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          height: 190.0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              child: kIsWeb
                  ? Image.network(File(bytes.path).path)
                  : Image.file(
                      File(bytes.path),
                    ),
            ),
          ),
        ),
      ));
    }*/
    itemPhotosWidgetList.clear();
    var bytes = photo;
    itemPhotosWidgetList.add(Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        height: 190.0,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(child: Image.network((bytes!.path))),
        ),
      ),
    ));

    /* for (int i = 0; i < itemImagesList.length; i++) {
      file = File(itemImagesList[i].path);
      pickedFile = PickedFile(file!.path);

      // await uploadImageToStorage(pickedFile, productId);
    }*/

    /* print('file ====>  $file');
    print('pickedFile ====>  $pickedFile');*/
  }

  pickPhotoFromGallery() async {
    try {
      // Pick an image
      photo = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (photo != null) {
        // final imageTemporary = File(photo!.path);
        setState(() {
          // itemImagesList = itemImagesList + photo!;
          itemImagesList = photo!;
          // this.photo = imageTemporary as XFile?;
          addImage();
          print(itemImagesList);
          print('pickedFile ====>  $photo');
          print(
            photo!.path,
          );
          // print('imageTemporary ====>  $imageTemporary');
        });
      }
    } catch (e) {}
  }

  uploadAndSave() async {
    var data = {
      "image_1": photo!.path,
      "user_profile_id": userprofileList[0].userProfileId
    };
    print(userprofileList[0].userProfileId);

    var dio = Dio();
    dioo.Response response =
        await dio.post(Config.BASE_URL + '/api/user/upload-user-profile-image',
            data: FormData.fromMap({
              "user_profile_id": userprofileList[0].userProfileId,
              'image_1': dioo.MultipartFile.fromBytes(
                  await photo!.readAsBytes(),
                  filename: photo!.name,
                  contentType: MediaType.parse(photo!.mimeType!))
            }));
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Upload รูปภาพสำเร็จ')));
      // print(await response.stream.bytesToString());
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Upload รูปภาพไม่สำเร็จ')));
      //print(response.reasonPhrase);
    }

    /*Map<String, dynamic> map = Map();
    map["image_1"] = await http.MultipartFile.fromPath(
      'ImagePaths',
      photo!.path,
    );
    map["user_profile_id"] = userprofileList[0].userProfileId;*/

    /* try {
      Uri url = Uri.parse(
          Config.BASE_URL + 'api/user/upload-user-profile-image'); //url on web
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(data));
      print('uploadAndSave');
      print(pickedFile!.readAsBytes());
      if (response.statusCode == 200) {
        print(response.body);
        /* final UserProfileResponseModel userprofile =
            UserProfileResponseModel.fromJson(
                convert.jsonDecode(response.body));
        setState(() {
          userprofileList = userprofile.data;
          // print("======> " + userprofileList.length.toString());
        });*/
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Upload รูปภาพสำเร็จ')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Upload รูปภาพไม่สำเร็จ')));
      }
    } catch (e) {
      print(e.toString());
    }*/
    /* String path = photo!.path;
    Map<String, String> data = {
      "user_profile_id": userprofileList[0].userProfileId.toString(),
      // "email": userEmail!
    };

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data'
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Config.BASE_URL + 'api/user/upload-user-profile-image'),
    );

    request.fields.addAll(data);
    request.headers.addAll(headers);
    var multipartFile = await http.MultipartFile.fromPath(
        'image_1', path); //returns a Future<MultipartFile>
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonData = convert.jsonDecode(respStr);

    print(jsonData);
    print('response.statusCode ====== >' + response.statusCode.toString());
    if (response.statusCode == 200) {
      // success
      print(response.statusCode);
    } else {
      // error
    }*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('getUserProfile');
    print(widget.userId);
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      child: new Scaffold(
        /*appBar: AppBar(
            title: new Text('SingleChildScrollView Demo'),
          ),*/
        body: new SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            //  color: Colors.red,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
              //  bottom: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              //  left: MediaQuery.of(context).size.width * 0.07,
              // right: MediaQuery.of(context).size.width * 0.07,
            ),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 450,
                    height: 600,
                    //color: Colors.green,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ConstantWidget.getCustomTextWithoutAlign(
                              S.of(context).editpicture,
                              // Colors.black,
                              ConstantData.primaryColor,
                              FontWeight.w900,
                              32.0),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        itemPhotosWidgetList.isEmpty
                            ? Center(
                                child: MaterialButton(
                                  onPressed: pickPhotoFromGallery,
                                  child: Container(
                                    width: 250,
                                    height: 250,
                                    /* decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7.0)),
                                      color: ConstantData.whiteColor,
                                      border: Border.all(
                                          // color: Colors.blue,
                                          color: ConstantData.whiteColor,
                                          width: 1.0),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/no-image.png'),
                                          fit: BoxFit.cover),
                                    ),*/
                                    child: Icon(
                                      Icons.add_a_photo,
                                      size: 100,
                                      color: ConstantData.kGreyTextColor,
                                    ),
                                  ),
                                ),
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Wrap(
                                  spacing: 5.0,
                                  direction: Axis.horizontal,
                                  children: itemPhotosWidgetList,
                                  alignment: WrapAlignment.spaceEvenly,
                                  runSpacing: 10.0,
                                ),
                              ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        itemPhotosWidgetList.isEmpty
                            ? InkWell(
                                child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: ConstantData.primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: InkWell(
                                      child: Center(
                                        child: ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                // S.of(context).save,
                                                'อัพโหลดรูปภาพ',
                                                Colors.white,
                                                FontWeight.w900,
                                                ConstantData.font15Px),
                                      ),
                                    )),
                                onTap: () {
                                  pickPhotoFromGallery();
                                },
                              )
                            : Padding(
                                padding: EdgeInsets.only(bottom: 0),
                              ),
                        itemPhotosWidgetList.isNotEmpty
                            ? InkWell(
                                child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: ConstantData.primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: InkWell(
                                      child: Center(
                                        child: ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                S.of(context).save,
                                                Colors.white,
                                                FontWeight.w900,
                                                ConstantData.font15Px),
                                      ),
                                    )),
                                onTap: () {
                                  uploadAndSave();
                                },
                              )
                            : Padding(
                                padding: EdgeInsets.only(bottom: 0),
                              ),
                        itemPhotosWidgetList.isNotEmpty
                            ? InkWell(
                                child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        //gradient: Gradient.,
                                        border: Border.all(
                                            color: ConstantData.primaryColor),
                                        color: ConstantData.whiteColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: InkWell(
                                      child: Center(
                                        child: ConstantWidget
                                            .getCustomTextWithoutAlign(
                                                S.of(context).editpicture,
                                                ConstantData.primaryColor,
                                                FontWeight.w900,
                                                ConstantData.font15Px),
                                      ),
                                    )),
                                onTap: () {
                                  pickPhotoFromGallery();
                                },
                              )
                            : Padding(
                                padding: EdgeInsets.only(bottom: 0),
                              ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text('© metex')],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
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

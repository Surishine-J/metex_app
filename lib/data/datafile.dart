import 'package:metex_app/models/experts_model.dart';
import 'package:metex_app/models/group_model.dart';
import 'package:metex_app/models/models.dart';

class DataFile {
  static List<ExpertModel> getAllCategoryModel() {
    List<ExpertModel> subList = [];

    subList.addAll(getAllExpertModel()); //getSubCategoryModel()
    // subList.insertAll(subList.length - 1, getBeerCategoryModel());
    // subList.insertAll(subList.length - 1, getWineModel());
    return subList;
  }

  static List<ExpertModel> getAllExpertModel() {
    //getSubCategoryModel()
    List<ExpertModel> subList = [];

    ExpertModel mainModel = new ExpertModel();
    mainModel.catId = 5;
    mainModel.id = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Kraiput_In";
    mainModel.salary = "30,000";
    mainModel.gender = "ชาย";
    mainModel.image = ["profile/15/15-1615970522.jpg"];
    mainModel.province = "กรุงเทพมหานคร";
    mainModel.age = 30;
    mainModel.expertName = "Trainer";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.desc =
        "Each box contains 10 individually wrapped chocolate flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new ExpertModel();
    mainModel.catId = 5;
    mainModel.id = 2;
    mainModel.review = 3;
    mainModel.reviewDesc = "(3.0)";
    mainModel.name = "Dew Teerapap";
    mainModel.gender = "ชาย";
    mainModel.salary = "30,000";
    mainModel.image = ["profile/17/17-1616042658.jpg"];
    mainModel.age = 43;
    mainModel.expertName = "Consultant";
    mainModel.province = "เชียงใหม่";
    mainModel.desc =
        "Each box contains 10 individually wrapped chocolate flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new ExpertModel();
    mainModel.catId = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(2.5)";
    mainModel.id = 3;
    mainModel.name = "อนุสรณ์ หนองนา";
    mainModel.salary = "30,000";
    mainModel.gender = "ชาย";
    mainModel.image = ["profile/21/21-1616556075.jpg"];
    mainModel.age = 39;
    mainModel.expertName = "Trainer";
    mainModel.province = "เชียงใหม่";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.isFav = 1;
    mainModel.desc =
        "Each box contains 10 individually wrapped strawberry flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new ExpertModel();
    mainModel.catId = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(2.5)";
    mainModel.id = 3;
    mainModel.name = "เจ๊น้อย เจริญผล";
    mainModel.salary = "30,000";
    mainModel.gender = "ชาย";
    mainModel.image = [
      "profile/25/25-1627320485.jpeg",
      "cloth_sub2.jpg",
      "dog4.jpg",
      "cloth_sub3.jpg"
    ];
    mainModel.age = 0;
    mainModel.expertName = "-";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.province = "เชียงใหม่";
    mainModel.isFav = 1;
    mainModel.desc =
        "Each box contains 10 individually wrapped strawberry flavoured Sorbos Straws.";
    subList.add(mainModel);
    mainModel = new ExpertModel();
    mainModel.catId = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(2.5)";
    mainModel.id = 3;
    mainModel.name = "พวงเพ็ญ จันทร์งาม";
    mainModel.gender = "ชาย";
    mainModel.salary = "30,000";
    mainModel.image = [
      "profile/28/28-1627355103.jpg",
      "cloth_sub2.jpg",
      "dog4.jpg",
      "cloth_sub3.jpg"
    ];
    mainModel.age = 0;
    mainModel.expertName = "-";
    mainModel.province = "เชียงใหม่";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.isFav = 1;
    mainModel.desc =
        "Each box contains 10 individually wrapped strawberry flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new ExpertModel();
    mainModel.catId = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(2.5)";
    mainModel.id = 3;
    mainModel.name = "พิสิษฐ์ สุขสวัสดิ์";
    mainModel.gender = "ชาย";
    mainModel.salary = "30,000";
    mainModel.image = [
      "profile/27/27-1627354793.jpg",
      "cloth_sub2.jpg",
      "dog4.jpg",
      "cloth_sub3.jpg"
    ];
    mainModel.age = 39;
    mainModel.expertName = "-";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.province = "เชียงใหม่";
    mainModel.isFav = 1;
    mainModel.desc =
        "Each box contains 10 individually wrapped strawberry flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new ExpertModel();
    mainModel.catId = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(2.5)";
    mainModel.id = 3;
    mainModel.name = "พิสิษฐ์ สุขสวัสดิ์";
    mainModel.gender = "ชาย";
    mainModel.salary = "30,000";
    mainModel.image = [
      "profile/27/27-1627354793.jpg",
    ];
    mainModel.age = 39;
    mainModel.expertName = "-";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.province = "เชียงใหม่";
    mainModel.isFav = 1;
    mainModel.desc =
        "Each box contains 10 individually wrapped strawberry flavoured Sorbos Straws.";
    subList.add(mainModel);

    return subList;
  }

  static List<CustomerModel> getCustomerModel() {
    List<CustomerModel> subList = [];

    subList.addAll(getAllCustomerModel()); //getSubCategoryModel()

    return subList;
  }

  static List<CustomerModel> getAllCustomerModel() {
    //getSubCategoryModel()
    List<CustomerModel> subList = [];

    CustomerModel mainModel = new CustomerModel();
    mainModel.catId = 5;
    mainModel.id = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "Kraiput_In";
    mainModel.image = ["profile/15/15-1615970522.jpg"];
    mainModel.province = "กรุงเทพมหานคร";
    mainModel.age = 30;
    mainModel.expertName = "Trainer";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.desc =
        "Each box contains 10 individually wrapped chocolate flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new CustomerModel();
    mainModel.catId = 5;
    mainModel.id = 2;
    mainModel.review = 3;
    mainModel.reviewDesc = "(3.0)";
    mainModel.name = "Dew Teerapap";
    mainModel.image = ["profile/17/17-1616042658.jpg"];
    mainModel.age = 43;
    mainModel.expertName = "Consultant";
    mainModel.province = "เชียงใหม่";
    mainModel.desc =
        "Each box contains 10 individually wrapped chocolate flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new CustomerModel();
    mainModel.catId = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(2.5)";
    mainModel.id = 3;
    mainModel.name = "อนุสรณ์ หนองนา";
    mainModel.image = ["profile/21/21-1616556075.jpg"];
    mainModel.age = 39;
    mainModel.expertName = "Trainer";
    mainModel.province = "เชียงใหม่";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.isFav = 1;
    mainModel.desc =
        "Each box contains 10 individually wrapped strawberry flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new CustomerModel();
    mainModel.catId = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(2.5)";
    mainModel.id = 3;
    mainModel.name = "เจ๊น้อย เจริญผล";
    mainModel.image = [
      "profile/25/25-1627320485.jpeg",
    ];
    mainModel.age = 0;
    mainModel.expertName = "-";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.province = "เชียงใหม่";
    mainModel.isFav = 1;
    mainModel.desc =
        "Each box contains 10 individually wrapped strawberry flavoured Sorbos Straws.";
    subList.add(mainModel);
    mainModel = new CustomerModel();
    mainModel.catId = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(2.5)";
    mainModel.id = 3;
    mainModel.name = "พวงเพ็ญ จันทร์งาม";
    mainModel.image = [
      "profile/28/28-1627355103.jpg",
    ];
    mainModel.age = 0;
    mainModel.expertName = "-";
    mainModel.province = "เชียงใหม่";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.isFav = 1;
    mainModel.desc =
        "Each box contains 10 individually wrapped strawberry flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new CustomerModel();
    mainModel.catId = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(2.5)";
    mainModel.id = 3;
    mainModel.name = "พิสิษฐ์ สุขสวัสดิ์";
    mainModel.image = [
      "profile/27/27-1627354793.jpg",
    ];
    mainModel.age = 39;
    mainModel.expertName = "-";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.province = "เชียงใหม่";
    mainModel.isFav = 1;
    mainModel.desc =
        "Each box contains 10 individually wrapped strawberry flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new CustomerModel();
    mainModel.catId = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(2.5)";
    mainModel.id = 3;
    mainModel.name = "พิสิษฐ์ สุขสวัสดิ์";
    mainModel.image = [
      "profile/27/27-1627354793.jpg",
    ];
    mainModel.age = 39;
    mainModel.expertName = "-";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.province = "เชียงใหม่";
    mainModel.isFav = 1;
    mainModel.desc =
        "Each box contains 10 individually wrapped strawberry flavoured Sorbos Straws.";
    subList.add(mainModel);

    return subList;
  }

  static List<GroupModel> getGroupModel() {
    //getSubCategoryModel()
    List<GroupModel> subList = [];

    GroupModel mainModel = new GroupModel();
    mainModel.id = 1;
    mainModel.ownername = "Kraiput_In";
    mainModel.groupname = "กลุ่มทดสอบ 1";
    mainModel.membername = ["kookkai"];
    mainModel.imagegroup = ["groups/ai.jpg"];
    mainModel.imagemember = ["profile/15/15-1615970522.jpg"];

    subList.add(mainModel);

    mainModel = new GroupModel();
    mainModel.id = 1;
    mainModel.ownername = "Kraiput_In";
    mainModel.groupname = "กลุ่มทดสอบ 2";
    mainModel.membername = ["kookkai"];
    mainModel.imagegroup = ["no-image.png"];
    mainModel.imagemember = ["profile/15/15-1615970522.jpg"];

    subList.add(mainModel);

    mainModel = new GroupModel();
    mainModel.id = 1;
    mainModel.ownername = "Kraiput_In";
    mainModel.groupname = "กลุ่มทดสอบ 3";
    mainModel.membername = ["kookkai"];
    mainModel.imagegroup = ["no-image.png"];
    mainModel.imagemember = ["profile/15/15-1615970522.jpg"];

    subList.add(mainModel);
    mainModel = new GroupModel();
    mainModel.id = 1;
    mainModel.ownername = "Kraiput_In";
    mainModel.groupname = "กลุ่มทดสอบ 4";
    mainModel.membername = ["kookkai"];
    mainModel.imagegroup = ["no-image.png"];
    mainModel.imagemember = ["profile/15/15-1615970522.jpg"];

    subList.add(mainModel);
    mainModel = new GroupModel();
    mainModel.id = 1;
    mainModel.ownername = "Kraiput_In";
    mainModel.groupname = "กลุ่มทดสอบ 5";
    mainModel.membername = ["kookkai"];
    mainModel.imagegroup = ["groups/ai.jpg"];
    mainModel.imagemember = ["profile/15/15-1615970522.jpg"];
    subList.add(mainModel);

  

    return subList;
  }

  static List<SubCategoryModel> getBeerCategoryModel() {
    List<SubCategoryModel> subList = [];

    SubCategoryModel mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "เบียร์ช้าง";
    mainModel.image = ["beerchang.png", "cloth_sub2.jpg", "cloth_sub3.jpg"];
    mainModel.price = 10.50;
    mainModel.priceCurrency = "฿";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.desc =
        "Each box contains 10 individually wrapped chocolate flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 2;
    mainModel.review = 3;
    mainModel.reviewDesc = "(3.0)";
    mainModel.name = "เบียร์ลีโอกระป๋อง";
    mainModel.image = ["beerleocan.jpg", "dog4.jpg", "cloth_sub2.jpg"];
    mainModel.price = 5.95;
    mainModel.priceCurrency = "฿";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.desc =
        "Each box contains 10 individually wrapped chocolate flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(2.5)";
    mainModel.id = 3;
    mainModel.name = "เบียร์ช้างกระป๋อง";
    mainModel.image = [
      "beerchangcan.jpeg",
      "cloth_sub2.jpg",
      "dog4.jpg",
      "cloth_sub3.jpg"
    ];
    mainModel.price = 20.95;
    mainModel.priceCurrency = "฿";
    mainModel.isFav = 1;
    mainModel.desc =
        "Each box contains 10 individually wrapped strawberry flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(2.5)";
    mainModel.id = 3;
    mainModel.name = "เบียร์ไฮเนเกน";
    mainModel.image = [
      "beerheineken.jpg",
      "cloth_sub2.jpg",
      "dog4.jpg",
      "cloth_sub3.jpg"
    ];
    mainModel.price = 20.95;
    mainModel.priceCurrency = "฿";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.isFav = 1;
    mainModel.desc =
        "Each box contains 10 individually wrapped strawberry flavoured Sorbos Straws.";
    subList.add(mainModel);

    return subList;
  }

  static List<SubCategoryModel> getWineModel() {
    List<SubCategoryModel> subList = [];

    SubCategoryModel mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 1;
    mainModel.review = 3;
    mainModel.reviewDesc = "(4.8)";
    mainModel.name = "ไวน์";
    mainModel.image = ["wine.jpg", "cloth_sub2.jpg", "cloth_sub3.jpg"];
    mainModel.price = 10.50;
    mainModel.priceCurrency = "฿";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.desc =
        "Each box contains 10 individually wrapped edible Sorbos EcoStraws.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.id = 2;
    mainModel.review = 3;
    mainModel.reviewDesc = "(3.0)";
    mainModel.name = "ไวน์";
    mainModel.image = ["wine.jpg", "dog4.jpg", "cloth_sub2.jpg"];
    mainModel.price = 5.95;
    mainModel.priceCurrency = "฿";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.desc =
        "Each box contains 10 individually wrapped chocolate flavoured Sorbos Straws.";
    subList.add(mainModel);

    mainModel = new SubCategoryModel();
    mainModel.catId = 5;
    mainModel.review = 3;
    mainModel.reviewDesc = "(2.5)";
    mainModel.id = 3;
    mainModel.name = "ไวน์";
    mainModel.image = [
      "wine.jpg",
      "cloth_sub2.jpg",
      "dog4.jpg",
      "cloth_sub3.jpg"
    ];
    mainModel.price = 20.95;
    mainModel.priceCurrency = "฿";
    mainModel.availability = "เหลือ 10 ขวด";
    mainModel.isFav = 1;
    mainModel.desc =
        "Each box contains 10 individually wrapped strawberry flavoured Sorbos Straws.";
    subList.add(mainModel);

    return subList;
  }

  /*static ProfileModel getProfileModel() {
    ProfileModel mainModel = new ProfileModel();
    mainModel.email = "kookkai_jaidee@gamil.com";
    mainModel.name = "Kookkai Jaidee";
    mainModel.image = "assets/images/JoodCat.jpg";
    return mainModel;
  }*/

  static List<String> getSearchList() {
    List<String> subList = [];
    List<CategoryModel> allList = getCategoryModel();

    for (int i = 0; i < allList.length; i++) {
      if (!subList.contains(allList[i].name)) {
        subList.add(allList[i].name);
      }
    }

    return subList;
  }

  static List<CategoryModel> getCategoryModel() {
    late List<CategoryModel> introList = [];

    CategoryModel mainModel = new CategoryModel();
    mainModel.id = 1;
    mainModel.name = "Eco Cups";
    mainModel.icon = "drink.png";
    mainModel.desc = "5 Items";
    mainModel.image = "eco_cups.png";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 2;
    mainModel.name = "ToothBrush";
    mainModel.icon = "toothbrushes.png";
    mainModel.image = "collapsible_straws.jpg";
    mainModel.desc = "4 Items";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 3;
    mainModel.name = "Chair";
    mainModel.icon = "chair.png";
    mainModel.desc = "5 Items";
    mainModel.image = "eco_bottles.jpg";
    introList.add(mainModel);

    mainModel = new CategoryModel();
    mainModel.id = 4;
    mainModel.name = "Bag";
    mainModel.icon = "shopping-bag.png";
    mainModel.desc = "5 Items";
    mainModel.image = "bamboo_straws.jpg";
    introList.add(mainModel);
    return introList;
  }
}

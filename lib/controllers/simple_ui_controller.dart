import 'package:fetch_image_via_getx/model/photo_model.dart';
import 'package:fetch_image_via_getx/service/api_service.dart';
import 'package:get/get.dart';

class SimpleUiController extends GetxController {
  var selectedIndex = 0.obs;
  RxList<PhotoModel> photo = RxList();
  RxBool isLoading = true.obs;
  RxString orderBy = "latest".obs;
  
  List<String> orders = [
    "latest",
    "popular",
    "oldest",
    "views",
  ];

  //get
  getPhoto() async {
    isLoading.value = true;
    var response = await ApiService().getMethod(
        'https://api.unsplash.com/photos/?per_page=30&order_by=${orderBy.value}oldest&client_id=8r7hznUswxlk32AM40psd5U7dgaATwKOcTLtOAlxRmU');
    photo = RxList();
    if (response.statusCode == 200) {
      response.data.forEach((elm) {
        photo.add(PhotoModel.fromJson(elm));
      });
      isLoading.value = false;
    }
  }
  
  orderFunc(String newVal) {
    orderBy.value = newVal;
    getPhoto();
  }
  
  @override
  void onInit() {
    getPhoto();
    super.onInit();
  }
  
}

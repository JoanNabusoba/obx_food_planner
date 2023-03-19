import 'package:foodplanner_app/backend/main_controller.dart';
import 'package:get/get.dart';

//import 'authcontroller_alt.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());
  }
}

import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:gsp/Controller/control.dart';

class Controller_binding extends Bindings{
  @override
  void dependencies() {
    Get.put(Controller());
  }



}
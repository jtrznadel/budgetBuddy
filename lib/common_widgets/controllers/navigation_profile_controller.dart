import 'package:get/get.dart';

class NavigationProfileController extends GetxController {
  // Other controller logic and state management
  // ...

  @override
  void onClose() {
    // Dispose of resources here (if needed)
    // For example, close streams, cancel animations, etc.
    super.onClose();
  }

  var currentIndex = 2.obs; // Set the initial index to 2 (DashboardScreen)

  void changePage(int index) {
    currentIndex.value = index;
  }
}

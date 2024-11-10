import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class SearchController extends GetxController {
  var searchQuery = ''.obs;
  var debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  var search = ''.obs;

  void onSearch(String value) {
    searchQuery.value = value;
    debouncer(() {
      search.value = value;
      print('Searching for $value');
    });
  }
}

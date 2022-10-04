import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FiltersController extends GetxController {

  RxList<String> selectedCategories = RxList<String>();

  TextEditingController searchController = TextEditingController();

  RxString searchText = RxString('');

  changeSelectedCategories(List<String> categoryList) {
    selectedCategories.value = categoryList;
  }

}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:raft_assignment/views/widgets/app_button.dart';
import 'package:raft_assignment/views/widgets/loading_button.dart';

import '../controllers/filter_controller.dart';
import '../data.dart';


class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: isLoading == true ? const LoadingButton() : AppButton(title: 'Fetch Data',callback: fetchDataCallback)
    );

  }


  fetchDataCallback() async {

    setState(() { isLoading = true; });

    http.Response response = await http.get(Uri.parse('https://api.publicapis.org/entries'));

    if(response.statusCode == 200) {

      await DataRepository.apiBox.clear();
      await DataRepository.categoriesBox.clear();

      List<String> tempCategoryList = [];

      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      for(Map<String, dynamic> apiMap in decodedResponse['entries']) {
        int x = await DataRepository.apiBox.add(apiMap);
        if(!tempCategoryList.contains(apiMap['Category'])) {
          tempCategoryList.add(apiMap['Category']);
        }
      }

      await DataRepository.categoriesBox.addAll(tempCategoryList);

      Fluttertoast.showToast(msg: 'Data fetched successfully, displayed on Page 2');

      setState(() { isLoading = false; });

    }
    else {
      Fluttertoast.showToast(msg: 'Error on API call : ${response.statusCode}');
      setState(() { isLoading = false; });
    }

    Get.put(FiltersController()).searchController.text = '';
    Get.put(FiltersController()).selectedCategories.value = [];

  }

}



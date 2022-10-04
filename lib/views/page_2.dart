import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raft_assignment/controllers/filter_controller.dart';
import 'package:raft_assignment/models/api_model.dart';
import 'package:raft_assignment/views/widgets/category_bottom_sheet.dart';

import '../data.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {

  final FiltersController _filtersController = Get.put(FiltersController());

  @override
  void initState() {
    _filtersController.searchController.addListener(() {
      _filtersController.searchText.value = _filtersController.searchController.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(child: TextField(controller: _filtersController.searchController, decoration: const InputDecoration(hintText: 'Search for description'))),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: showFilterBottomSheet,
                  child: const Icon(Icons.filter_alt, size: 24)
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GetX<FiltersController>(
            init: FiltersController(),
            builder: (controller) {

              List<APIModel> apiList = [];
              List<APIModel> filteredAPIList = [];

              for(var apiMap in DataRepository.apiBox.values) {
                apiList.add(APIModel.fromJson(jsonDecode(jsonEncode(apiMap))));
              }

              if(controller.searchText.value != '') {
                for(var apiMap in apiList) {
                  if(apiMap.description.toLowerCase().contains(_filtersController.searchController.text.toLowerCase())) {
                    filteredAPIList.add(apiMap);
                  }
                }
              }
              else {
                filteredAPIList = List.from(apiList);
              }

              List<APIModel> finalCategoryList = [];

              if(_filtersController.selectedCategories.isNotEmpty) {

                for(int i=0;i<filteredAPIList.length;i++) {
                  if(_filtersController.selectedCategories.contains(filteredAPIList[i].category) == true) {
                    finalCategoryList.add(filteredAPIList[i]);
                  }
                }

              }
              else {
                finalCategoryList = List.from(filteredAPIList);
              }

              return ListView.builder(
                itemCount: finalCategoryList.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, right: 20, left: 20),
                      child: APICard(apiModel: finalCategoryList[index])
                  );
                },
              );
            }
          ),
        ),
      ],
    );

  }


  showFilterBottomSheet() {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.black.withOpacity(0.3),
          builder: (context) {
            return BottomSheet(
                onClosing: () {},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                builder: (context) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                    child: CategoryBottomSheet(),
                  );
                }
            );
          }
      );
    }

}




class APICard extends StatelessWidget {

  final APIModel apiModel;

  const APICard({Key? key, required this.apiModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 1, blurRadius: 3)]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(apiModel.name, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(20)),
                child: Text(apiModel.category, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(apiModel.description, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 20),
          Text(apiModel.url, style: const TextStyle(color: Colors.blueAccent, decoration: TextDecoration.underline)),
          const SizedBox(height: 20),
          Container(width: MediaQuery.of(context).size.width, height: 1.5, color: Theme.of(context).backgroundColor),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Auth', style: Theme.of(context).textTheme.bodyMedium),
              Text(apiModel.auth == '' ? 'none' : apiModel.auth, style: const TextStyle(fontWeight: FontWeight.w600))
            ],
          ),
          const SizedBox(height: 10),
          Container(width: MediaQuery.of(context).size.width, height: 1.5, color: Theme.of(context).backgroundColor),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Is HTTPS', style: Theme.of(context).textTheme.bodyMedium),
              Text(apiModel.isHttps.toString(), style: const TextStyle(fontWeight: FontWeight.w600))
            ],
          ),
          const SizedBox(height: 10),
          Container(width: MediaQuery.of(context).size.width, height: 1.5, color: Theme.of(context).backgroundColor),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Is Cors', style: Theme.of(context).textTheme.bodyMedium),
              Text(apiModel.isCors, style: const TextStyle(fontWeight: FontWeight.w600))
            ],
          ),
        ],
      ),
    );
  }
}
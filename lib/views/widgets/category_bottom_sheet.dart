import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raft_assignment/controllers/filter_controller.dart';
import 'package:raft_assignment/models/category_model.dart';

import '../../data.dart';

class CategoryBottomSheet extends StatefulWidget {
  const CategoryBottomSheet({Key? key}) : super(key: key);

  @override
  State<CategoryBottomSheet> createState() => _CategoryBottomSheetState();
}

class _CategoryBottomSheetState extends State<CategoryBottomSheet> {

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).bottomSheetTheme.backgroundColor,
      ),
      child: GetX<FiltersController>(
        init: FiltersController(),
        builder: (controller) {

          List<CategoryModel> categoryList = [];

          for(var apiMap in DataRepository.categoriesBox.values) {
            String category = jsonDecode(jsonEncode(apiMap));
            if(controller.selectedCategories.contains(category)) {
              categoryList.add(CategoryModel(category: category, isSelected: true));
            }
            else {
              categoryList.add(CategoryModel(category: category, isSelected: false));
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Filters', style: Theme.of(context).textTheme.headline6),
                  const SizedBox(width: 10),
                  Text('(${controller.selectedCategories.length} Selected)', style: Theme.of(context).textTheme.bodyMedium),
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close)
                  )
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView(
                    children: List.generate(categoryList.length, (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: CategoryButton(categoryModel: categoryList[index]),
                    ))
                ),
              ),
            ],
          );
        }
      )
    );
  }
}



class CategoryButton extends StatelessWidget {

  final CategoryModel categoryModel;

  const CategoryButton({Key? key, required this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(categoryModel.isSelected == true) {
          Get.put(FiltersController()).selectedCategories.remove(categoryModel.category);
        }
        else {
          Get.put(FiltersController()).selectedCategories.add(categoryModel.category);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: categoryModel.isSelected == true ? Theme.of(context).colorScheme.secondary : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(60)
        ),
        child: Center(child: Text(categoryModel.category, style: categoryModel.isSelected == true ? const TextStyle(color: Colors.black) : null)),
      ),
    );
  }
}

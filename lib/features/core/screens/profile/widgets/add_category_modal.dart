import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/core/controllers/categories_controller.dart';
import 'package:budget_buddy/features/core/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCategoryModal extends StatefulWidget {
  const AddCategoryModal({Key? key}) : super(key: key);

  @override
  State<AddCategoryModal> createState() => _AddCategoryModalState();
}

class _AddCategoryModalState extends State<AddCategoryModal> {
  var selectedIcon = 0xe390;

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoriesController());
    final TextEditingController categoryNameController = TextEditingController();

    List<int> icons = [0xe390, 0xe483, 0xf0871, 0xe5e5, 0xf3e1];
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding)
          .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + kDefaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Add Category',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: categoryNameController,
                  decoration: const InputDecoration(
                    labelText: 'Category Name',
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Selected Icon',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Icon(
                    IconData(selectedIcon, fontFamily: 'MaterialIcons'),
                    size: 32,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Select one of the icons below:'),
          Flexible(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 5,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(IconData(icons[index], fontFamily: 'MaterialIcons')),
                  onPressed: () {
                    setState(() {
                      selectedIcon = icons[index];
                    });
                  },
                );
              }),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String categoryName = categoryNameController.text.trim();
              CategoryModel category = CategoryModel(
                name: categoryName,
                icon: selectedIcon.toString(),
              );
              categoryController.addCategory(category);
              Navigator.pop(context); // Zamknij modal po dodaniu kategorii
            },
            child: const Text('Add Category'),
          ),
        ],
      ),
    );
  }
}

import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/core/models/category_model.dart';
import 'package:budget_buddy/features/core/screens/profile/widgets/add_category_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

class EditCategoriesModal extends StatelessWidget {
  final List<CategoryModel> userCategories;

  const EditCategoriesModal({required this.userCategories, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return Container(
      height: size * 0.5,
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          const Text(
            'Edit Categories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          userCategories.isEmpty
              ? Expanded(
                  child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    children: [
                      SizedBox(
                          height: size * 0.2,
                          child: SvgPicture.asset('assets/images/notFoundImage.svg')),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('You have not added any categories yet')
                    ],
                  ),
                ))
              : Expanded(
                  child: ListView.builder(
                    itemCount: userCategories.length,
                    itemBuilder: (context, index) {
                      final category = userCategories[index];
                      return Slidable(
                        key: Key(category.name!),
                        startActionPane:
                            ActionPane(motion: const ScrollMotion(), children: [
                          SlidableAction(
                              onPressed: (context) {},
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(0),
                              icon: Icons.delete,
                              label: 'Delete',
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25))),
                        ]),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                                // An action can be bigger than the others.
                                flex: 2,
                                onPressed: (context) {},
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Edit',
                                padding: const EdgeInsets.all(0),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    bottomLeft: Radius.circular(25))),
                          ],
                        ),
                        child: ListTile(
                          title: Text(category.name!),
                          leading: Icon(IconData(int.parse(category.icon!),
                              fontFamily: 'MaterialIcons')),
                        ),
                      );
                    },
                  ),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              backgroundColor: kPrimaryColor,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return const AddCategoryModal();
                  },
                );
              },
              label: const Text('Add New Category'),
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

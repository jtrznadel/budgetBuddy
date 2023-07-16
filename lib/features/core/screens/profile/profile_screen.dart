import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/authentication/controllers/login_controller.dart';
import 'package:budget_buddy/features/core/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var loginController = Get.put(LogInController());
    final List<CategoryModel> userCategories = [
      CategoryModel(name: 'Category 1', icon: '0xe5f9'),
      CategoryModel(name: 'Category 2', icon: '0xe5f9'),
      CategoryModel(name: 'Category 3', icon: '0xe5fa'),
    ];
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding)
            .copyWith(top: kDefaultPadding * 1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/avatarImage.jpg'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                const Text(
                  "John Doe",
                  style: TextStyle(
                    fontSize: 24,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        size: 24,
                        color: kPrimaryColor,
                      ),
                      label: const Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => EditCategoriesModal(
                            userCategories: userCategories,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add_to_photos_rounded,
                        size: 24,
                        color: kPrimaryColor,
                      ),
                      label: const Text(
                        'Edit Categories',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.settings,
                        size: 24,
                        color: kPrimaryColor,
                      ),
                      label: const Text(
                        'Settings',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_active,
                        size: 24,
                        color: kPrimaryColor,
                      ),
                      label: const Text(
                        'Reminders',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.question_mark_rounded,
                        size: 24,
                        color: kPrimaryColor,
                      ),
                      label: const Text(
                        'FAQ',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.phone,
                        size: 24,
                        color: kPrimaryColor,
                      ),
                      label: const Text(
                        'Contact',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Divider(
                  color: kPrimaryColor.withOpacity(0.5),
                  thickness: 1.0,
                ),
                TextButton.icon(
                  onPressed: () {
                    loginController.logout();
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                    size: 24,
                    color: Colors.deepOrange,
                  ),
                  label: Text(
                    'Log Out',
                    style: TextStyle(
                        fontSize: 18, color: Colors.black.withOpacity(0.5)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EditCategoriesModal extends StatelessWidget {
  final List<CategoryModel> userCategories;

  const EditCategoriesModal({required this.userCategories, Key? key})
      : super(key: key);

  int doNothing() {
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
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
          Expanded(
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
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ]),
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                          // An action can be bigger than the others.
                          flex: 2,
                          onPressed: (context) {},
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          icon: Icons.archive,
                          label: 'Archive',
                          padding: const EdgeInsets.all(0),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
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
        ],
      ),
    );
  }
}

import 'package:budget_buddy/constants/color_palette.dart';
import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/authentication/controllers/login_controller.dart';
import 'package:budget_buddy/features/core/controllers/categories_controller.dart';
import 'package:budget_buddy/features/core/controllers/user_controller.dart';
import 'package:budget_buddy/features/core/screens/profile/widgets/edit_categories_widget.dart';
import 'package:budget_buddy/features/core/screens/profile/widgets/edit_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var loginController = Get.put(LogInController());
    var categoriesController = Get.put(CategoriesController());
    var userController = Get.find<UserController>();
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Padding(
        padding:
            const EdgeInsets.all(kDefaultPadding).copyWith(top: kDefaultPadding * 1.5),
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
                        backgroundImage: AssetImage('assets/images/avatarImage.jpg'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  '${userController.user.value.firstName} ${userController.user.value.lastName}',
                  style: const TextStyle(
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
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) =>
                              EditProfileModal(user: userController.user.value),
                        );
                      },
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
                          isScrollControlled: true,
                          builder: (context) => EditCategoriesModal(
                            userCategories: categoriesController.userCategories,
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
                    style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.5)),
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

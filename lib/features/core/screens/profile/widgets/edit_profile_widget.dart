import 'package:budget_buddy/constants/sizes.dart';
import 'package:budget_buddy/features/core/controllers/user_controller.dart';
import 'package:budget_buddy/features/core/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileModal extends StatefulWidget {
  final UserModel user;

  const EditProfileModal({super.key, required this.user});

  @override
  _EditProfileModalState createState() => _EditProfileModalState();
}

class _EditProfileModalState extends State<EditProfileModal> {
  bool isEditing = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.user.firstName ?? '';
    lastNameController.text = widget.user.lastName ?? '';
    emailController.text = widget.user.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding)
          .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + kDefaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Edit Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: emailController,
            enabled: isEditing,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: firstNameController,
            enabled: isEditing,
            decoration: const InputDecoration(labelText: 'First Name'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: lastNameController,
            enabled: isEditing,
            decoration: const InputDecoration(labelText: 'Last Name'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (isEditing) {
                // Save changes and update user profile
                // For simplicity, we'll just print the changes here
                UserController userController = Get.find<UserController>();
                UserModel updatedUser = UserModel(
                  email: emailController.text,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                );
                userController.updateUserData(updatedUser);
              }
              setState(() {
                isEditing = !isEditing;
              });
            },
            child: Text(isEditing ? 'Save Changes' : 'Edit Profile'),
          ),
        ],
      ),
    );
  }
}
